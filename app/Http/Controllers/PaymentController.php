<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Models\Payment;
use App\Models\FeeAssignment;
use App\Models\Student;

class PaymentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $payments = Payment::leftJoin('fee_assignments', 'payments.fee_assignment_id', '=', 'fee_assignments.id')
            ->leftJoin('students', 'fee_assignments.student_id', '=', 'students.id')
            ->leftJoin('users', 'payments.cancelled_by_user_id', '=', 'users.id')
            ->select([
                'payments.*',
                'fee_assignments.academic_year',
                'fee_assignments.assigned_fee',
                'fee_assignments.adjusted_fee',
                'fee_assignments.adjustment_reason',
                'fee_assignments.status as fee_assignment_status',
                'students.id as student_id',
                'students.admission_number',
                'students.name',
                'students.current_grade',
                'students.current_class',
                'users.name as cancelled_by_name'
            ])
            ->orderBy('payments.created_at', 'desc')
            ->get();

        $transformedPayments = $payments->map(function ($payment) {
            return [
                'id' => $payment->id,
                'fee_assignment_id' => $payment->fee_assignment_id,
                'receipt_number' => $payment->receipt_number,
                'payment_date' => $payment->payment_date,
                'amount_paid' => $payment->amount_paid,
                'payment_method' => $payment->payment_method,
                'reference_number' => $payment->reference_number,
                'deposit_date' => $payment->deposit_date,
                'bank_name' => $payment->bank_name,
                'is_realized' => $payment->is_realized,
                'cancelled' => $payment->cancelled,
                'cancellation_date' => $payment->cancellation_date,
                'cancellation_reason' => $payment->cancellation_reason,
                'created_at' => $payment->created_at,
                'updated_at' => $payment->updated_at,
                'feeAssignment' => $payment->student_id ? [
                    'id' => $payment->fee_assignment_id,
                    'academic_year' => $payment->academic_year,
                    'assigned_fee' => $payment->assigned_fee,
                    'adjusted_fee' => $payment->adjusted_fee,
                    'adjustment_reason' => $payment->adjustment_reason,
                    'status' => $payment->fee_assignment_status,
                    'student' => [
                        'id' => $payment->student_id,
                        'admission_number' => $payment->admission_number,
                        'name' => $payment->name,
                        'current_grade' => $payment->current_grade,
                        'current_class' => $payment->current_class,
                    ]
                ] : null,
                'cancelledBy' => $payment->cancelled_by_user_id ? [
                    'id' => $payment->cancelled_by_user_id,
                    'name' => $payment->cancelled_by_name
                ] : null
            ];
        });

        return Inertia::render('Payments/Index', [
            'payments' => $transformedPayments
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        return Inertia::render('Payments/Form', [
            'isEdit' => false
        ]);
    }

    /**
     * Search for students by name or admission number.
     */
    public function searchStudents(Request $request)
    {
        $query = $request->query('q', '');

        if (empty($query)) {
            return response()->json([]);
        }

        $students = Student::where('admission_number', 'like', "%{$query}%")
            ->orWhere('name', 'like', "%{$query}%")
            ->orderBy('name')
            ->limit(10)
            ->get(['id', 'admission_number', 'name', 'current_grade', 'current_class']);

        return response()->json($students);
    }

    /**
     * Get unpaid fee assignments for a specific student.
     */
    public function getStudentAssignments(Request $request, $studentId)
    {
        $student = Student::findOrFail($studentId);

        $assignments = FeeAssignment::with('student')
            ->where('student_id', $studentId)
            ->whereIn('status', ['Unpaid', 'Partially Paid'])
            ->get()
            ->map(function ($assignment) {
                $assignment->unpaid_amount = $assignment->getUnpaidAmount();
                return $assignment;
            });

        return response()->json([
            'student' => $student,
            'assignments' => $assignments
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'fee_assignment_ids' => 'required|array|min:1',
            'fee_assignment_ids.*' => 'exists:fee_assignments,id',
            'receipt_number' => 'required|string|unique:payments',
            'payment_date' => 'required|date',
            'payment_method' => 'required|in:Cash,Cheque,Online',
            'reference_number' => 'nullable|string',
            'deposit_date' => 'nullable|date|required_if:payment_method,Cheque',
            'bank_name' => 'nullable|string|required_if:payment_method,Cheque',
            'is_realized' => 'boolean',
        ]);

        $feeAssignmentIds = $validated['fee_assignment_ids'];
        $assignments = FeeAssignment::whereIn('id', $feeAssignmentIds)->get();

        $studentIds = $assignments->pluck('student_id')->unique();
        if ($studentIds->count() > 1) {
            return back()->withErrors([
                'fee_assignment_ids' => 'All selected assignments must belong to the same student.'
            ]);
        }

        $totalAmount = 0;
        $payments = [];

        foreach ($assignments as $index => $assignment) {
            $unpaidAmount = $assignment->getUnpaidAmount();

            if ($unpaidAmount <= 0) {
                continue;
            }

            $receiptNumber = count($assignments) > 1
                ? $validated['receipt_number'] . '-' . ($index + 1)
                : $validated['receipt_number'];

            $paymentData = [
                'fee_assignment_id' => $assignment->id,
                'receipt_number' => $receiptNumber,
                'payment_date' => $validated['payment_date'],
                'amount_paid' => $unpaidAmount,
                'payment_method' => $validated['payment_method'],
                'reference_number' => $validated['reference_number'],
                'deposit_date' => $validated['deposit_date'] ?? null,
                'bank_name' => $validated['bank_name'] ?? null,
                'is_realized' => $validated['payment_method'] === 'Cash' ? true : ($validated['is_realized'] ?? false),
            ];

            $payments[] = Payment::create($paymentData);
            $totalAmount += $unpaidAmount;
        }

        return redirect()->route('payments.index')->with('success',
            count($payments) . ' payment(s) recorded successfully for Rs. ' . number_format($totalAmount, 2)
        );
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $payment = Payment::with(['feeAssignment.student', 'cancelledBy'])->findOrFail($id);
        return Inertia::render('Payments/Show', [
            'payment' => $payment
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $payment = Payment::with(['feeAssignment.student'])->findOrFail($id);

        $students = Student::orderBy('name')->get();

        $feeAssignments = FeeAssignment::with('student')
            ->whereIn('status', ['Unpaid', 'Partially Paid'])
            ->orWhere('id', $payment->fee_assignment_id)
            ->get()
            ->map(function ($assignment) {
                $assignment->unpaid_amount = $assignment->getUnpaidAmount();
                return $assignment;
            });

        return Inertia::render('Payments/Form', [
            'payment' => $payment,
            'students' => $students,
            'feeAssignments' => $feeAssignments,
            'isEdit' => true
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $payment = Payment::findOrFail($id);

        $validated = $request->validate([
            'fee_assignment_id' => 'required|exists:fee_assignments,id',
            'receipt_number' => 'required|unique:payments,receipt_number,' . $id,
            'payment_date' => 'required|date',
            'amount_paid' => 'required|numeric|min:0.01',
            'payment_method' => 'required|in:Cash,Cheque,Online',
            'reference_number' => 'nullable|string',
            'deposit_date' => 'nullable|date|required_if:payment_method,Cheque',
            'bank_name' => 'nullable|string|required_if:payment_method,Cheque',
            'is_realized' => 'boolean',
        ]);

        $feeAssignment = FeeAssignment::findOrFail($validated['fee_assignment_id']);
        $unpaidAmount = $feeAssignment->getUnpaidAmount() + $payment->amount_paid;

        if ($validated['amount_paid'] > $unpaidAmount) {
            return back()->withErrors([
                'amount_paid' => 'Payment amount cannot exceed the unpaid amount of Rs. ' . number_format($unpaidAmount, 2)
            ]);
        }

        $validated['is_realized'] = $validated['payment_method'] === 'Cash' ? true : ($validated['is_realized'] ?? false);

        $payment->update($validated);

        return redirect()->route('payments.index')->with('success', 'Payment updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $payment = Payment::findOrFail($id);

        if ($payment->cancelled) {
            return back()->withErrors(['payment' => 'Cannot delete a cancelled payment']);
        }

        $payment->delete();

        return redirect()->route('payments.index')->with('success', 'Payment deleted successfully');
    }

    /**
     * Cancel a payment.
     */
    public function cancel(Request $request, string $id)
    {
        $validated = $request->validate([
            'cancellation_reason' => 'required|string',
        ]);

        $payment = Payment::findOrFail($id);

        if ($payment->cancelled) {
            return back()->withErrors(['payment' => 'Payment is already cancelled']);
        }

        $payment->update([
            'cancelled' => true,
            'cancellation_date' => now(),
            'cancellation_reason' => $validated['cancellation_reason'],
            'cancelled_by_user_id' => Auth::check() ? Auth::id() : null,
        ]);

        return redirect()->route('payments.index')->with('success', 'Payment cancelled successfully');
    }
}


import React, { useState, useEffect } from 'react';
import { Input } from '@/components/ui/input';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm, Link } from '@inertiajs/react';
import Swal from 'sweetalert2';
import { route } from 'ziggy-js';

interface Student {
  id: number;
  admission_number: string;
  name: string;
  current_grade: string;
  current_class: string;
}

interface FeeAssignment {
  id: number;
  academic_year: number;
  assigned_fee: number;
  adjusted_fee: number;
  status: string;
  adjustment_reason?: string;
  unpaid_amount: number;
  student: Student;
}

interface Payment {
  id?: number;
  fee_assignment_id: number;
  receipt_number: string;
  payment_date: string;
  amount_paid: number;
  payment_method: string;
  reference_number?: string;
  deposit_date?: string;
  bank_name?: string;
  is_realized: boolean;
  cancelled?: boolean;
  cancellation_date?: string;
  cancellation_reason?: string;
  created_at?: string;
  updated_at?: string;
}

interface Props {
  isEdit: boolean;
  payment?: Payment;
  feeAssignments?: FeeAssignment[];
}

export default function PaymentForm({ isEdit, payment, feeAssignments }: Props) {
//   console.log('Payment data received:', payment);
//   console.log('Payment fee_assignment_id:', payment?.fee_assignment_id);
//   console.log('Is edit mode:', isEdit);

  const breadcrumbs: BreadcrumbItem[] = [
    {
      title: 'Payments',
      href: route('payments.index'),
    },
    {
      title: isEdit ? 'Edit Payment' : 'Record Payment',
      href: isEdit && payment ? route('payments.edit', payment.id) : route('payments.create'),
    },
  ];

  const [assignments, setAssignments] = useState<FeeAssignment[]>([]);
  const [selectedAssignments, setSelectedAssignments] = useState<number[]>([]);
  const [admissionNumber, setAdmissionNumber] = useState('');
  const [isSearching, setIsSearching] = useState(false);

  const formatDateForInput = (dateString: string | null | undefined): string => {
    if (!dateString) return '';
    try {
      const date = new Date(dateString);
      if (isNaN(date.getTime())) return '';
      return date.toISOString().split('T')[0];
    } catch {
      return '';
    }
  };

  const { data, setData, post, put, processing } = useForm({
    fee_assignment_id: payment?.fee_assignment_id || '',
    receipt_number: payment?.receipt_number || '',
    payment_date: payment?.payment_date ? formatDateForInput(payment.payment_date) : new Date().toISOString().split('T')[0],
    payment_method: payment?.payment_method || '',
    reference_number: payment?.reference_number || '',
    deposit_date: payment?.deposit_date ? formatDateForInput(payment.deposit_date) : '',
    bank_name: payment?.bank_name || '',
    amount_paid: payment?.amount_paid || '',
    is_realized: payment?.is_realized ?? false,
    fee_assignment_ids: [] as number[],
  });


//   console.log('Processed payment_date:', data.payment_date);
//   console.log('Processed deposit_date:', data.deposit_date);


  useEffect(() => {
    if (isEdit && payment && feeAssignments) {
      console.log('Initializing edit mode:', { payment, feeAssignments });

      const assignment = feeAssignments.find(fa => fa.id === payment.fee_assignment_id);
      if (assignment) {
        console.log('Found assignment:', assignment);
        setAdmissionNumber(assignment.student.admission_number);
        setAssignments([assignment]); // Only show the current assignment
        setSelectedAssignments([assignment.id]);
      } else {
        console.log('Assignment not found, creating minimal assignment data');

        const minimalAssignment = {
          id: payment.fee_assignment_id,
          academic_year: 0,
          assigned_fee: 0,
          adjusted_fee: 0,
          status: 'Unknown',
          student: {
            id: 0,
            admission_number: 'Unknown',
            name: 'Unknown Student',
            current_grade: 'Unknown',
            current_class: 'Unknown'
          },
          unpaid_amount: 0
        };
        setAssignments([minimalAssignment]);
        setSelectedAssignments([payment.fee_assignment_id]);
      }
    }
  }, [isEdit, payment, feeAssignments]);

  const searchStudentAssignments = async () => {
    if (!admissionNumber.trim()) {
      Swal.fire('Error!', 'Please enter an admission number.', 'error');
      return;
    }

    setIsSearching(true);
    try {
      const response = await fetch(route('payments.search.student.assignments', { admission_number: admissionNumber }));
      const data = await response.json();

      if (data.assignments && data.assignments.length > 0) {
        setAssignments(data.assignments);
        setSelectedAssignments([]);
        Swal.fire('Success!', `Found ${data.assignments.length} assignment(s) for student.`, 'success');
      } else {
        setAssignments([]);
        setSelectedAssignments([]);
        Swal.fire('No Assignments Found', 'No unpaid assignments found for this student.', 'info');
      }
    } catch (error) {
      console.error('Error searching assignments:', error);
      Swal.fire('Error!', 'Failed to search for assignments.', 'error');
    } finally {
      setIsSearching(false);
    }
  };

  const handleAssignmentToggle = (assignmentId: number) => {
    const newSelectedAssignments = selectedAssignments.includes(assignmentId)
      ? selectedAssignments.filter(id => id !== assignmentId)
      : [...selectedAssignments, assignmentId];

    setSelectedAssignments(newSelectedAssignments);
    setData('fee_assignment_ids', newSelectedAssignments);
  };

  const totalAmount = assignments
    .filter(assignment => selectedAssignments.includes(assignment.id))
    .reduce((sum, assignment) => sum + assignment.unpaid_amount, 0);

  function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();

    if (isEdit && payment) {

        const feeAssignmentId = payment.fee_assignment_id;

      console.log('Submitting edit data:', { feeAssignmentId, payment });
      console.log('Payment object keys:', Object.keys(payment));
      console.log('Payment fee_assignment_id type:', typeof payment.fee_assignment_id);

      if (!feeAssignmentId) {
        console.error('Fee assignment ID is missing:', payment);
        Swal.fire('Error!', 'Fee assignment ID is missing from payment record.', 'error');
        return;
      }

      const editData = {
        fee_assignment_id: feeAssignmentId,
        receipt_number: data.receipt_number,
        payment_date: data.payment_date,
        amount_paid: data.amount_paid,
        payment_method: data.payment_method,
        reference_number: data.reference_number || '',
        deposit_date: data.deposit_date || '',
        bank_name: data.bank_name || '',
        is_realized: data.is_realized || false,
      };

      console.log('Final edit data being sent:', editData);

      put(route('payments.update', payment.id), {
        ...editData,
        onSuccess: () => {
          Swal.fire({
            position: 'top-end',
            icon: 'success',
            title: 'Payment updated successfully',
            showConfirmButton: false,
            timer: 1500,
          });
        },
        onError: (errors: Record<string, string | string[]>) => {
          console.error('Payment update error:', errors);

          if (typeof errors === 'string') {
            Swal.fire('Error!', errors, 'error');
          } else if (errors && typeof errors === 'object') {

            const errorMessages = [];
            if (errors.amount_paid) errorMessages.push(errors.amount_paid);
            if (errors.receipt_number) errorMessages.push(errors.receipt_number);
            if (errors.fee_assignment_id) errorMessages.push('Fee assignment is required');
            if (errors.payment_date) errorMessages.push(errors.payment_date);
            if (errors.payment_method) errorMessages.push(errors.payment_method);

            if (errorMessages.length > 0) {
              Swal.fire('Validation Error!', errorMessages.join('\n'), 'error');
            } else {

                const firstError = Object.values(errors)[0];
              Swal.fire('Error!', Array.isArray(firstError) ? firstError[0] : firstError, 'error');
            }
          } else {
            Swal.fire('Error!', 'There was an error updating the payment.', 'error');
          }
        },
      });
    } else {
      if (selectedAssignments.length === 0) {
        Swal.fire('Error!', 'Please select at least one assignment to pay for.', 'error');
        return;
      }

      post(route('payments.store'), {
        onSuccess: () => {
          Swal.fire({
            position: 'top-end',
            icon: 'success',
            title: 'Payment recorded successfully',
            showConfirmButton: false,
            timer: 1500,
          });
        },
        onError: (errors) => {
          console.error('Payment creation error:', errors);
          Swal.fire('Error!', 'There was an error recording the payment.', 'error');
        },
      });
    }
  }

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title={isEdit ? 'Edit Payment' : 'Record Payment'} />
      <div className="p-4">
        <form onSubmit={handleSubmit} className="mx-auto max-w-4xl rounded-xl bg-slate-800 p-8 text-white shadow-lg">
          <h2 className="mb-6 text-center text-2xl font-semibold">
            {isEdit ? 'Edit Payment' : 'Record New Payment'}
          </h2>

          {isEdit && payment && (
            <div className="mb-6 p-4 bg-slate-700 rounded-md">
              <div className="flex justify-between items-center">
                <div>
                  <h3 className="text-lg font-medium">Current Payment Status</h3>
                  <p className="text-sm text-gray-300">Receipt: {payment.receipt_number}</p>
                </div>
                <div className={`px-3 py-1 rounded text-sm font-medium ${
                  payment.cancelled ? 'bg-red-600' :
                  payment.payment_method === 'Cheque' && !payment.is_realized ? 'bg-yellow-600' :
                  'bg-green-600'
                }`}>
                  {payment.cancelled ? 'Cancelled' :
                   payment.payment_method === 'Cheque' && !payment.is_realized ? 'Pending' :
                   'Completed'}
                </div>
              </div>
            </div>
          )}

          <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
            {/* Student Admission Number - Only show for create mode */}
            {!isEdit && (
              <div className="md:col-span-2">
                <label className="mb-2 block text-sm font-medium text-white">
                  Student Admission Number *
                </label>
                <div className="flex gap-2">
                  <Input
                    type="text"
                    placeholder="Enter admission number"
                    value={admissionNumber}
                    onChange={(e) => setAdmissionNumber(e.target.value)}
                    className="bg-slate-700 text-white flex-1"
                    required
                  />
                  <button
                    type="button"
                    onClick={searchStudentAssignments}
                    disabled={isSearching || !admissionNumber.trim()}
                    className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    {isSearching ? 'Searching...' : 'Search'}
                  </button>
                </div>
                <p className="text-xs text-gray-400 mt-1">
                  Enter the student's admission number and click Search to find their assignments
                </p>
              </div>
            )}

            {/* Receipt Number */}
            <div>
              <label className="mb-2 block text-sm font-medium text-white">
                Receipt Number *
              </label>
              <Input
                type="text"
                placeholder="Enter receipt number"
                value={data.receipt_number}
                onChange={(e) => setData('receipt_number', e.target.value)}
                className="bg-slate-700 text-white"
                required
              />
            </div>

            {/* Payment Details */}
            <div>
              <label className="mb-2 block text-sm font-medium text-white">
                Payment Date *
              </label>
              <Input
                type="date"
                value={data.payment_date}
                onChange={(e) => setData('payment_date', e.target.value)}
                className="bg-slate-700 text-white"
                required
              />
            </div>

            <div>
              <label className="mb-2 block text-sm font-medium text-white">
                Amount Paid *
              </label>
              <Input
                type="number"
                placeholder="Enter amount paid"
                value={data.amount_paid}
                onChange={(e) => setData('amount_paid', e.target.value)}
                className="bg-slate-700 text-white"
                min="0.01"
                step="0.01"
                required
              />
            </div>

            <div>
              <label className="mb-2 block text-sm font-medium text-white">
                Payment Method *
              </label>
              <select
                value={data.payment_method}
                onChange={(e) => {
                  const newMethod = e.target.value;
                  setData('payment_method', newMethod);

                  if (newMethod !== 'Cheque') {
                    if (!isEdit || payment?.payment_method !== 'Cheque') {
                      setData('deposit_date', '');
                      setData('bank_name', '');
                    }

                    if (newMethod === 'Cash') {
                      setData('is_realized', true);
                    }
                  } else {

                    if (!isEdit) {
                      setData('is_realized', false);
                    }
                  }
                }}
                className="w-full rounded-md border border-gray-600 bg-slate-700 p-2.5 text-white focus:border-blue-500 focus:ring-blue-500"
                title="Select Payment Method"
                required
              >
                <option value="">Select Method</option>
                <option value="Cash">Cash</option>
                <option value="Cheque">Cheque</option>
                <option value="Online">Online</option>
              </select>
            </div>

            <div>
              <label className="mb-2 block text-sm font-medium text-white">
                Reference Number
              </label>
              <Input
                type="text"
                placeholder="Optional reference number"
                value={data.reference_number}
                onChange={(e) => setData('reference_number', e.target.value)}
                className="bg-slate-700 text-white"
              />
            </div>

            {data.payment_method === 'Cheque' && (
              <>
                <div>
                  <label className="mb-2 block text-sm font-medium text-white">
                    Deposit Date *
                  </label>
                  <Input
                    type="date"
                    value={data.deposit_date}
                    onChange={(e) => setData('deposit_date', e.target.value)}
                    className="bg-slate-700 text-white"
                    required={data.payment_method === 'Cheque'}
                  />
                </div>

                <div>
                  <label className="mb-2 block text-sm font-medium text-white">
                    Bank Name *
                  </label>
                  <Input
                    type="text"
                    placeholder="Enter bank name"
                    value={data.bank_name}
                    onChange={(e) => setData('bank_name', e.target.value)}
                    className="bg-slate-700 text-white"
                    required={data.payment_method === 'Cheque'}
                  />
                </div>
              </>
            )}

            {/* Payment Status - Available for all payment methods */}
            <div className="md:col-span-2">
              <div className="flex items-center gap-2">
                <input
                  type="checkbox"
                  id="is_realized"
                  checked={data.is_realized}
                  onChange={(e) => setData('is_realized', e.target.checked)}
                  className="h-4 w-4 text-blue-600 bg-slate-700 border-gray-300 rounded focus:ring-blue-500"
                />
                <label htmlFor="is_realized" className="text-sm font-medium text-white">
                  Mark Payment as Completed
                </label>
              </div>
              <p className="text-xs text-gray-400 mt-1">
                {data.payment_method === 'Cheque'
                  ? 'Check this box when the cheque has been cleared and the payment is complete'
                  : 'Check this box to mark this payment as fully completed and processed'
                }
              </p>
            </div>
          </div>

          {/* Fee Assignments - Only show for create mode */}
          {!isEdit && assignments.length > 0 && (
            <div className="mt-8">
              <h3 className="mb-4 text-lg font-semibold">Select Assignments to Pay For</h3>
              <div className="space-y-3 max-h-60 overflow-y-auto">
                {assignments.map((assignment) => (
                  <div key={assignment.id} className="flex items-center justify-between p-4 bg-slate-700 rounded-md">
                    <div className="flex items-center space-x-3">
                      <input
                        type="checkbox"
                        id={`assignment-${assignment.id}`}
                        checked={selectedAssignments.includes(assignment.id)}
                        onChange={() => handleAssignmentToggle(assignment.id)}
                        className="h-4 w-4 text-blue-600 bg-slate-700 border-gray-300 rounded focus:ring-blue-500"
                      />
                      <label htmlFor={`assignment-${assignment.id}`} className="flex-1 cursor-pointer">
                        <div className="font-medium">Academic Year {assignment.academic_year}</div>
                        <div className="text-sm text-gray-300">
                          Assigned: Rs. {assignment.assigned_fee.toLocaleString()}
                          {assignment.adjusted_fee !== assignment.assigned_fee && (
                            <span className="ml-2 text-yellow-400">
                              Adjusted: Rs. {assignment.adjusted_fee.toLocaleString()}
                            </span>
                          )}
                        </div>
                        <div className="text-sm text-green-400 font-medium">
                          Unpaid: Rs. {assignment.unpaid_amount.toLocaleString()}
                        </div>
                        {assignment.adjustment_reason && (
                          <div className="text-xs text-gray-400 mt-1">
                            Reason: {assignment.adjustment_reason}
                          </div>
                        )}
                      </label>
                    </div>
                    <div className="text-right">
                      <div className={`text-xs px-2 py-1 rounded ${
                        assignment.status === 'Unpaid' ? 'bg-red-600' :
                        assignment.status === 'Partially Paid' ? 'bg-yellow-600' : 'bg-green-600'
                      }`}>
                        {assignment.status}
                      </div>
                    </div>
                  </div>
                ))}
              </div>

              {selectedAssignments.length > 0 && (
                <div className="mt-6 p-4 bg-slate-700 rounded-md">
                  <div className="flex justify-between items-center">
                    <span className="text-lg font-medium">Total Amount:</span>
                    <span className="text-xl font-bold text-green-400">
                      Rs. {totalAmount.toLocaleString()}
                    </span>
                  </div>
                  <div className="text-sm text-gray-300 mt-1">
                    {selectedAssignments.length} assignment(s) selected
                  </div>
                </div>
              )}
            </div>
          )}

          {/* Current Assignment Display - Only show for edit mode */}
          {isEdit && assignments.length > 0 && (
            <div className="mt-8">
              <h3 className="mb-4 text-lg font-semibold">Current Payment Assignment</h3>
              <div className="p-4 bg-slate-700 rounded-md">
                <div className="font-medium">Academic Year {assignments[0].academic_year}</div>
                <div className="text-sm text-gray-300 mt-1">
                  Student: {assignments[0].student.name} ({assignments[0].student.admission_number})
                </div>
                <div className="text-sm text-gray-300">
                  Assigned Fee: Rs. {assignments[0].assigned_fee.toLocaleString()}
                  {assignments[0].adjusted_fee !== assignments[0].assigned_fee && (
                    <span className="ml-2 text-yellow-400">
                      Adjusted: Rs. {assignments[0].adjusted_fee.toLocaleString()}
                    </span>
                  )}
                </div>
                <div className="text-sm text-green-400 font-medium">
                  Payment Amount: Rs. {data.amount_paid}
                </div>
              </div>
            </div>
          )}

          <div className="mt-8 flex justify-center gap-4">
            <Link
              href={route('payments.index')}
              className="rounded-lg bg-gray-500 px-6 py-2 font-semibold text-white transition-all hover:bg-gray-600"
            >
              Cancel
            </Link>
            <button
              type="submit"
              disabled={processing || (!isEdit && selectedAssignments.length === 0)}
              className="rounded-lg bg-blue-600 px-6 py-2 font-semibold text-white transition-all hover:bg-blue-700 disabled:opacity-70"
            >
              {processing ? (isEdit ? 'Updating...' : 'Recording...') : (isEdit ? 'Update Payment' : 'Record Payment')}
            </button>
          </div>
        </form>
      </div>
    </AppLayout>
  );
}

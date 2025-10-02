<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Collection Report</title>
    @vite('resources/css/app.css')
</head>
<body>
    <h1 class="text-2xl  text-black text-center">St Joseph's College Facility fees</h1>
    <h3 class="text-xl  text-black text-center">Collection report</h3>
    <p class="text-lg  text-black">Date - {{now()->format('Y-m-d')}}</p>
    @php
       $groupedPayments = $payments->groupBy('payment_method');
        $grandTotal = 0;
    @endphp
    @foreach ($groupedPayments as $method => $methodPayments)
        @php $methodTotal = 0; @endphp

        <h2 class="text-lg  text-black mt-5 mb-2">{{ ucfirst($method) }} Payments</h2>
        <table class="w-full text-black m-3">
            <thead class="bg-black text-sm text-white">
                <tr>
                    <th>Receipt Number</th>
                    <th>Payment Date</th>
                    <th>Student Name</th>
                    <th>Amount</th>
                    <th>Method</th>
                    <th>Cheque number</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($methodPayments as $payment)
                    @php $methodTotal += $payment->amount_paid; @endphp
                    <tr class="odd:bg-white even:bg-gray-100 text-center">
                        <td>{{ $payment->receipt_number }}</td>
                        <td>{{ $payment->payment_date->format('Y-m-d') }}</td>
                        <td>{{ $payment->feeAssignment->student->name ?? 'N/A' }}</td>
                        <td>{{ number_format($payment->amount_paid, 2) }}</td>
                        <td>{{ $payment->payment_method }}</td>
                        <td>{{ $payment->cheque_no ?? 'N/A' }}</td>
                    </tr>
                @endforeach
            </tbody>
            <tfoot>
                <tr class="bg-gray-300 font-bold text-center">
                    <td colspan="3">Subtotal ({{ ucfirst($method) }})</td>
                    <td>{{ number_format($methodTotal, 2) }}</td>
                    <td></td>
                </tr>
            </tfoot>
        </table>

        @php $grandTotal += $methodTotal; @endphp
    @endforeach

    <div class="mt-6">
        <table class="w-full text-black m-3">
            <tfoot>
                <tr class="bg-black text-white font-bold text-center">
                    <td colspan="3">Grand Total</td>
                    <td>{{ number_format($grandTotal, 2) }}</td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
    </div>
</body>
</html>
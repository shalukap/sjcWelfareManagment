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
    <h1 class="text-2xl font-bold text-black text-center">St Joseph's College Facilitie fees</h1>
    <h3 class="text-xl font-bold text-black text-center">Collection report</h3>
    <p class="text-lg font-bold text-black">Date - {{now()->format('Y-m-d')}}</p>
    <table class="w-full text-black m-3" >
        <thead class="bg-black text-lg text-white">
        <tr>
            <th>Receipt number</th>
            <th>Payment Date</th>
            <th>Student Name</th>
            <th>Amount</th>
            <th>Method</th>
        </tr>
        </thead>
        <tbody>
            @php $total = 0; @endphp
        @foreach ($payments as $payment)
        @php $total += $payment->amount_paid; @endphp
            <tr class="odd:bg-white even:bg-gray-100 text-center">
                <td>{{ $payment->receipt_number }}</td>
                <td>{{ $payment->payment_date->format('Y-m-d') }}</td>
                <td>{{ $payment->feeAssignment->student->name??'N/A' }}</td>
                <td>{{ $payment->amount_paid }}</td>
                <td> {{ $payment->payment_method }}</td>
            </tr>   
        @endforeach  
        </tbody>
        <tfoot>
            <tr>
                <th colspan="3" class="text-center bg-black">Total</th>
                <th>{{ $total }}</th>
                <th></th>
            </tr>
        </tfoot>  
    </table>    
</body>
</html>
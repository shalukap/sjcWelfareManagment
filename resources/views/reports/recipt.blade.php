<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PDF  </title>
    @vite('resources/css/app.css')
</head>
<body class="text-black space-y-2">
    <div class="grid grid-cols-2">
    <div>
        <h3>Reciept to:  {{$lastpayment->feeAssignment->student->name}}</h3>
        <p>Admission number: {{$lastpayment->feeAssignment->student->admission_number}}</p>
        <p>Class: {{$lastpayment->feeAssignment->student->current_class}}</p>

    </div>
    <div class="ml-auto">
        <p class="text-sm font-bold">Date: {{$lastpayment->payment_date->format('Y-m-d')}}</p>
        <p> Receipt Number:{{$lastpayment->receipt_number}}</p>

    </div>
    </div>
    
    <hr>
    <table class="w-full text-black m-3 text-sm border-1">
        <thead>
            <tr class="border-b">
                <th>Description</th>
                <th>Amount</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($payments as $payment)
            <tr class="odd:bg-white even:bg-gray-100 text-center">
            <td>{{$payment->feeAssignment->student->current_class??'N/A'}} Facility fees for {{$payment->feeAssignment->academic_year??'N/A'}}</td>
            <td>{{$payment->amount_paid}}</td>
            </tr>
            @endforeach
        </tbody>
        <tfoot>
            <tr class="bg-gray-300 font-bold text-center">
                <td colspan="2">Total</td>
                <td>{{number_format($payments->sum($amount_paid),2)}}</td>
            </tr>
        </tfoot>
    </table>
   
    <div class="grid grid-cols-2 mt-16">
        <div>
             <p>Paymet Method: {{$lastpayment->payment_method}}</p>
             @if($lastpayment->payment_method=='Cheque')             
            <p>Cheque Number:{{$lastpayment->cheque_no}}</p>
            <p>Cheques valid subject to realization</p>
            @elseif($lastpayment->payment_method=='Online')
            <p>Reference No: {{ $lastpayment->reference_number }}</p>
            <p>Deposit Date: {{ $lastpayment->deposit_date->format('Y-m-d')}}</p>
            @endif
        </div>
        <div class="m-5">
            ............................................................................................<br>
            <p class="text-sm font-bold text-center">Authorised Signature</p>
        </div>

    </div>
  
  
   
</body>
</html>
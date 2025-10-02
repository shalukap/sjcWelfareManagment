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

    </div>
    <div class="ml-auto">
        <p class="text-sm font-bold">Date: {{$lastpayment->payment_date->format('Y-m-d')}}</p>
        <p> Receipt Number:{{$lastpayment->receipt_number}}</p>

    </div>
    </div>
    
    <hr>
    <table class="w-full text-black m-3 text-sm border-1">
        <tr class="border-b">
            <th>Description</th>
            <th>Amount</th>
        </tr>
        <tr class="odd:bg-white even:bg-gray-100 text-center">
        <td>{{$lastpayment->feeAssignment->student->current_class}} Facility fees for {{$lastpayment->feeAssignment->academic_year}}</td>
        <td>{{$lastpayment->amount_paid}}</td>
        </tr>
    </table>
   
    <div class="grid grid-cols-2 mt-16">
        <div>
             <p>Paymet Method: {{$lastpayment->payment_method}}</p>
             @if($lastpayment->payment_method=='Cheque')             
            <p>Cheque Number:{{$lastpayment->cheque_number}}</p>
            <p>Cheques valid subject to realization</p>
            @elseif($lastpayment->payment_method=='online')
            <p>Reference No: {{ $lastpayment->ref_no }}</p>
            <p>Deposit Date: {{ $lastpayment->deposit_date }}</p>
            @endif
        </div>
        <div class="m-5">
            ............................................................................................<br>
            <p class="text-sm font-bold text-center">Authorised Signature</p>
        </div>

    </div>
  
  
   
</body>
</html>
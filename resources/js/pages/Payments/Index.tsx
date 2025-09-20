import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, router } from '@inertiajs/react';
import { useEffect, useState } from 'react';
import { FaEdit } from 'react-icons/fa';
import { MdDeleteForever, MdCancel } from 'react-icons/md';
import Swal from 'sweetalert2';
import { route } from 'ziggy-js';

interface Payment {
  id: number;
  fee_assignment_id: number;
  receipt_number: string;
  payment_date: string;
  amount_paid: number;
  payment_method: string;
  reference_number?: string;
  deposit_date?: string;
  bank_name?: string;
  is_realized: boolean;
  cancelled: boolean;
  cancellation_date?: string;
  cancellation_reason?: string;
  created_at: string;
  updated_at: string;
  feeAssignment: {
    id: number;
    academic_year: number;
    assigned_fee: number;
    adjusted_fee: number;
    status: string;
    student: {
      id: number;
      admission_number: string;
      name: string;
      current_grade: string;
      current_class: string;
    };
  };
  cancelledBy?: {
    id: number;
    name: string;
  };
}

export default function Index({ payments: originalPayments }: { payments: Payment[] }) {
  const breadcrumbs: BreadcrumbItem[] = [
    {
      title: 'Payments',
      href: route('payments.index'),
    },
  ];

  const [searchTerm, setSearchTerm] = useState('');
  const [filteredPayments, setFilteredPayments] = useState<Payment[]>(originalPayments);
  const [filterMethod, setFilterMethod] = useState('all');
  const [filterStatus, setFilterStatus] = useState('all');


  useEffect(() => {
    const searchQuery = searchTerm.toLowerCase();
    const filtered = originalPayments.filter(
      (payment) =>
        (payment.receipt_number.toLowerCase().includes(searchQuery) ||
        (payment.feeAssignment?.student?.admission_number?.toLowerCase().includes(searchQuery)) ||
        (payment.feeAssignment?.student?.name?.toLowerCase().includes(searchQuery)) ||
        String(payment.fee_assignment_id).includes(searchQuery) || // Allow searching by fee assignment ID
        payment.payment_method.toLowerCase().includes(searchQuery) ||
        String(payment.amount_paid).includes(searchQuery) ||
        (payment.feeAssignment && !payment.feeAssignment.student && (searchQuery.toLowerCase().includes('unavailable') || searchQuery.toLowerCase().includes('missing'))) ||
        (!payment.feeAssignment && (searchQuery.toLowerCase().includes('missing') || searchQuery.toLowerCase().includes('assignment')))) && // Allow searching for missing data
        (filterMethod === 'all' || payment.payment_method === filterMethod) &&
        (filterStatus === 'all' ||
          (filterStatus === 'cancelled' && payment.cancelled) ||
          (filterStatus === 'pending' && payment.payment_method === 'Cheque' && !payment.is_realized && !payment.cancelled) ||
          (filterStatus === 'completed' &&
            ((payment.payment_method === 'Cheque' && payment.is_realized) ||
             (payment.payment_method !== 'Cheque') && !payment.cancelled))
        )
    );
    setFilteredPayments(filtered);
  }, [searchTerm, originalPayments, filterMethod, filterStatus]);

  const handleDelete = (id: number) => {
    Swal.fire({
      title: 'Are you sure?',
      text: "This action cannot be undone!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!',
    }).then((result) => {
      if (result.isConfirmed) {
        router.delete(route('payments.destroy', id), {
          onSuccess: () => {
            Swal.fire('Deleted!', 'The payment record has been deleted.', 'success');
          },
          onError: (errors) => {
            console.error('Delete error:', errors);
            Swal.fire('Error!', 'There was an error deleting the payment. Please try again.', 'error');
          }
        });
      }
    });
  };

  const handleCancel = (id: number) => {
    Swal.fire({
      title: 'Cancel Payment',
      input: 'textarea',
      inputLabel: 'Cancellation Reason',
      inputPlaceholder: 'Enter the reason for cancelling this payment...',
      inputValidator: (value) => {
        if (!value) {
          return 'Cancellation reason is required!';
        }
      },
      showCancelButton: true,
      confirmButtonText: 'Cancel Payment',
      confirmButtonColor: '#d33',
    }).then((result) => {
      if (result.isConfirmed) {
        router.post(route('payments.cancel', id), {
          cancellation_reason: result.value,
        }, {
          onSuccess: () => {
            Swal.fire('Cancelled!', 'The payment has been cancelled.', 'success');
          },
          onError: () => {
            Swal.fire('Error!', 'There was an error cancelling the payment.', 'error');
          }
        });
      }
    });
  };

  const getStatusColor = (payment: Payment) => {
    if (payment.cancelled) return 'bg-red-500';
    if (payment.payment_method === 'Cheque' && !payment.is_realized) return 'bg-yellow-500';
    return 'bg-green-500';
  };

  const getStatusText = (payment: Payment) => {
    if (payment.cancelled) return 'Cancelled';
    if (payment.payment_method === 'Cheque' && !payment.is_realized) return 'Pending';
    return 'Completed';
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Payments" />
      <div className="h-full w-full overflow-x-auto p-4">
        <div className="mx-auto max-w-full rounded-xl bg-slate-800 p-8 text-white shadow-lg mb-6">
          <h2 className="mb-6 text-center text-2xl font-semibold">Payment Records</h2>

          <div className="flex flex-col gap-6 items-center">
            <Link
              href={route('payments.create')}
              className="rounded-md bg-green-600 px-6 py-3 text-white hover:bg-green-700 text-lg font-medium"
            >
              Record New Payment
            </Link>

            <div className="w-full max-w-4xl grid grid-cols-1 md:grid-cols-3 gap-4">
              <div>
                <input
                  type="text"
                  className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                  placeholder="Search by Receipt No, Admission No, Name, Fee Assignment ID, Method, Amount, or 'unavailable'/'missing'"
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                />
              </div>

              <div>
                <select
                  aria-label="Filter by payment method"
                  className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                  value={filterMethod}
                  onChange={(e) => setFilterMethod(e.target.value)}
                >
                  <option value="all">All Methods</option>
                  <option value="Cash">Cash</option>
                  <option value="Cheque">Cheque</option>
                  <option value="Online">Online</option>
                </select>
              </div>

              <div>
                <select
                  aria-label="Filter by payment status"
                  className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                  value={filterStatus}
                  onChange={(e) => setFilterStatus(e.target.value)}
                >
                  <option value="all">All Statuses</option>
                  <option value="completed">Completed</option>
                  <option value="pending">Pending</option>
                  <option value="cancelled">Cancelled</option>
                </select>
              </div>
            </div>
          </div>
        </div>

        <div className="mt-6 overflow-x-auto rounded-lg bg-white shadow scrollbar-thin scrollbar-thumb-gray-400 scrollbar-track-gray-200">
          <table className="min-w-[1400px] divide-y divide-gray-200">
            <thead className="bg-slate-800 text-white sticky top-0 z-10">
              <tr>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[120px]">Receipt No</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[200px]">Student</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[100px]">Academic Year</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[100px]">Amount</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[100px]">Method</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[120px]">Reference</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[120px]">Bank</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[120px]">Deposit Date</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[80px]">Realized</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[120px]">Payment Date</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[150px]">Cancellation Details</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[100px]">Status</th>
                <th className="px-4 py-3 text-left text-sm font-semibold min-w-[120px]">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200 text-sm text-slate-800">
              {filteredPayments.map((payment) => (
                <tr key={payment.id}>
                  <td className="px-4 py-2 font-medium min-w-[120px]">{payment.receipt_number}</td>
                  <td className="px-4 py-2 min-w-[200px]">
                    {payment.feeAssignment?.student ? (
                      <div>
                        <div className="font-medium">{payment.feeAssignment.student.name}</div>
                        <div className="text-xs text-gray-500">
                          {payment.feeAssignment.student.admission_number} - Grade {payment.feeAssignment.student.current_grade}
                        </div>
                      </div>
                    ) : payment.feeAssignment ? (
                      <div className="text-orange-600 font-medium">
                        <div>Student data unavailable</div>
                        <div className="text-xs text-gray-500">
                          Fee Assignment ID: {payment.fee_assignment_id}
                        </div>
                        {/* Try to show student info from other payments of the same student */}
                        <div className="text-xs text-blue-600 mt-1">
                          Check other payments for this student
                        </div>
                      </div>
                    ) : (
                      <div className="text-red-600 font-medium">
                        <div>Fee Assignment Missing</div>
                        <div className="text-xs text-gray-500">
                          ID: {payment.fee_assignment_id}
                        </div>
                        <div className="text-xs text-blue-600 mt-1">
                          This fee assignment may have been deleted
                        </div>
                      </div>
                    )}
                  </td>
                  <td className="px-4 py-2 min-w-[100px]">
                    {payment.feeAssignment?.academic_year ? (
                      <div>
                        <span className="font-medium text-green-600">{payment.feeAssignment.academic_year}</span>
                        {payment.feeAssignment.adjusted_fee !== payment.feeAssignment.assigned_fee && (
                          <div className="text-xs text-yellow-600">
                            Adjusted: Rs. {payment.feeAssignment.adjusted_fee.toLocaleString()}
                          </div>
                        )}
                      </div>
                    ) : (
                      <span className="text-gray-400">N/A</span>
                    )}
                  </td>
                  <td className="px-4 py-2 font-medium min-w-[100px]">Rs. {payment.amount_paid.toLocaleString()}</td>
                  <td className="px-4 py-2 min-w-[100px]">{payment.payment_method}</td>
                  <td className="px-4 py-2 min-w-[120px]">{payment.reference_number || 'N/A'}</td>
                  <td className="px-4 py-2 min-w-[120px]">{payment.bank_name || 'N/A'}</td>
                  <td className="px-4 py-2 min-w-[120px]">{payment.deposit_date ? new Date(payment.deposit_date).toLocaleDateString() : 'N/A'}</td>
                  <td className="px-4 py-2 min-w-[80px]">
                    {payment.payment_method === 'Cheque' ? (
                      payment.is_realized ? (
                        <span className="text-green-600 font-medium">Yes</span>
                      ) : (
                        <span className="text-red-600 font-medium">No</span>
                      )
                    ) : (
                      <span className="text-gray-400">N/A</span>
                    )}
                  </td>
                  <td className="px-4 py-2 min-w-[120px]">{new Date(payment.payment_date).toLocaleDateString()}</td>
                  <td className="px-4 py-2 min-w-[150px]">
                    {payment.cancelled ? (
                      <div className="text-xs">
                        <div className="font-medium text-red-600">Cancelled</div>
                        {payment.cancellation_date && (
                          <div className="text-gray-500">
                            {new Date(payment.cancellation_date).toLocaleDateString()}
                          </div>
                        )}
                        {payment.cancelledBy && (
                          <div className="text-gray-500">
                            By: {payment.cancelledBy.name}
                          </div>
                        )}
                        {payment.cancellation_reason && (
                          <div className="text-gray-500 max-w-32 truncate" title={payment.cancellation_reason}>
                            Reason: {payment.cancellation_reason}
                          </div>
                        )}
                      </div>
                    ) : (
                      <span className="text-gray-400 text-xs">Active</span>
                    )}
                  </td>
                  <td className="px-4 py-2 min-w-[100px]">
                    <span
                      className={`inline-block rounded-full px-3 py-1 text-white text-xs ${getStatusColor(payment)}`}
                    >
                      {getStatusText(payment)}
                    </span>
                  </td>
                  <td className="flex items-center gap-2 px-4 py-2 min-w-[120px]">
                    {!payment.cancelled && (
                      <>
                        <Link as="button" href={route('payments.edit', payment.id)}>
                          <FaEdit className="text-xl hover:text-green-700" />
                        </Link>
                        <button onClick={() => handleCancel(payment.id)} title="Cancel Payment">
                          <MdCancel className="text-xl hover:text-orange-700" />
                        </button>
                      </>
                    )}
                    <button onClick={() => handleDelete(payment.id)} title="Delete Payment">
                      <MdDeleteForever className="text-xl hover:text-red-700" />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

      </div>
    </AppLayout>
  );
}

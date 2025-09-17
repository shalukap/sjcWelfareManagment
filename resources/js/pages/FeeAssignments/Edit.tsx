import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, router, useForm } from '@inertiajs/react';
import { route } from 'ziggy-js';

interface FeeAssignment {
  id: number;
  student_id: number;
  academic_year: string;
  assigned_fee: number;
  adjusted_fee: number;
  adjustment_reason: string | null;
  status: string;
  student: {
    id: number;
    admission_number: string;
    name: string;
    current_grade: string;
    current_class: string;
  };
}

export default function Edit({ feeAssignment }: { feeAssignment: FeeAssignment }) {
  const breadcrumbs: BreadcrumbItem[] = [
    {
      title: 'Fee Assignments',
      href: route('fee-assignments.index'),
    },
    {
      title: 'Adjust Fee',
      href: route('fee-assignments.edit', feeAssignment.id),
    },
  ];

  const { data, setData, errors, processing, put } = useForm({
    adjusted_fee: feeAssignment.adjusted_fee.toString(),
    adjustment_reason: feeAssignment.adjustment_reason || '',
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    put(route('fee-assignments.update', feeAssignment.id));
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Adjust Student Fee" />
      <div className="h-full w-full overflow-x-auto p-4">
        <form 
          onSubmit={handleSubmit}
          className="mx-auto max-w-2xl rounded-xl bg-slate-800 p-8 text-white shadow-lg"
        >
          <h2 className="mb-6 text-center text-2xl font-semibold">Adjust Student Fee</h2>

          <div className="mb-6 rounded-lg bg-slate-700 p-4">
            <h3 className="mb-3 text-lg font-semibold">Student Information</h3>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <span className="text-sm text-gray-300">Admission No:</span>
                <p className="font-medium">{feeAssignment.student.admission_number}</p>
              </div>
              <div>
                <span className="text-sm text-gray-300">Name:</span>
                <p className="font-medium">{feeAssignment.student.name}</p>
              </div>
              <div>
                <span className="text-sm text-gray-300">Grade:</span>
                <p className="font-medium">{feeAssignment.student.current_grade}</p>
              </div>
              <div>
                <span className="text-sm text-gray-300">Academic Year:</span>
                <p className="font-medium">{feeAssignment.academic_year}</p>
              </div>
            </div>
          </div>

          <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
            <div>
              <label htmlFor="assigned_fee" className="mb-2 block text-sm font-medium">
                Original Assigned Fee (Rs.)
              </label>
              <input
                type="text"
                id="assigned_fee"
                value={feeAssignment.assigned_fee.toLocaleString()}
                className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white opacity-70"
                readOnly
                disabled
              />
            </div>

            <div>
              <label htmlFor="adjusted_fee" className="mb-2 block text-sm font-medium">
                Adjusted Fee (Rs.)
              </label>
              <input
                type="number"
                id="adjusted_fee"
                value={data.adjusted_fee}
                onChange={(e) => setData('adjusted_fee', e.target.value)}
                className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Enter adjusted fee"
                min="0"
                step="0.01"
                required
              />
              {errors.adjusted_fee && (
                <p className="mt-1 text-sm text-red-400">{errors.adjusted_fee}</p>
              )}
            </div>

            <div className="md:col-span-2">
              <label htmlFor="adjustment_reason" className="mb-2 block text-sm font-medium">
                Adjustment Reason
              </label>
              <textarea
                id="adjustment_reason"
                value={data.adjustment_reason}
                onChange={(e) => setData('adjustment_reason', e.target.value)}
                className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Reason for fee adjustment (optional)"
                rows={3}
              />
              {errors.adjustment_reason && (
                <p className="mt-1 text-sm text-red-400">{errors.adjustment_reason}</p>
              )}
            </div>
          </div>

          <div className="mt-8 flex justify-end gap-4">
            <Link
              href={route('fee-assignments.index')}
              className="rounded-md bg-gray-600 px-6 py-2 text-white hover:bg-gray-700"
            >
              Cancel
            </Link>
            <button
              type="submit"
              disabled={processing}
              className="rounded-md bg-blue-600 px-6 py-2 text-white hover:bg-blue-700 disabled:opacity-50"
            >
              {processing ? 'Updating...' : 'Update Fee'}
            </button>
          </div>
        </form>
      </div>
    </AppLayout>
  );
}
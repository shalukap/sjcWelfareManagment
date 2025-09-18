import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, router, useForm } from '@inertiajs/react';
import { route } from 'ziggy-js';

export default function CreateGrade({ grades }: { grades: string[] }) {
  const breadcrumbs: BreadcrumbItem[] = [
    {
      title: 'Fee Assignments',
      href: route('fee-assignments.index'),
    },
    {
      title: 'Assign to Grade',
      href: route('fee-assignments.create-grade'),
    },
  ];

  const { data, setData, errors, processing, post } = useForm({
    academic_year: new Date().getFullYear().toString(),
    grade: '',
    assigned_fee: '',
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    router.post(route('fee-assignments.store-grade'), data);
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Assign Fees to Grade" />
      <div className="h-full w-full overflow-x-auto p-4">
        <form
          onSubmit={handleSubmit}
          className="mx-auto max-w-2xl rounded-xl bg-slate-800 p-8 text-white shadow-lg"
        >
          <h2 className="mb-6 text-center text-2xl font-semibold">Assign Fees to Grade</h2>

          <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
            <div>
              <label htmlFor="academic_year" className="mb-2 block text-sm font-medium">
                Academic Year
              </label>
              <input
                type="text"
                id="academic_year"
                value={data.academic_year}
                onChange={(e) => setData('academic_year', e.target.value)}
                className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="e.g., 2024"
                required
              />
              {errors.academic_year && (
                <p className="mt-1 text-sm text-red-400">{errors.academic_year}</p>
              )}
            </div>

            <div>
              <label htmlFor="grade" className="mb-2 block text-sm font-medium">
                Grade
              </label>
              <select
                id="grade"
                value={data.grade}
                onChange={(e) => setData('grade', e.target.value)}
                className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                required
              >
                <option value="">Select Grade</option>
                {grades.map((grade) => (
                  <option key={grade} value={grade}>
                    {grade}
                  </option>
                ))}
              </select>
              {errors.grade && (
                <p className="mt-1 text-sm text-red-400">{errors.grade}</p>
              )}
            </div>

            <div className="md:col-span-2">
              <label htmlFor="assigned_fee" className="mb-2 block text-sm font-medium">
                Assigned Fee (Rs.)
              </label>
              <input
                type="number"
                id="assigned_fee"
                value={data.assigned_fee}
                onChange={(e) => setData('assigned_fee', e.target.value)}
                className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="e.g., 3000"
                min="0"
                step="0.01"
                required
              />
              {errors.assigned_fee && (
                <p className="mt-1 text-sm text-red-400">{errors.assigned_fee}</p>
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
              {processing ? 'Assigning...' : 'Assign to Grade'}
            </button>
          </div>
        </form>
      </div>
    </AppLayout>
  );
}

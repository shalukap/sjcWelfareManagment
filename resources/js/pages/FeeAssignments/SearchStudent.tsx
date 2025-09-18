import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, router, useForm } from '@inertiajs/react';
import { route } from 'ziggy-js';

export default function SearchStudent() {
  const breadcrumbs: BreadcrumbItem[] = [
    {
      title: 'Fee Assignments',
      href: route('fee-assignments.index'),
    },
    {
      title: 'Search Student',
      href: route('fee-assignments.search'),
    },
  ];

  const { data, setData, errors, processing, post } = useForm({
    admission_number: '',
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    post(route('fee-assignments.get-student-assignments'));
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Search Student Fee Assignments" />
      <div className="h-full w-full overflow-x-auto p-4">
        <form 
          onSubmit={handleSubmit}
          className="mx-auto max-w-md rounded-xl bg-slate-800 p-8 text-white shadow-lg"
        >
          <h2 className="mb-6 text-center text-2xl font-semibold">Search Student Fee Assignments</h2>

          <div className="mb-6">
            <label htmlFor="admission_number" className="mb-2 block text-sm font-medium">
              Admission Number
            </label>
            <input
              type="text"
              id="admission_number"
              value={data.admission_number}
              onChange={(e) => setData('admission_number', e.target.value)}
              className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
              placeholder="Enter student admission number"
              required
            />
            {errors.admission_number && (
              <p className="mt-1 text-sm text-red-400">{errors.admission_number}</p>
            )}
          </div>

          <div className="flex justify-end gap-4">
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
              {processing ? 'Searching...' : 'Search'}
            </button>
          </div>
        </form>
      </div>
    </AppLayout>
  );
}
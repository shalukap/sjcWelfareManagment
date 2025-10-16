import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm, router, Link } from '@inertiajs/react';
import Swal from 'sweetalert2';
import { route } from 'ziggy-js';

export default function Upgrade() {
  const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Students', href: route('students.index') },
    { title: 'Upgrade', href: route('students.upgrade.form') },
  ];

  const { data, setData, post, processing, errors } = useForm<{ academic_year: string }>({
    academic_year: new Date().getFullYear().toString(),
  });

  function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();

    Swal.fire({
      title: 'Confirm Upgrade',
      text: `This will move all active students up by one grade for academic year ${data.academic_year}. This action cannot be undone.`,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Yes, upgrade',
      cancelButtonText: 'Cancel',
    }).then((result) => {
      if (result.isConfirmed) {
        post(route('students.upgrade'), {
          onSuccess: () => {
            Swal.fire({ icon: 'success', title: 'Upgrade completed', timer: 1500, showConfirmButton: false }).then(() => {
              router.visit(route('students.index'));
            });
          },
          onError: () => {
            Swal.fire({ icon: 'error', title: 'Upgrade failed', text: 'Please check the form and try again.' });
          },
          preserveScroll: true,
        });
      }
    });
  }

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Upgrade Students" />
      <div className="p-4">
        <form onSubmit={handleSubmit} className="mx-auto max-w-xl rounded-xl bg-slate-800 p-8 text-white shadow-lg">
          <h2 className="mb-6 text-center text-2xl font-semibold">Upgrade Students</h2>

          <div className="mb-6">
            <label className="mb-2 block text-sm font-medium text-white">Academic Year</label>
            <input
              type="text"
              inputMode="numeric"
              pattern="[0-9]{4}"
              maxLength={4}
              title="Enter a 4-digit year"
              className="w-full rounded-md border border-gray-600 bg-slate-700 p-2.5 text-white focus:border-blue-500 focus:ring-blue-500"
              value={data.academic_year}
              onChange={(e) => setData('academic_year', e.target.value.replace(/[^0-9]/g, '').slice(0, 4))}
              required
            />
            {errors.academic_year && <p className="mt-1 text-sm text-red-400">{errors.academic_year}</p>}
          </div>

          <div className="flex justify-center gap-3">
            <Link href={route('students.index')} className="rounded-lg bg-gray-500 px-6 py-2 font-semibold text-white hover:bg-gray-600">
              Cancel
            </Link>
            <button type="submit" disabled={processing} className="rounded-lg bg-blue-600 px-6 py-2 font-semibold text-white hover:bg-blue-700 disabled:opacity-70">
              Upgrade
            </button>
          </div>
        </form>
      </div>
    </AppLayout>
  );
}

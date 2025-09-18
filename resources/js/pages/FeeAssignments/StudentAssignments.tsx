import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, Link } from '@inertiajs/react';
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
  academic_year: string;
  assigned_fee: number;
  adjusted_fee: number;
  adjustment_reason: string | null;
  status: string;
  created_at: string;
  updated_at: string;
}

export default function StudentAssignments({ student, feeAssignments }: { student: Student, feeAssignments: FeeAssignment[] }) {
  const breadcrumbs: BreadcrumbItem[] = [
    {
      title: 'Fee Assignments',
      href: route('fee-assignments.index'),
    },
    {
      title: 'Student Assignments',
      href: route('fee-assignments.get-student-assignments'),
    },
  ];

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'Paid': return 'bg-green-500';
      case 'Partially Paid': return 'bg-yellow-500';
      default: return 'bg-red-500';
    }
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title={`Fee Assignments - ${student.name}`} />
      <div className="h-full w-full overflow-x-auto p-4">
        <div className="mx-auto max-w-4xl rounded-xl bg-slate-800 p-8 text-white shadow-lg">
          <h2 className="mb-6 text-center text-2xl font-semibold">Fee Assignments for {student.name}</h2>

          {/* Student Information */}
          <div className="mb-8 rounded-lg bg-slate-700 p-6">
            <h3 className="mb-4 text-lg font-semibold">Student Details</h3>
            <div className="grid grid-cols-2 gap-4 md:grid-cols-4">
              <div>
                <span className="text-sm text-gray-300">Admission No:</span>
                <p className="font-medium">{student.admission_number}</p>
              </div>
              <div>
                <span className="text-sm text-gray-300">Name:</span>
                <p className="font-medium">{student.name}</p>
              </div>
              <div>
                <span className="text-sm text-gray-300">Grade:</span>
                <p className="font-medium">{student.current_grade}</p>
              </div>
              <div>
                <span className="text-sm text-gray-300">Class:</span>
                <p className="font-medium">{student.current_class}</p>
              </div>
            </div>
          </div>

          {/* Fee Assignments Table */}
          {feeAssignments.length > 0 ? (
            <div className="overflow-hidden rounded-lg bg-white shadow">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-slate-800 text-white">
                  <tr>
                    <th className="px-4 py-3 text-left text-sm font-semibold">Academic Year</th>
                    <th className="px-4 py-3 text-left text-sm font-semibold">Assigned Fee</th>
                    <th className="px-4 py-3 text-left text-sm font-semibold">Adjusted Fee</th>
                    <th className="px-4 py-3 text-left text-sm font-semibold">Adjustment Reason</th>
                    <th className="px-4 py-3 text-left text-sm font-semibold">Status</th>
                    <th className="px-4 py-3 text-left text-sm font-semibold">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-200 text-sm text-slate-800">
                  {feeAssignments.map((assignment) => (
                    <tr key={assignment.id}>
                      <td className="px-4 py-2">{assignment.academic_year}</td>
                      <td className="px-4 py-2">Rs. {assignment.assigned_fee.toLocaleString()}</td>
                      <td className="px-4 py-2">Rs. {assignment.adjusted_fee.toLocaleString()}</td>
                      <td className="px-4 py-2">{assignment.adjustment_reason || 'None'}</td>
                      <td className="px-4 py-2">
                        <span
                          className={`inline-block rounded-full px-3 py-1 text-white ${getStatusColor(assignment.status)}`}
                        >
                          {assignment.status}
                        </span>
                      </td>
                      <td className="px-4 py-2">
                        <Link
                          href={route('fee-assignments.edit', assignment.id)}
                          className="rounded-md bg-blue-600 px-3 py-1 text-white hover:bg-blue-700"
                        >
                          Adjust
                        </Link>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          ) : (
            <div className="rounded-lg bg-yellow-100 p-6 text-center text-yellow-800">
              <p className="text-lg font-semibold">No fee assignments found for this student.</p>
              <p className="mt-2">This student has not been assigned any fees for any academic year.</p>
            </div>
          )}

          <div className="mt-8 flex justify-center">
            <Link
              href={route('fee-assignments.search')}
              className="rounded-md bg-gray-600 px-6 py-2 text-white hover:bg-gray-700"
            >
              Search Another Student
            </Link>
          </div>
        </div>
      </div>
    </AppLayout>
  );
}

import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, router,  } from '@inertiajs/react';
import { useEffect, useState } from 'react';
import { CgAddR } from 'react-icons/cg';
import { FaEdit,FaMoneyBillAlt  } from 'react-icons/fa';
import { MdDeleteForever } from 'react-icons/md';
import Swal from 'sweetalert2';
import { route } from 'ziggy-js';

interface Student {
  id: number;
  admission_number: string;
  name: string;
  whatsapp_number?: string;
  current_grade: string;
  current_class: string;
  is_active: boolean;
  sibling_admission_no?: string;
}



export default function Index({ students: originalStudents }: { students: Student[] }) {
  const breadcrumbs: BreadcrumbItem[] = [
    {
      title: 'Students',
      href: route('students.index'),
    },
  ];

  const [searchAdmission, setSearchAdmission] = useState('');
  const [searchName, setSearchName] = useState('');
  const [selectedGrade, setSelectedGrade] = useState('');
  const [selectedClass, setSelectedClass] = useState('');
  const [filteredStudents, setFilteredStudents] = useState<Student[]>(originalStudents);

  const grades = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', 'A/L'];

  const getClassOptions = (grade: string) => {
    if (grade === 'A/L') {
      return ['2025', '2026', '2027', '2028', '2029', '2030', '12X', '13X'];
    } else {
      const gradeNum = parseInt(grade);
      return [
        `${gradeNum}s1`, `${gradeNum}s2`, `${gradeNum}s3`, `${gradeNum}s4`, `${gradeNum}s5`, `${gradeNum}s6`,
        `${gradeNum}T`, `${gradeNum}X`
      ];
    }
  };

  useEffect(() => {

    setSelectedClass('');
  }, [selectedGrade]);

  useEffect(() => {
    let filtered = [...originalStudents];

    if (selectedGrade) {
      filtered = filtered.filter(student => student.current_grade === selectedGrade);
    }

    if (selectedClass) {
      filtered = filtered.filter(student => student.current_class === selectedClass);
    }

    if (searchAdmission) {
      const q = searchAdmission.toLowerCase();
      filtered = filtered.filter(student => student.admission_number.toLowerCase().includes(q));
    }

    if (searchName) {
      const q = searchName.toLowerCase();
      filtered = filtered.filter(student => student.name.toLowerCase().includes(q));
    }

    setFilteredStudents(filtered);
  }, [searchAdmission, searchName, selectedGrade, selectedClass, originalStudents]);

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
        router.delete(route('students.destroy', id), {
          onSuccess: () => {
            Swal.fire('Deleted!', 'The student record has been deleted.', 'success');
          },
          onError: () => {
            Swal.fire('Error!', 'There was an error deleting the student.', 'error');
          }
        });
      }
    });
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Students" />
      <div className="h-full w-full overflow-x-auto p-4">
        <form className="mx-auto max-w-full rounded-xl bg-slate-800 p-8 text-white shadow-lg">
          <h2 className="mb-6 text-center text-2xl font-semibold">Student Records</h2>

          <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-4">
            <div>
              <label className="mb-2 block text-sm font-medium text-white">Grade</label>
              <select
                title="Select Grade"
                value={selectedGrade}
                onChange={(e) => setSelectedGrade(e.target.value)}
                className="w-full rounded-md border border-gray-600 bg-slate-700 p-2.5 text-white focus:border-blue-500 focus:ring-blue-500"
              >
                <option value="">All Grades</option>
                {grades.map((grade) => (
                  <option key={grade} value={grade}>
                    {grade === 'A/L' ? 'A/L' : `Grade ${grade}`}
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="mb-2 block text-sm font-medium text-white">Class</label>
              <select
                title="Select Class"
                value={selectedClass}
                onChange={(e) => setSelectedClass(e.target.value)}
                className="w-full rounded-md border border-gray-600 bg-slate-700 p-2.5 text-white focus:border-blue-500 focus:ring-blue-500"
                disabled={!selectedGrade}
              >
                <option value="">All Classes</option>
                {selectedGrade && getClassOptions(selectedGrade).map((classOption) => (
                  <option key={classOption} value={classOption}>
                    {classOption}
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="mb-2 block text-sm font-medium text-white">Search by Admission No</label>
              <input
                type="text"
                className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Admission No"
                value={searchAdmission}
                onChange={(e) => setSearchAdmission(e.target.value)}
              />
            </div>

            <div>
              <label className="mb-2 block text-sm font-medium text-white">Search by Name</label>
              <input
                type="text"
                className="w-full rounded-md border border-gray-300 bg-slate-700 px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Student Name"
                value={searchName}
                onChange={(e) => setSearchName(e.target.value)}
              />
            </div>
          </div>
        </form>

        <div className="mt-6 overflow-hidden rounded-lg bg-white shadow">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-slate-800 text-white">
              <tr>
                <th className="px-4 py-3 text-left text-sm font-semibold">Admission No</th>
                <th className="px-4 py-3 text-left text-sm font-semibold">Name</th>
                <th className="px-4 py-3 text-left text-sm font-semibold">WhatsApp</th>
                <th className="px-4 py-3 text-left text-sm font-semibold">Sibling Admission</th>
                <th className="px-4 py-3 text-left text-sm font-semibold">Grade</th>
                <th className="px-4 py-3 text-left text-sm font-semibold">Class</th>
                <th className="px-4 py-3 text-left text-sm font-semibold">Status</th>
                <th className="px-4 py-3 text-left text-sm font-semibold">Payment</th>
                <th className="px-4 py-3 text-left text-sm font-semibold">Action</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200 text-sm text-slate-800">
              {filteredStudents.map((s) => (
                <tr key={s.id}>
                  <td className="px-4 py-2">{s.admission_number}</td>
                  <td className="px-4 py-2">{s.name}</td>
                  <td className="px-4 py-2">{s.whatsapp_number || 'N/A'}</td>
                  <td className="px-4 py-2">{s.sibling_admission_no || 'N/A'}</td>
                  <td className="px-4 py-2">{s.current_grade}</td>
                  <td className="px-4 py-2">{s.current_class}</td>
                  <td className="px-4 py-2">
                    <span
                      className={`inline-block rounded-full px-3 py-1 text-white ${
                        s.is_active ? 'bg-green-500' : 'bg-red-500'
                      }`}
                    >
                      {s.is_active ? 'Active' : 'Inactive'}
                    </span>
                  </td>
                  <td className="px-4 py-2">

                    <Link
                      href={`${route('payments.create')}?admission_number=${s.admission_number}`}
                      className="inline-flex items-center px-3 py-1 text-sm font-medium text-white bg-red-600 rounded-xl hover:bg-blue-700 transition-colors"
                    >
                       <FaMoneyBillAlt className='mr-2'/>
                      Pay
                    </Link>
                  </td>
                  <td className="flex items-center gap-3 px-4 py-2">
                    <Link as="button" href={route('students.edit', s.id)}>
                      <FaEdit className="text-2xl hover:text-blue-700" />
                    </Link>
                    <button onClick={() => handleDelete(s.id)} title="Delete Student">
                      <MdDeleteForever className="text-3xl hover:text-red-700" />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* Floating Add Button */}
        <div className="fixed right-4 bottom-4">
          <Link
            href={route('students.create')}
            className="flex items-center justify-center rounded-full bg-blue-600 p-4 text-white shadow-lg hover:bg-blue-700"
          >
            <CgAddR className="text-3xl" />
          </Link>
        </div>
      </div>
    </AppLayout>
  );
}

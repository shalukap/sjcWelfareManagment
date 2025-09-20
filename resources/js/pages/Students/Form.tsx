import { Input } from '@/components/ui/input';
import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, useForm, Link, router } from '@inertiajs/react';
import Swal from 'sweetalert2';
import { route } from 'ziggy-js';

interface Student {
  id?: number;
  admission_number: string;
  name: string;
  whatsapp_number?: string;
  current_grade: string;
  current_class: string;
  is_active: boolean;
}

interface Props {
  student?: Student;
  isEdit: boolean;
  errors?: Record<string, string>;
}

export default function StudentForm({ student, isEdit, errors: serverErrors }: Props) {
  const breadcrumbs: BreadcrumbItem[] = [
    {
      title: 'Students',
      href: route('students.index'),
    },
    {
      title: `${isEdit ? 'Edit' : 'Add'} Student`,
      href: route(isEdit ? 'students.edit' : 'students.create', isEdit && student ? student.id : ''),
    },
  ];

  const { data, setData, post, put, processing, errors: formErrors } = useForm({
    admission_number: student?.admission_number || '',
    name: student?.name || '',
    whatsapp_number: student?.whatsapp_number || '',
    current_grade: student?.current_grade || '',
    current_class: student?.current_class || '',
    is_active: student?.is_active ?? true,
  });


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

  const validateWhatsappNumber = (value: string): boolean => {
    if (!value) return true; // Optional field
    const phoneRegex = /^\d{10}$/;
    return phoneRegex.test(value);
  };

  const handleWhatsappInput = (value: string) => {
    const numericValue = value.replace(/\D/g, '');
    const truncatedValue = numericValue.slice(0, 10);
    setData('whatsapp_number', truncatedValue);
  };

  function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();

    if (!validateWhatsappNumber(data.whatsapp_number)) {
      Swal.fire({
        icon: 'error',
        title: 'Invalid WhatsApp Number',
        text: 'WhatsApp number must be exactly 10 digits if provided',
      });
      return;
    }

    if (isEdit && student?.id) {
      put(route('students.update', student.id), {
        onSuccess: () => {
          Swal.fire({
            position: 'top-end',
            icon: 'success',
            title: 'Student has been updated successfully',
            showConfirmButton: false,
            timer: 1500,
          }).then(() => {
            router.visit(route('students.index'));
          });
        },
        onError: (errors) => {
          if (errors.admission_number) {
            Swal.fire({
              icon: 'error',
              title: 'Validation Error',
              text: errors.admission_number,
            });
          }
        },
      });
    } else {
      post(route('students.store'), {
        onSuccess: () => {
          Swal.fire({
            position: 'top-end',
            icon: 'success',
            title: 'New Student has been saved successfully',
            showConfirmButton: false,
            timer: 1500,
          }).then(() => {
            router.visit(route('students.index'));
          });
        },
        onError: (errors) => {
          if (errors.admission_number) {
            Swal.fire({
              icon: 'error',
              title: 'Validation Error',
              text: errors.admission_number,
            });
          }
        },
      });
    }
  }

  const allErrors = { ...formErrors, ...serverErrors };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title={isEdit ? 'Edit Student' : 'Add Student'} />
      <div className="p-4">
        <form
          onSubmit={handleSubmit}
          className="mx-auto max-w-4xl rounded-xl bg-slate-800 p-8 text-white shadow-lg"
        >
          <h2 className="mb-6 text-center text-2xl font-semibold">
            {isEdit ? 'Edit Student' : 'Add New Student'}
          </h2>

          <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
            <div>
              <label className="mb-2 block text-sm font-medium text-white">
                Admission Number *
              </label>
              <Input
                type="text"
                name="admission_number"
                placeholder="Enter Admission Number"
                required
                value={data.admission_number}
                onChange={(e) => setData('admission_number', e.target.value)}
                className="bg-slate-700 text-white"
                readOnly={isEdit}
              />
              {allErrors.admission_number && (
                <p className="mt-1 text-sm text-red-400">{allErrors.admission_number}</p>
              )}
            </div>

            <div>
              <label className="mb-2 block text-sm font-medium text-white">Name *</label>
              <Input
                type="text"
                name="name"
                placeholder="Enter Student Name"
                required
                value={data.name}
                onChange={(e) => setData('name', e.target.value)}
                className="bg-slate-700 text-white"
              />
              {allErrors.name && (
                <p className="mt-1 text-sm text-red-400">{allErrors.name}</p>
              )}
            </div>

            <div>
              <label className="mb-2 block text-sm font-medium text-white">
                WhatsApp Number
              </label>
              <Input
                type="text"
                name="whatsapp_number"
                placeholder="0771234567"
                value={data.whatsapp_number}
                onChange={(e) => handleWhatsappInput(e.target.value)}
                pattern="\d{0,10}"
                title="Please enter up to 10 digits"
                className="bg-slate-700 text-white"
              />
              {data.whatsapp_number && !validateWhatsappNumber(data.whatsapp_number) && (
                <p className="mt-1 text-sm text-red-400">Must be exactly 10 digits if provided</p>
              )}
              {allErrors.whatsapp_number && (
                <p className="mt-1 text-sm text-red-400">{allErrors.whatsapp_number}</p>
              )}
            </div>

            <div>
              <label className="mb-2 block text-sm font-medium text-white">Current Grade *</label>
              <select
                name="current_grade"
                required
                value={data.current_grade}
                onChange={(e) => {
                  setData('current_grade', e.target.value);
                  setData('current_class', '');
                }}
                title="Select Current Grade"
                className="w-full rounded-md border border-gray-600 bg-slate-700 p-2.5 text-white focus:border-blue-500 focus:ring-blue-500"
              >
                <option value="">Select Grade</option>
                {grades.map((grade) => (
                  <option key={grade} value={grade}>
                    {grade === 'A/L' ? 'A/L' : `Grade ${grade}`}
                  </option>
                ))}
              </select>
              {allErrors.current_grade && (
                <p className="mt-1 text-sm text-red-400">{allErrors.current_grade}</p>
              )}
            </div>

            <div>
              <label className="mb-2 block text-sm font-medium text-white">Current Class *</label>
              <select
                name="current_class"
                required
                value={data.current_class}
                onChange={(e) => setData('current_class', e.target.value)}
                title="Select Current Class"
                className="w-full rounded-md border border-gray-600 bg-slate-700 p-2.5 text-white focus:border-blue-500 focus:ring-blue-500"
                disabled={!data.current_grade}
              >
                <option value="">Select Class</option>
                {data.current_grade && getClassOptions(data.current_grade).map((classOption) => (
                  <option key={classOption} value={classOption}>
                    {classOption}
                  </option>
                ))}
              </select>
              {allErrors.current_class && (
                <p className="mt-1 text-sm text-red-400">{allErrors.current_class}</p>
              )}
            </div>

            <div className="flex items-center gap-2 pt-6">
              <input
                type="checkbox"
                id="is_active"
                name="is_active"
                checked={data.is_active}
                onChange={(e) => setData('is_active', e.target.checked)}
                className="h-4 w-4 rounded border-gray-300 bg-slate-700 text-blue-600 focus:ring-blue-500"
              />
              <label htmlFor="is_active" className="text-sm font-medium text-white">
                Active Status
              </label>
            </div>
          </div>

          <div className="mt-8 flex justify-center gap-4">
            <Link
              href={route('students.index')}
              className="rounded-lg bg-gray-500 px-6 py-2 font-semibold text-white transition-all hover:bg-gray-600"
            >
              Cancel
            </Link>
            <button
              type="submit"
              disabled={processing}
              className="rounded-lg bg-blue-600 px-6 py-2 font-semibold text-white transition-all hover:bg-blue-700 disabled:opacity-70"
            >
              {isEdit ? 'Update Student' : 'Add Student'}
            </button>
          </div>
        </form>
      </div>
    </AppLayout>
  );
}

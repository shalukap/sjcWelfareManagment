import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, Link, router  } from '@inertiajs/react';

import { useEffect, useState } from 'react';
import { CgAddR } from 'react-icons/cg';
import { FaEdit,FaMoneyBillAlt  } from 'react-icons/fa';
import { MdDeleteForever } from 'react-icons/md';
import Swal from 'sweetalert2';
import { route } from 'ziggy-js';





export default function Index() {
  const [file,setFile]=useState<File | null>(null);
  const breadcrumbs: BreadcrumbItem[] = [
    {
      title: 'Upload Students',
      href: route('uploadCsv.index',undefined,false),
    },
  ];

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if(e.target.files && e.target.files.length > 0){
      setFile(e.target.files[0]);
    }
  };

  const handleSubmit=async (e:React.FormEvent)=>{
      e.preventDefault();

      if(!file){
        Swal.fire('Error', 'Please select a CSV file', 'error');       
        return;
      }

      const formData = new FormData();
      formData.append('file', file);
     
      router.post(route('uploadCsv.upload'), formData, {
        onSuccess: () => {
          Swal.fire('Success', 'CSV file uploaded successfully', 'success');
        },
        onError: () => {
          Swal.fire('Error', 'Failed to upload CSV file', 'error');
        },
      });
  }

  

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Upload Students" />
       <div className="p-4">
      <h2 className="text-xl font-bold mb-4">Upload CSV File</h2>
      <form onSubmit={handleSubmit}>
        <input type="file" accept=".csv" className='bg-blue-400' onChange={handleFileChange}/>
        <button type="submit" className="ml-2 bg-blue-500 text-white px-4 py-1 rounded" >
          Upload
        </button>
      </form>
     
    </div>
    </AppLayout>
  );
}

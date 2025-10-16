import React from 'react'

export default function index() {
    const handleBackup = async () => {
       try{
        const response = await fetch('/backup', { method: 'GET' });
        if (!response.ok) {
          throw new Error('Backup failed');
          return;
        }
        const blob = await response.blob();
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = 'database_backup.sql';
        link.click();
        link.remove();
        URL.revokeObjectURL(url);
       }catch(error){
        console.error(error);
       }
    };
     
  return (
    <div>
        <button onClick={handleBackup} className='bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700'>
            Backup Database
        </button>
    </div>
  )
}

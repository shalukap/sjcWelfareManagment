import AppLayout from '@/layouts/app-layout'
import { Head, router } from '@inertiajs/react'
import React, { useState } from 'react'
import { route } from 'ziggy-js';

export default function Index() {
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');

  const handleSearch = () => {
    router.get(route('generatecollectionreport'), { startDate, endDate });
    window.open(route('generatecollectionreport', { startDate, endDate }), '_blank');
  }

  return (
    <AppLayout>
      <Head title="Collection Report" />

      <div className="m-6 p-6 bg-[var(--background)] text-[var(--foreground)] border border-[var(--border)] rounded-[var(--radius)] flex flex-col gap-6 items-center text-center shadow-lg">
        <h1 className="text-2xl font-semibold mb-4">
          Collection Report
        </h1>

        <div className="flex gap-6 w-full max-w-2xl text-black">
          {/* Start Date */}
          <div className="flex-1 flex flex-col">
            <label className="text-sm font-medium mb-1 text-[var(--foreground)]">
              Start Date
            </label>
            <input
              type="date"
              className="px-4 py-2 border border-[var(--border)] rounded-lg focus:outline-none focus:ring-2 focus:ring-[var(--primary)] bg-slate-800 text-[var(--card-foreground)]"
              value={startDate}
              onChange={(e) => setStartDate(e.target.value)}
            />
          </div>

          {/* End Date */}
          <div className="flex-1 flex flex-col">
            <label className="text-sm font-medium mb-1 text-[var(--foreground)]">
              End Date
            </label>
            <input
              type="date"
              className="px-4 py-2 border border-[var(--border)] rounded-lg focus:outline-none focus:ring-2 focus:ring-[var(--primary)] bg-slate-800 text-[var(--card-foreground)]"
              value={endDate}
              onChange={(e) => setEndDate(e.target.value)}
            />
          </div>
        </div>

        {/* Print Button */}
        <button
          className="px-5 py-2 bg-[var(--primary)] text-[var(--primary-foreground)] rounded-lg hover:bg-[var(--primary-foreground)] hover:text-[var(--primary)] transition-all w-full"
          onClick={handleSearch}
        >
          Print Report
        </button>
      </div>
    </AppLayout>
  )
}

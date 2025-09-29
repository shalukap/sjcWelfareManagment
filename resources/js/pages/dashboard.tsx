import { PlaceholderPattern } from '@/components/ui/placeholder-pattern';
import AppLayout from '@/layouts/app-layout';
import { dashboard } from '@/routes';
import { type BreadcrumbItem } from '@/types';
import { Head, usePage } from '@inertiajs/react';
import { BsCashCoin } from "react-icons/bs";
import { FaCheque } from "react-icons/fa";
import { MdPayment } from "react-icons/md";

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Dashboard',
        href: dashboard().url,
    },
];

export default function Dashboard() {
    const {studentsCount,cashToday,chequeToday,onlineToday}=usePage<{
        studentsCount: number;
        teachersCount: number;
        cashToday: number;
        chequeToday: number;
        onlineToday: number;
    }>().props
    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Dashboard" />
            <div className="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
                <div className="grid auto-rows-min gap-4 md:grid-cols-3">
                    <div className="relative aspect-video overflow-hidden rounded-xl border border-sidebar-border/70 dark:border-sidebar-border">
                        <PlaceholderPattern className="absolute inset-0 size-full bg-gradient-to-r from-green-400 via-emerald-500 to-green-700 dark:stroke-neutral-100/20" />
                        <p className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-center text-white text-2xl font-bold drop-shadow-2xl">Total Students:- {studentsCount}</p>
                    </div>
                    <div className="relative aspect-video overflow-hidden rounded-xl border border-sidebar-border/70 dark:border-sidebar-border">
                        <PlaceholderPattern className="absolute inset-0 size-full bg-gradient-to-r from-blue-400 via-indigo-500 to-purple-600 dark:stroke-neutral-100/20" />
                        
                        <div className="absolute inset-0 flex flex-col items-center justify-center text-white font-bold drop-shadow">
                            <p className="text-2xl mb-4">Today Collection</p>
                            <div className="space-y-2 text-lg">
                            <p className="flex border-b border-white/40 pb-1">  Cash: Rs.{cashToday}</p>
                            <p className="border-b border-white/40 pb-1"> Cheques: Rs.{chequeToday}</p>
                            <p>Online: Rs.{onlineToday}</p>
                            </div>
                        </div>
                    
                        
                    </div>
                    <div className="relative aspect-video overflow-hidden rounded-xl border border-sidebar-border/70 dark:border-sidebar-border">
                          <PlaceholderPattern className="absolute inset-0 size-full bg-gradient-to-r from-pink-400 via-red-500 to-orange-500 dark:stroke-neutral-100/20" />
                        <p className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-center text-white text-2xl font-bold drop-shadow-2xl">Today : {new Date().toDateString()}</p>
                    </div>
                </div>
                <div className="relative min-h-[100vh] flex-1 overflow-hidden rounded-xl border border-sidebar-border/70 md:min-h-min dark:border-sidebar-border">
                    <PlaceholderPattern className="absolute inset-0 size-full stroke-neutral-900/20 dark:stroke-neutral-100/20" />
                </div>
            </div>
        </AppLayout>
    );
}

import { Head, router } from "@inertiajs/react"
import AppLayout from "@/layouts/app-layout"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Label } from "@/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { useState } from "react"
import { route } from "ziggy-js"

export default function index() {
  const[setGrade, setSetGrade] = useState('');
  const[setClass, setSetClass] = useState('');

  const grades = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', 'A/L'];

  const getClassOptions = (grade: string) => {
    if (grade === 'A/L') {
      return ['2025', '2026', '2027', '2028', '2029', '2030', '12X', '13X'];
    } else {
      const gradeNum = parseInt(grade);
      return [
        `${gradeNum}s1`, `${gradeNum}s2`, `${gradeNum}s3`, `${gradeNum}s4`, `${gradeNum}s5`, `${gradeNum}s6`,
        `${gradeNum}T`, `${gradeNum}X`,'ALL'
      ];
    }
  };

  const handlePrintReport=()=>{
    router.get(route('generateDueReport'), { grade: setGrade, class: setClass });
    window.open(route('generateDueReport', { grade: setGrade, class: setClass }), '_blank');
  }

  return (
   <AppLayout>
      <Head title="Due Report" />
      <div className="p-6 mx-auto w-full ">
        <Card className="shadow-md rounded-2xl bg-slate-800 flex flex-col gap-6">
          <CardHeader>
            <CardTitle className="text-xl font-semibold">Generate Due Report</CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
             <div className="flex gap-6 mb-6">
            {/* Grade Selection */}
            <div className="flex-1">
              <Label>Select Grade</Label>
              <Select onValueChange={(value) => setSetGrade(value)}>
                <SelectTrigger>
                  <SelectValue placeholder="Choose a grade" />
                </SelectTrigger>
                <SelectContent>
                  {grades.map((grade) => (
                    <SelectItem key={grade} value={grade}>
                      {grade}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            {/* Class Selection */}
            <div className="flex-1">
              <Label>Select Class</Label>
              <Select 
                onValueChange={(value) => setSetClass(value)}
                disabled={!setGrade}
              >
                <SelectTrigger>
                  <SelectValue placeholder="Choose a class" />
                </SelectTrigger>
                <SelectContent>
                  {setGrade &&
                    getClassOptions(setGrade).map((cls) => (
                      <SelectItem key={cls} value={cls}>
                        {cls}
                      </SelectItem>
                    ))}
                </SelectContent>
              </Select>
            </div>
          </div>
            {/* Action Button */}
            <div className="pt-4">
              <Button className="w-full" onClick={handlePrintReport}>Print Due Report</Button>
            </div>
          </CardContent>
        </Card>
      </div>
    </AppLayout>
  )
}


import { PageProps as InertiaPageProps } from '@inertiajs/core'

declare module '@inertiajs/core' {
  interface PageProps extends InertiaPageProps {
    studentsCount: number
  
  }
}

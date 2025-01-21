import { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Meals - Meal Planner',
  description: 'Meal planning and management',
}

export default function MealsPage() {
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">Meals</h1>
      <div className="bg-white shadow-md rounded-lg p-6">
        <div className="space-y-4">
          {/* Meal list will be implemented here */}
          <p className="text-gray-600">Meal planning interface coming soon...</p>
        </div>
      </div>
    </div>
  )
}

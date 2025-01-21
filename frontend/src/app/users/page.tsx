import { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Users - Meal Planner',
  description: 'User management for Meal Planner application',
}

export default function UsersPage() {
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">Users</h1>
      <div className="bg-white shadow-md rounded-lg p-6">
        <div className="space-y-4">
          {/* User list will be implemented here */}
          <p className="text-gray-600">User list coming soon...</p>
        </div>
      </div>
    </div>
  )
}

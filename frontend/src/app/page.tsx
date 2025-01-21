import Image from "next/image";

export default function Home() {
  return (
    <div className="container mx-auto px-4 py-16">
      <div className="text-center">
        <h1 className="text-4xl font-bold text-gray-900 mb-8">
          Welcome to Meal Planner
        </h1>
        <p className="text-xl text-gray-600 mb-12 max-w-2xl mx-auto">
          Plan your meals, manage your recipes, and organize your cooking schedule all in one place.
        </p>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-4xl mx-auto">
          <div className="bg-white p-6 rounded-lg shadow-md">
            <h2 className="text-2xl font-semibold mb-4">Meal Planning</h2>
            <p className="text-gray-600">
              Create and manage your weekly meal plans with ease.
            </p>
          </div>
          <div className="bg-white p-6 rounded-lg shadow-md">
            <h2 className="text-2xl font-semibold mb-4">User Management</h2>
            <p className="text-gray-600">
              Manage users and their preferences for a personalized experience.
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}

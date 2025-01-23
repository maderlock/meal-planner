-- Add auth fields to User table
ALTER TABLE "users" ADD COLUMN IF NOT EXISTS "password" TEXT NOT NULL DEFAULT '';
ALTER TABLE "users" ADD COLUMN IF NOT EXISTS "display_name" TEXT;
ALTER TABLE "users" ADD COLUMN IF NOT EXISTS "photo_url" TEXT;
ALTER TABLE "users" ADD COLUMN IF NOT EXISTS "email_verified" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "users" ADD COLUMN IF NOT EXISTS "reset_token" TEXT;
ALTER TABLE "users" ADD COLUMN IF NOT EXISTS "reset_token_expiry" TIMESTAMP WITH TIME ZONE;

-- Update Meal table
ALTER TABLE "meals" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "meals" RENAME COLUMN "image_url" TO "imageUrl";
ALTER TABLE "meals" ALTER COLUMN "imageUrl" SET NOT NULL;

-- Add endDate to WeeklyPlan
ALTER TABLE "weekly_plans" ADD COLUMN IF NOT EXISTS "end_date" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Add indexes for better query performance
CREATE INDEX IF NOT EXISTS "weekly_plans_user_id_idx" ON "weekly_plans"("user_id");
CREATE INDEX IF NOT EXISTS "meal_assignments_weekly_plan_id_idx" ON "meal_assignments"("weekly_plan_id");
CREATE INDEX IF NOT EXISTS "meal_assignments_meal_id_idx" ON "meal_assignments"("meal_id");
CREATE INDEX IF NOT EXISTS "favorite_meals_user_id_idx" ON "favorite_meals"("user_id");
CREATE INDEX IF NOT EXISTS "favorite_meals_meal_id_idx" ON "favorite_meals"("meal_id");

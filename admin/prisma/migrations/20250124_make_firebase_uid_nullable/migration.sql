-- Make firebase_uid nullable
ALTER TABLE "users" ALTER COLUMN "firebase_uid" DROP NOT NULL;

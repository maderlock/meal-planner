/**
 * Date utility functions for the meal planner application.
 * Provides consistent date handling across the application.
 */

/**
 * Checks if a date is a valid week start date (Monday at 00:00:00).
 * @param date The date to check
 * @returns true if the date is a valid week start date
 */
export function isValidWeekStart(date: Date): boolean {
  // Check if it's a Monday (1 = Monday in JavaScript's getDay())
  if (date.getDay() !== 1) return false;

  // Check if it's at midnight (00:00:00.000)
  return date.getHours() === 0 &&
         date.getMinutes() === 0 &&
         date.getSeconds() === 0 &&
         date.getMilliseconds() === 0;
}

/**
 * Gets the start of the week (Monday at 00:00:00) for a given date.
 * @param date The date to get the week start for
 * @returns The start of the week
 */
export function getWeekStart(date: Date): Date {
  const day = date.getDay() || 7; // Convert Sunday (0) to 7
  const diff = date.getDate() - day + 1; // Adjust to Monday
  return new Date(date.getFullYear(), date.getMonth(), diff, 0, 0, 0, 0);
}

/**
 * Formats a date as an ISO string at midnight
 * @param date The date to format
 * @returns ISO string at midnight
 */
export function toMidnightIsoString(date: Date): string {
  return new Date(
    date.getFullYear(),
    date.getMonth(),
    date.getDate(),
    0, 0, 0, 0
  ).toISOString();
}

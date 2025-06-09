-- WARNING: This will delete ALL users and their data!
-- Use only for development/testing purposes

-- Delete all user data from custom tables
DELETE FROM notifications;
DELETE FROM apartment_memberships;
DELETE FROM waitlist;
DELETE FROM book_reviews;
DELETE FROM borrow_requests;
DELETE FROM book_listings;
DELETE FROM books;
DELETE FROM profiles;
DELETE FROM user_details;

-- Delete all authentication users
DELETE FROM auth.users;

-- Reset identity sequences (optional, for clean IDs)
-- Note: Only use if your tables have auto-incrementing IDs
-- ALTER SEQUENCE IF EXISTS user_details_id_seq RESTART WITH 1;
-- ALTER SEQUENCE IF EXISTS profiles_id_seq RESTART WITH 1;

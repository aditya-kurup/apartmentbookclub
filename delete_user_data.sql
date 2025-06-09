-- Delete all user data from custom tables
-- Replace 'USER_ID_HERE' with the actual user ID you want to delete

-- First, delete dependent records (in reverse dependency order)
DELETE FROM notifications WHERE user_id = 'USER_ID_HERE';
DELETE FROM apartment_memberships WHERE user_id = 'USER_ID_HERE';
DELETE FROM waitlist WHERE user_id = 'USER_ID_HERE';
DELETE FROM book_reviews WHERE user_id = 'USER_ID_HERE';
DELETE FROM borrow_requests WHERE borrower_id = 'USER_ID_HERE' OR lender_id = 'USER_ID_HERE';
DELETE FROM book_listings WHERE owner_id = 'USER_ID_HERE';
DELETE FROM books WHERE lender_id = 'USER_ID_HERE';
DELETE FROM profiles WHERE user_id = 'USER_ID_HERE';
DELETE FROM user_details WHERE id = 'USER_ID_HERE';

-- Finally, delete the auth user
DELETE FROM auth.users WHERE id = 'USER_ID_HERE';

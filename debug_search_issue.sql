-- Comprehensive debug script to check search issues
-- Run this in Supabase SQL Editor

-- 1. Check if books exist at all
SELECT 'Total books in database:' as info, COUNT(*) as count FROM books;

-- 2. List all books
SELECT 
    title, 
    author, 
    category,
    is_available,
    apartment_id,
    lender_id,
    created_at
FROM books 
ORDER BY title;

-- 3. Check specifically for Atomic Habits
SELECT 'Atomic Habits search:' as info;
SELECT * FROM books WHERE title ILIKE '%atomic%' OR author ILIKE '%clear%';

-- 4. Check if RLS is enabled on books table
SELECT 
    schemaname,
    tablename,
    rowsecurity 
FROM pg_tables 
WHERE tablename = 'books';

-- 5. Check RLS policies on books table
SELECT 
    policyname,
    cmd,
    qual,
    with_check
FROM pg_policies 
WHERE tablename = 'books';

-- 6. Check current user context (auth.uid())
SELECT 
    'Current auth user:' as info,
    auth.uid() as current_user_id,
    auth.role() as current_role;

-- 7. Test search query directly (this mimics the app's search)
SELECT 
    'Search test results:' as info;
SELECT * FROM books 
WHERE title ILIKE '%atomic%' OR author ILIKE '%clear%'
ORDER BY created_at DESC;

-- 8. Test if user_details table has data
SELECT 'User details count:' as info, COUNT(*) as count FROM user_details;

-- 9. Check apartment_id relationships
SELECT 
    'Apartment-Book relationships:' as info;
SELECT 
    b.title,
    b.apartment_id,
    a.apt_name
FROM books b
LEFT JOIN apartments a ON b.apartment_id = a.id
LIMIT 5;

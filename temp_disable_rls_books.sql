-- Temporary fix: Disable RLS on books table for testing
-- WARNING: Only use this for development/testing

-- Disable RLS on books table temporarily
ALTER TABLE books DISABLE ROW LEVEL SECURITY;

-- Test your search now - it should show all books

-- Re-enable RLS when done testing
-- ALTER TABLE books ENABLE ROW LEVEL SECURITY;

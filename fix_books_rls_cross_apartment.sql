-- Fix RLS policies to allow users to see books from all apartments
-- This enables cross-apartment book sharing in the book club

-- First, drop existing restrictive policies
DROP POLICY IF EXISTS "Users can view books in their apartment" ON books;
DROP POLICY IF EXISTS "Users can insert books in their apartment" ON books;
DROP POLICY IF EXISTS "Users can update their own books" ON books;
DROP POLICY IF EXISTS "Users can delete their own books" ON books;

-- Create new permissive policies for book sharing across apartments

-- Allow authenticated users to view ALL books (cross-apartment sharing)
CREATE POLICY "Authenticated users can view all books" ON books
    FOR SELECT USING (auth.role() = 'authenticated');

-- Allow users to insert books (they can add books to any apartment's collection)
CREATE POLICY "Authenticated users can insert books" ON books
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Allow users to update only their own books
CREATE POLICY "Users can update their own books" ON books
    FOR UPDATE USING (lender_id = auth.uid());

-- Allow users to delete only their own books
CREATE POLICY "Users can delete their own books" ON books
    FOR DELETE USING (lender_id = auth.uid());

-- Keep RLS enabled but with more permissive policies
ALTER TABLE books ENABLE ROW LEVEL SECURITY;

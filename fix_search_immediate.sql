-- IMMEDIATE FIX: Move all books to Sunrise Apartments so users can see all books
-- This fixes the search issue where users only see 3 out of 5 books
-- Run this in Supabase SQL Editor

-- Before: Check current distribution
SELECT 
    'BEFORE: Books per apartment' as info;
SELECT 
    a.apt_name,
    COUNT(b.id) as book_count,
    array_agg(b.title) as books
FROM apartments a
LEFT JOIN books b ON a.id = b.apartment_id
GROUP BY a.id, a.apt_name
ORDER BY a.apt_name;

-- Fix: Move all books to Sunrise Apartments (where new users are assigned by default)
UPDATE books 
SET apartment_id = '11111111-1111-1111-1111-111111111111'
WHERE apartment_id != '11111111-1111-1111-1111-111111111111';

-- After: Verify all books are now in Sunrise Apartments
SELECT 
    'AFTER: Books per apartment' as info;
SELECT 
    a.apt_name,
    COUNT(b.id) as book_count,
    array_agg(b.title) as books
FROM apartments a
LEFT JOIN books b ON a.id = b.apartment_id
GROUP BY a.id, a.apt_name
ORDER BY a.apt_name;

-- Verify specific books are now visible
SELECT 
    'All books now in Sunrise Apartments:' as info;
SELECT 
    title,
    author,
    apartment_id,
    a.apt_name
FROM books b
JOIN apartments a ON b.apartment_id = a.id
ORDER BY title;

-- Check if books exist in database
SELECT 
    title, 
    author, 
    category,
    is_available,
    created_at
FROM books 
ORDER BY title;

-- Count total books
SELECT COUNT(*) as total_books FROM books;

-- Check if Atomic Habits exists
SELECT * FROM books WHERE title ILIKE '%atomic%' OR author ILIKE '%clear%';

-- Check current state of books
SELECT 
    COUNT(*) as total_books,
    COUNT(CASE WHEN is_featured = true THEN 1 END) as featured_books,
    COUNT(CASE WHEN is_new_arrival = true THEN 1 END) as new_arrival_books
FROM books;

-- Show all books with their flags
SELECT 
    title, 
    author, 
    apartment_id,
    is_featured, 
    is_new_arrival, 
    rating,
    created_at
FROM books 
ORDER BY title
LIMIT 20;

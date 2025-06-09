-- Update some books to be featured and new arrivals for testing
-- This will help test the Featured Books and New Arrivals functionality

-- Set some books as featured (high-quality/popular books)
UPDATE books 
SET is_featured = true 
WHERE title IN (
    'To Kill a Mockingbird',
    'Pride and Prejudice', 
    'The Great Gatsby',
    'Lord of the Flies',
    'Jane Eyre'
) OR rating >= 4.5;

-- Set some books as new arrivals (recently added books)
UPDATE books 
SET is_new_arrival = true 
WHERE title IN (
    'The Seven Husbands of Evelyn Hugo',
    'Project Hail Mary',
    'The Midnight Library',
    'Atomic Habits',
    'Where the Crawdads Sing'
) OR created_at >= NOW() - INTERVAL '30 days';

-- Also set a few random books as featured for variety
UPDATE books 
SET is_featured = true 
WHERE id IN (
    SELECT id FROM books 
    WHERE is_featured = false 
    ORDER BY RANDOM() 
    LIMIT 3
);

-- Also set a few random books as new arrivals for variety  
UPDATE books 
SET is_new_arrival = true 
WHERE id IN (
    SELECT id FROM books 
    WHERE is_new_arrival = false 
    ORDER BY RANDOM() 
    LIMIT 4
);

-- Check the results
SELECT 
    title, 
    author, 
    is_featured, 
    is_new_arrival, 
    rating,
    created_at
FROM books 
WHERE is_featured = true OR is_new_arrival = true
ORDER BY is_featured DESC, is_new_arrival DESC;

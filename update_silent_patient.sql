-- Update The Silent Patient to be featured since it has a 4.5 rating
UPDATE books 
SET is_featured = true 
WHERE title = 'The Silent Patient';

-- Check the updated result
SELECT 
    title,
    author,
    is_featured,
    is_new_arrival,
    rating,
    apartment_id
FROM books 
WHERE apartment_id = '11111111-1111-1111-1111-111111111111'
ORDER BY is_featured DESC, is_new_arrival DESC;

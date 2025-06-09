-- Move test user to different apartments to see more books
-- Run this to check which apartment your user is currently in:

SELECT 
    ud.username,
    ud.email,
    ud.apartment_id,
    a.apt_name
FROM user_details ud
LEFT JOIN apartments a ON ud.apartment_id = a.id
WHERE ud.email = 'your-test-email@example.com'; -- Replace with your actual email

-- Option 1: Move your user to Skyline Towers (where Atomic Habits is)
-- UPDATE user_details 
-- SET apartment_id = '33333333-3333-3333-3333-333333333333'
-- WHERE email = 'your-test-email@example.com'; -- Replace with your actual email

-- Option 2: Move all books to Sunrise Apartments (where your user is)
UPDATE books SET apartment_id = '11111111-1111-1111-1111-111111111111';

-- After running one of the above, verify the changes:
SELECT 
    b.title,
    b.apartment_id,
    a.apt_name
FROM books b
LEFT JOIN apartments a ON b.apartment_id = a.id
ORDER BY b.title;

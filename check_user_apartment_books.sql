-- Check which apartment the current user belongs to and what books are in that apartment
-- Replace 'YOUR_USER_EMAIL' with your actual email address

-- First, find your user and apartment
SELECT 
    ud.id as user_id,
    ud.username,
    ud.email,
    ud.apartment_id,
    a.apt_name
FROM user_details ud
LEFT JOIN apartments a ON ud.apartment_id = a.id
WHERE ud.email = 'YOUR_USER_EMAIL'; -- Replace with your email

-- Then check all books in that apartment with their flags
SELECT 
    b.title,
    b.author,
    b.is_featured,
    b.is_new_arrival,
    b.rating,
    b.apartment_id,
    a.apt_name
FROM books b
LEFT JOIN apartments a ON b.apartment_id = a.id
WHERE b.apartment_id = (
    SELECT apartment_id 
    FROM user_details 
    WHERE email = 'YOUR_USER_EMAIL' -- Replace with your email
)
ORDER BY b.is_featured DESC, b.is_new_arrival DESC;

-- Simple Data for Development Testing
-- This script temporarily removes foreign key constraints to allow testing without real auth users
-- Use this for development/testing only

-- Step 1: Temporarily disable foreign key constraint on user_details
ALTER TABLE user_details DROP CONSTRAINT IF EXISTS user_details_id_fkey;

-- Step 2: Insert sample apartments
INSERT INTO apartments (id, apt_name, no_of_books, no_of_readers, membership_cost, status, address, city) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Sunrise Apartments', 25, 15, 500.00, 'active', '123 Main Street, Andheri', 'Mumbai'),
    ('22222222-2222-2222-2222-222222222222', 'Garden View Complex', 18, 12, 400.00, 'active', '456 Garden Road, Bandra', 'Mumbai'),
    ('33333333-3333-3333-3333-333333333333', 'Skyline Towers', 40, 28, 600.00, 'active', '789 Sky Avenue, Powai', 'Mumbai');

-- Step 3: Insert sample user details (without auth.users constraint)
INSERT INTO user_details (id, username, email, phone_number, address, flat_no, apartment_id, status, profile_image_url) VALUES
    ('44444444-4444-4444-4444-444444444444', 'john_doe', 'john@example.com', '+91-9876543210', '123 Main Street', 'A101', '11111111-1111-1111-1111-111111111111', 'active', ''),
    ('55555555-5555-5555-5555-555555555555', 'jane_smith', 'jane@example.com', '+91-9876543211', '123 Main Street', 'A102', '11111111-1111-1111-1111-111111111111', 'active', ''),
    ('66666666-6666-6666-6666-666666666666', 'mike_wilson', 'mike@example.com', '+91-9876543212', '456 Garden Road', 'B201', '22222222-2222-2222-2222-222222222222', 'active', ''),
    ('77777777-7777-7777-7777-777777777777', 'sarah_jones', 'sarah@example.com', '+91-9876543213', '789 Sky Avenue', 'C301', '33333333-3333-3333-3333-333333333333', 'active', '');

-- Step 4: Update apartments with managers
UPDATE apartments SET manager = '44444444-4444-4444-4444-444444444444' WHERE id = '11111111-1111-1111-1111-111111111111';
UPDATE apartments SET manager = '66666666-6666-6666-6666-666666666666' WHERE id = '22222222-2222-2222-2222-222222222222';
UPDATE apartments SET manager = '77777777-7777-7777-7777-777777777777' WHERE id = '33333333-3333-3333-3333-333333333333';

-- Step 5: Insert sample profiles
INSERT INTO profiles (user_id, books_read, favorite_genre, books_borrowed, books_lent, favorite_books, read_books) VALUES
    ('44444444-4444-4444-4444-444444444444', 15, 'Science Fiction', 3, 2, '{"The Martian", "Dune"}', '{"1984", "Brave New World", "Foundation"}'),
    ('55555555-5555-5555-5555-555555555555', 8, 'Romance', 2, 1, '{"Pride and Prejudice"}', '{"Jane Eyre", "Wuthering Heights"}'),
    ('66666666-6666-6666-6666-666666666666', 22, 'Mystery', 1, 4, '{"The Girl with the Dragon Tattoo"}', '{"Gone Girl", "The Da Vinci Code"}'),
    ('77777777-7777-7777-7777-777777777777', 12, 'Fantasy', 0, 3, '{"Harry Potter", "Lord of the Rings"}', '{"The Hobbit", "Game of Thrones"}');

-- Step 6: Insert sample books
INSERT INTO books (id, title, author, category, description, cover_url, isbn, publisher, max_lending_days, lender_id, apartment_id, is_available, rating, pages) VALUES
    ('aaaaaaaa-1111-1111-1111-111111111111', 'The Midnight Library', 'Matt Haig', 'Fiction', 'Between life and death there is a library, and within that library, the shelves go on forever.', 'https://example.com/midnight-library.jpg', '9780525559474', 'Viking', 14, '44444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', true, 4.4, 288),
    ('bbbbbbbb-2222-2222-2222-222222222222', 'Project Hail Mary', 'Andy Weir', 'Science Fiction', 'A lone astronaut must save the earth from disaster in this incredible new science-based thriller.', 'https://example.com/project-hail-mary.jpg', '9780593135204', 'Ballantine Books', 21, '55555555-5555-5555-5555-555555555555', '11111111-1111-1111-1111-111111111111', true, 4.7, 476),
    ('cccccccc-3333-3333-3333-333333333333', 'The Seven Husbands of Evelyn Hugo', 'Taylor Jenkins Reid', 'Historical Fiction', 'A reclusive Hollywood icon finally tells her story to a young journalist.', 'https://example.com/evelyn-hugo.jpg', '9781501161933', 'Atria Books', 14, '66666666-6666-6666-6666-666666666666', '22222222-2222-2222-2222-222222222222', false, 4.6, 400),
    ('dddddddd-4444-4444-4444-444444444444', 'Atomic Habits', 'James Clear', 'Self-Help', 'An easy and proven way to build good habits and break bad ones.', 'https://example.com/atomic-habits.jpg', '9780735211292', 'Avery', 30, '77777777-7777-7777-7777-777777777777', '33333333-3333-3333-3333-333333333333', true, 4.8, 320),
    ('eeeeeeee-5555-5555-5555-555555555555', 'The Silent Patient', 'Alex Michaelides', 'Thriller', 'A woman''s act of violence against her husband and her refusal to speak.', 'https://example.com/silent-patient.jpg', '9781250301697', 'Celadon Books', 14, '44444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', true, 4.5, 325);

-- Step 6b: Insert book listings (for tracking book condition and availability)
INSERT INTO book_listings (id, book_id, owner_id, is_available, condition, location, notes) VALUES
    ('ffffffff-1111-1111-1111-111111111111', 'aaaaaaaa-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444', true, 'Excellent', 'A101 Living Room', 'Brand new condition'),
    ('ffffffff-2222-2222-2222-222222222222', 'bbbbbbbb-2222-2222-2222-222222222222', '55555555-5555-5555-5555-555555555555', true, 'Good', 'A102 Study', 'Slight wear on cover'),
    ('ffffffff-3333-3333-3333-333333333333', 'cccccccc-3333-3333-3333-333333333333', '66666666-6666-6666-6666-666666666666', false, 'Good', 'B201 Bedroom', 'Currently being read'),
    ('ffffffff-4444-4444-4444-444444444444', 'dddddddd-4444-4444-4444-444444444444', '77777777-7777-7777-7777-777777777777', true, 'Excellent', 'C301 Bookshelf', 'Like new'),
    ('ffffffff-5555-5555-5555-555555555555', 'eeeeeeee-5555-5555-5555-555555555555', '44444444-4444-4444-4444-444444444444', true, 'Good', 'A101 Study', 'Well maintained');

-- Step 7: Insert apartment memberships
INSERT INTO apartment_memberships (user_id, apartment_id, amount_paid, payment_status, valid_until) VALUES
    ('44444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', 500.00, 'paid', '2024-12-31'),
    ('55555555-5555-5555-5555-555555555555', '11111111-1111-1111-1111-111111111111', 500.00, 'paid', '2024-12-31'),
    ('66666666-6666-6666-6666-666666666666', '22222222-2222-2222-2222-222222222222', 400.00, 'paid', '2024-12-31'),
    ('77777777-7777-7777-7777-777777777777', '33333333-3333-3333-3333-333333333333', 600.00, 'paid', '2024-12-31');

-- Step 8: Insert some sample book reviews
INSERT INTO book_reviews (user_id, book_id, rating, review_text) VALUES
    ('55555555-5555-5555-5555-555555555555', 'aaaaaaaa-1111-1111-1111-111111111111', 5, 'Absolutely loved this book! Really makes you think about life choices.'),
    ('66666666-6666-6666-6666-666666666666', 'bbbbbbbb-2222-2222-2222-222222222222', 4, 'Great sci-fi thriller with solid science behind it.'),
    ('77777777-7777-7777-7777-777777777777', 'dddddddd-4444-4444-4444-444444444444', 5, 'Life-changing book about building better habits. Highly recommended!');

-- Step 9: Insert some sample notifications
INSERT INTO notifications (user_id, type, title, message, is_read, related_id) VALUES
    ('55555555-5555-5555-5555-555555555555', 'info', 'Book Available', 'The book "The Midnight Library" is now available for borrowing.', false, 'aaaaaaaa-1111-1111-1111-111111111111'),
    ('44444444-4444-4444-4444-444444444444', 'book_request', 'Book Request', 'Jane Smith has requested to borrow "The Silent Patient".', false, 'eeeeeeee-5555-5555-5555-555555555555'),
    ('66666666-6666-6666-6666-666666666666', 'info', 'Welcome', 'Welcome to Garden View Complex book club!', true, null);

-- IMPORTANT NOTE:
-- In production, you should restore the foreign key constraint:
-- ALTER TABLE user_details ADD CONSTRAINT user_details_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;
-- But for development testing, we'll leave it disabled to avoid auth complications.

-- Display success message
SELECT 'Sample data inserted successfully! You can now test the Flutter app with this data.' as status;


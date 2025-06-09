-- Alternative Sample Data Script for Development
-- This script works without creating fake auth.users entries
-- Use this if you want to test without authentication

-- OPTION 1: Temporarily disable the foreign key constraint for testing
-- WARNING: Only use this for development/testing purposes!

-- Disable the foreign key constraint temporarily
ALTER TABLE user_details DROP CONSTRAINT user_details_id_fkey;

-- Insert sample apartments
INSERT INTO apartments (id, apt_name, no_of_books, no_of_readers, membership_cost, status, address, city) VALUES
    ('11111111-1111-1111-1111-111111111111', 'Sunrise Apartments', 25, 15, 500.00, 'active', '123 Main Street, Andheri', 'Mumbai'),
    ('22222222-2222-2222-2222-222222222222', 'Garden View Complex', 18, 12, 400.00, 'active', '456 Garden Road, Bandra', 'Mumbai'),
    ('33333333-3333-3333-3333-333333333333', 'Skyline Towers', 40, 28, 600.00, 'active', '789 Sky Avenue, Powai', 'Mumbai');

-- Insert sample user details (without auth constraint)
INSERT INTO user_details (id, username, email, phone_number, address, flat_no, apartment_id, status, profile_image_url) VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'john_doe', 'john@example.com', '+91-9876543210', '123 Main Street', 'A101', '11111111-1111-1111-1111-111111111111', 'active', ''),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'jane_smith', 'jane@example.com', '+91-9876543211', '123 Main Street', 'A102', '11111111-1111-1111-1111-111111111111', 'active', ''),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'mike_wilson', 'mike@example.com', '+91-9876543212', '456 Garden Road', 'B201', '22222222-2222-2222-2222-222222222222', 'active', ''),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'sarah_jones', 'sarah@example.com', '+91-9876543213', '789 Sky Avenue', 'C301', '33333333-3333-3333-3333-333333333333', 'active', '');

-- Update apartment manager references
UPDATE apartments SET manager = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa' WHERE id = '11111111-1111-1111-1111-111111111111';
UPDATE apartments SET manager = 'cccccccc-cccc-cccc-cccc-cccccccccccc' WHERE id = '22222222-2222-2222-2222-222222222222';
UPDATE apartments SET manager = 'dddddddd-dddd-dddd-dddd-dddddddddddd' WHERE id = '33333333-3333-3333-3333-333333333333';

-- Insert sample profiles
INSERT INTO profiles (user_id, books_read, favorite_genre, books_borrowed, books_lent, favorite_books, read_books) VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 15, 'Science Fiction', 5, 3, '{"Dune", "Foundation"}', '{"1984", "Brave New World", "Neuromancer"}'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 22, 'Mystery', 3, 8, '{"Agatha Christie", "Sherlock Holmes"}', '{"Murder on Orient Express", "Hound of Baskervilles"}'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 8, 'Biography', 2, 1, '{"Steve Jobs", "Einstein"}', '{"When Breath Becomes Air", "Educated"}'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 18, 'Fiction', 4, 6, '{"Pride and Prejudice", "To Kill a Mockingbird"}', '{"Jane Eyre", "Little Women"}');

-- Insert sample books
INSERT INTO books (id, title, author, description, category, rating, pages, isbn, publisher, lender_id, apartment_id) VALUES
    ('b0000001-0000-0000-0000-000000000001', 'The Midnight Library', 'Matt Haig', 'Between life and death there is a library, and within that library, the shelves go on forever.', 'Fiction', 4.4, 288, '9780525559474', 'Viking', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111'),
    ('b0000002-0000-0000-0000-000000000002', 'Project Hail Mary', 'Andy Weir', 'A lone astronast must save the earth by solving an impossible scientific mystery.', 'Science Fiction', 4.7, 476, '9780593135204', 'Ballantine Books', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111'),
    ('b0000003-0000-0000-0000-000000000003', 'Atomic Habits', 'James Clear', 'An easy & proven way to build good habits & break bad ones.', 'Self-Help', 4.8, 320, '9780735211292', 'Avery', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111'),
    ('b0000004-0000-0000-0000-000000000004', 'The Seven Husbands of Evelyn Hugo', 'Taylor Jenkins Reid', 'A reclusive Hollywood icon finally tells her story to a young journalist.', 'Fiction', 4.6, 400, '9781501161933', 'Atria Books', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111'),
    ('b0000005-0000-0000-0000-000000000005', 'Educated', 'Tara Westover', 'A memoir about a young girl who, kept out of school, leaves her survivalist family and goes on to earn a PhD from Cambridge University.', 'Biography', 4.9, 334, '9780399590504', 'Random House', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '22222222-2222-2222-2222-222222222222'),
    ('b0000006-0000-0000-0000-000000000006', 'The Thursday Murder Club', 'Richard Osman', 'Four unlikely friends meet weekly to investigate cold cases.', 'Mystery', 4.5, 368, '9780241425442', 'Viking', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '22222222-2222-2222-2222-222222222222'),
    ('b0000007-0000-0000-0000-000000000007', 'Dune', 'Frank Herbert', 'A science fiction epic set on the desert planet Arrakis.', 'Science Fiction', 4.6, 688, '9780441172719', 'Ace Books', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '33333333-3333-3333-3333-333333333333'),
    ('b0000008-0000-0000-0000-000000000008', 'Where the Crawdads Sing', 'Delia Owens', 'A coming-of-age story set in the marshes of North Carolina.', 'Fiction', 4.3, 384, '9780735219090', 'G.P. Putnam''s Sons', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '33333333-3333-3333-3333-333333333333');

-- Insert sample book listings
INSERT INTO book_listings (id, book_id, owner_id, is_available, condition, location, notes) VALUES
    ('l0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', true, 'Excellent', 'A101 Living Room', 'Brand new, never read'),
    ('l0000002-0000-0000-0000-000000000002', 'b0000002-0000-0000-0000-000000000002', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', true, 'Good', 'A101 Bookshelf', 'Slight wear on cover'),
    ('l0000003-0000-0000-0000-000000000003', 'b0000003-0000-0000-0000-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', true, 'Good', 'A102 Study', 'Highlighted in some sections'),
    ('l0000004-0000-0000-0000-000000000004', 'b0000004-0000-0000-0000-000000000004', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', false, 'Good', 'A102 Bedroom', 'Currently being read'),
    ('l0000005-0000-0000-0000-000000000005', 'b0000005-0000-0000-0000-000000000005', 'cccccccc-cccc-cccc-cccc-cccccccccccc', true, 'Excellent', 'B201 Library', 'Like new condition'),
    ('l0000006-0000-0000-0000-000000000006', 'b0000006-0000-0000-0000-000000000006', 'cccccccc-cccc-cccc-cccc-cccccccccccc', true, 'Good', 'B201 Living Room', 'Well maintained'),
    ('l0000007-0000-0000-0000-000000000007', 'b0000007-0000-0000-0000-000000000007', 'dddddddd-dddd-dddd-dddd-dddddddddddd', true, 'Fair', 'C301 Study', 'Shows some age, still readable'),
    ('l0000008-0000-0000-0000-000000000008', 'b0000008-0000-0000-0000-000000000008', 'dddddddd-dddd-dddd-dddd-dddddddddddd', true, 'Good', 'C301 Bookcase', 'Clean, good condition');

-- Insert sample borrow requests
INSERT INTO borrow_requests (id, book_id, borrower_id, lender_id, request_date, status, lending_period_days, notes) VALUES
    ('r0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NOW(), 'pending', 14, 'Really excited to read this!'),
    ('r0000002-0000-0000-0000-000000000002', 'b0000005-0000-0000-0000-000000000005', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'cccccccc-cccc-cccc-cccc-cccccccccccc', NOW() - INTERVAL '2 days', 'approved', 14, 'Looking forward to this memoir'),
    ('r0000003-0000-0000-0000-000000000003', 'b0000007-0000-0000-0000-000000000007', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'dddddddd-dddd-dddd-dddd-dddddddddddd', NOW() - INTERVAL '1 day', 'pending', 21, 'Need extra time for this epic');

-- Insert sample book reviews
INSERT INTO book_reviews (id, book_id, user_id, rating, review_text, helpful_votes) VALUES
    ('rv000001-0000-0000-0000-000000000001', 'b0000003-0000-0000-0000-000000000003', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 5, 'Absolutely life-changing book! The concepts are practical and easy to implement.', 3),
    ('rv000002-0000-0000-0000-000000000002', 'b0000005-0000-0000-0000-000000000005', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 5, 'Incredible memoir. Tara Westover''s journey is both heartbreaking and inspiring.', 5),
    ('rv000003-0000-0000-0000-000000000003', 'b0000006-0000-0000-0000-000000000006', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 4, 'Fun mystery with great character development. Perfect for cozy reading.', 2);

-- Insert sample waitlist entries
INSERT INTO waitlist (id, user_id, book_id, priority, status) VALUES
    ('w0000001-0000-0000-0000-000000000001', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'b0000001-0000-0000-0000-000000000001', 1, 'waiting'),
    ('w0000002-0000-0000-0000-000000000002', 'dddddddd-dddd-dddd-dddd-dddddddddddd', 'b0000003-0000-0000-0000-000000000003', 1, 'waiting');

-- Insert sample notifications
INSERT INTO notifications (id, user_id, title, message, type, is_read, related_id) VALUES
    ('n0000001-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Book Request Approved', 'Your request for "Educated" has been approved by Mike Wilson', 'book_approved', false, 'r0000002-0000-0000-0000-000000000002'),
    ('n0000002-0000-0000-0000-000000000002', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'New Book Request', 'John Doe wants to borrow your book "Educated"', 'book_request', false, 'r0000002-0000-0000-0000-000000000002'),
    ('n0000003-0000-0000-0000-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Welcome to Book Club!', 'Welcome to Sunrise Apartments Book Club. Start exploring books from your neighbors!', 'info', true, null);

-- Insert sample apartment memberships
INSERT INTO apartment_memberships (id, user_id, apartment_id, membership_date, amount_paid, payment_status, valid_until) VALUES
    ('m0000001-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', NOW() - INTERVAL '30 days', 500.00, 'paid', NOW() + INTERVAL '11 months'),
    ('m0000002-0000-0000-0000-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111', NOW() - INTERVAL '25 days', 500.00, 'paid', NOW() + INTERVAL '11 months'),
    ('m0000003-0000-0000-0000-000000000003', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '22222222-2222-2222-2222-222222222222', NOW() - INTERVAL '20 days', 400.00, 'paid', NOW() + INTERVAL '11 months'),
    ('m0000004-0000-0000-0000-000000000004', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '33333333-3333-3333-3333-333333333333', NOW() - INTERVAL '15 days', 600.00, 'paid', NOW() + INTERVAL '11 months');

-- Update book counts in apartments
UPDATE apartments SET no_of_books = (
    SELECT COUNT(*) 
    FROM books 
    WHERE apartment_id = apartments.id
);

-- Update reader counts in apartments  
UPDATE apartments SET no_of_readers = (
    SELECT COUNT(*) 
    FROM user_details 
    WHERE apartment_id = apartments.id
);

-- Re-enable the foreign key constraint after inserting test data
-- In production, you would remove this step and let users sign up properly through Supabase Auth
ALTER TABLE user_details 
ADD CONSTRAINT user_details_id_fkey 
FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;

-- Final verification queries (uncomment to run)
-- SELECT 'Apartments' as table_name, COUNT(*) as count FROM apartments
-- UNION ALL
-- SELECT 'User Details', COUNT(*) FROM user_details
-- UNION ALL
-- SELECT 'Profiles', COUNT(*) FROM profiles
-- UNION ALL
-- SELECT 'Books', COUNT(*) FROM books
-- UNION ALL
-- SELECT 'Book Listings', COUNT(*) FROM book_listings
-- UNION ALL
-- SELECT 'Borrow Requests', COUNT(*) FROM borrow_requests
-- UNION ALL
-- SELECT 'Book Reviews', COUNT(*) FROM book_reviews
-- UNION ALL
-- SELECT 'Waitlist', COUNT(*) FROM waitlist
-- UNION ALL
-- SELECT 'Notifications', COUNT(*) FROM notifications
-- UNION ALL
-- SELECT 'Memberships', COUNT(*) FROM apartment_memberships;

-- Apartment Book Club Database Schema
-- Run these commands in your Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    apartment_number TEXT NOT NULL,
    profile_image_url TEXT DEFAULT '',
    favorite_books TEXT[] DEFAULT '{}',
    read_books TEXT[] DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Books table
CREATE TABLE books (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    description TEXT DEFAULT '',
    cover_url TEXT DEFAULT '',
    category TEXT DEFAULT '',
    rating DECIMAL(2,1) DEFAULT 0.0,
    pages INTEGER DEFAULT 0,
    isbn TEXT DEFAULT '',
    published_date DATE DEFAULT NOW(),
    is_available BOOLEAN DEFAULT true,
    is_featured BOOLEAN DEFAULT false,
    is_new_arrival BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Book Listings table (who owns which books and their availability)
CREATE TABLE book_listings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    book_id UUID REFERENCES books(id) ON DELETE CASCADE,
    owner_id UUID REFERENCES users(id) ON DELETE CASCADE,
    is_available BOOLEAN DEFAULT true,
    condition TEXT DEFAULT 'Good',
    location TEXT,
    notes TEXT,
    listed_date TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Borrow Requests table
CREATE TABLE borrow_requests (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    book_id UUID REFERENCES books(id) ON DELETE CASCADE,
    borrower_id UUID REFERENCES users(id) ON DELETE CASCADE,
    lender_id UUID REFERENCES users(id) ON DELETE CASCADE,
    request_date TIMESTAMPTZ DEFAULT NOW(),
    approved_date TIMESTAMPTZ,
    return_date TIMESTAMPTZ,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'returned', 'declined')),
    lending_period_days INTEGER DEFAULT 7,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Reviews table (optional - for book reviews)
CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    book_id UUID REFERENCES books(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Notifications table (optional - for app notifications)
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    type TEXT DEFAULT 'info',
    is_read BOOLEAN DEFAULT false,
    related_id UUID, -- Can reference borrow_requests, books, etc.
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_book_listings_owner_id ON book_listings(owner_id);
CREATE INDEX idx_book_listings_book_id ON book_listings(book_id);
CREATE INDEX idx_book_listings_available ON book_listings(is_available);
CREATE INDEX idx_borrow_requests_borrower ON borrow_requests(borrower_id);
CREATE INDEX idx_borrow_requests_lender ON borrow_requests(lender_id);
CREATE INDEX idx_borrow_requests_status ON borrow_requests(status);
CREATE INDEX idx_books_category ON books(category);
CREATE INDEX idx_books_featured ON books(is_featured);
CREATE INDEX idx_notifications_user_read ON notifications(user_id, is_read);

-- Create updated_at triggers
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_books_updated_at BEFORE UPDATE ON books FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_book_listings_updated_at BEFORE UPDATE ON book_listings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_borrow_requests_updated_at BEFORE UPDATE ON borrow_requests FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Row Level Security (RLS) Policies
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE books ENABLE ROW LEVEL SECURITY;
ALTER TABLE book_listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE borrow_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Users can only read their own profile and update it
CREATE POLICY "Users can view own profile" ON users FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON users FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON users FOR INSERT WITH CHECK (auth.uid() = id);

-- Everyone can read books
CREATE POLICY "Anyone can view books" ON books FOR SELECT USING (true);
CREATE POLICY "Authenticated users can insert books" ON books FOR INSERT WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "Users can update their own books" ON books FOR UPDATE USING (true); -- You might want to restrict this

-- Book listings policies
CREATE POLICY "Anyone can view available listings" ON book_listings FOR SELECT USING (true);
CREATE POLICY "Users can create their own listings" ON book_listings FOR INSERT WITH CHECK (auth.uid() = owner_id);
CREATE POLICY "Users can update their own listings" ON book_listings FOR UPDATE USING (auth.uid() = owner_id);

-- Borrow requests policies
CREATE POLICY "Users can view requests they're involved in" ON borrow_requests 
    FOR SELECT USING (auth.uid() = borrower_id OR auth.uid() = lender_id);
CREATE POLICY "Users can create borrow requests" ON borrow_requests 
    FOR INSERT WITH CHECK (auth.uid() = borrower_id);
CREATE POLICY "Lenders can update requests for their books" ON borrow_requests 
    FOR UPDATE USING (auth.uid() = lender_id OR auth.uid() = borrower_id);

-- Reviews policies
CREATE POLICY "Anyone can view reviews" ON reviews FOR SELECT USING (true);
CREATE POLICY "Users can create their own reviews" ON reviews FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own reviews" ON reviews FOR UPDATE USING (auth.uid() = user_id);

-- Notifications policies
CREATE POLICY "Users can view their own notifications" ON notifications FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "System can insert notifications" ON notifications FOR INSERT WITH CHECK (true);
CREATE POLICY "Users can update their own notifications" ON notifications FOR UPDATE USING (auth.uid() = user_id);

-- Insert some sample data
INSERT INTO books (id, title, author, description, category, rating, pages, isbn) VALUES
    (uuid_generate_v4(), 'Geografi Kelas XI', 'Erlangga', 'Comprehensive geography textbook for Class XI students', 'Educational', 4.5, 324, '978-602-298-123-1'),
    (uuid_generate_v4(), 'Fisika Kelas XI', 'Erlangga', 'Physics textbook covering fundamental concepts for Class XI', 'Educational', 4.3, 285, '978-602-298-123-2'),
    (uuid_generate_v4(), 'Kimia Kelas 11', 'Erlangga', 'Chemistry textbook with practical examples and exercises', 'Educational', 4.4, 298, '978-602-298-123-3'),
    (uuid_generate_v4(), 'Biologi Kelas XI', 'Erlangga', 'Biology textbook exploring life sciences for Class XI', 'Educational', 4.6, 312, '978-602-298-123-4'),
    (uuid_generate_v4(), 'Matematika XI', 'Erlangga', 'Mathematics textbook with comprehensive problem solving', 'Educational', 4.2, 356, '978-602-298-123-5'),
    (uuid_generate_v4(), 'Bahasa Indonesia XI', 'Erlangga', 'Indonesian language and literature for Class XI', 'Educational', 4.1, 267, '978-602-298-123-6'),
    (uuid_generate_v4(), 'The Midnight Library', 'Matt Haig', 'Between life and death there is a library, and within that library, the shelves go on forever.', 'Fiction', 4.4, 288, '9780525559474'),
    (uuid_generate_v4(), 'Project Hail Mary', 'Andy Weir', 'A lone astronaut must save the earth by solving an impossible scientific mystery.', 'Science Fiction', 4.7, 476, '9780593135204'),
    (uuid_generate_v4(), 'Atomic Habits', 'James Clear', 'An easy & proven way to build good habits & break bad ones.', 'Self-Help', 4.8, 320, '9780735211292'),
    (uuid_generate_v4(), 'The Seven Husbands of Evelyn Hugo', 'Taylor Jenkins Reid', 'A reclusive Hollywood icon finally tells her story to a young journalist.', 'Fiction', 4.6, 400, '9781501161933'),
    (uuid_generate_v4(), 'Educated', 'Tara Westover', 'A memoir about a young girl who, kept out of school, leaves her survivalist family and goes on to earn a PhD from Cambridge University.', 'Biography', 4.9, 334, '9780399590504'),
    (uuid_generate_v4(), 'The Thursday Murder Club', 'Richard Osman', 'Four unlikely friends meet weekly to investigate cold cases.', 'Mystery', 4.5, 368, '9780241425442'),
    (uuid_generate_v4(), 'Dune', 'Frank Herbert', 'A science fiction epic set on the desert planet Arrakis.', 'Science Fiction', 4.6, 688, '9780441172719'),
    (uuid_generate_v4(), 'Where the Crawdads Sing', 'Delia Owens', 'A coming-of-age story set in the marshes of North Carolina.', 'Fiction', 4.3, 384, '9780735219090'),
    (uuid_generate_v4(), 'The Silent Patient', 'Alex Michaelides', 'A psychotherapist is determined to treat a woman who refuses to speak.', 'Thriller', 4.1, 336, '9781250301697'),
    (uuid_generate_v4(), 'Sapiens', 'Yuval Noah Harari', 'A brief history of humankind from the Stone Age to the present.', 'History', 4.4, 443, '9780062316097');

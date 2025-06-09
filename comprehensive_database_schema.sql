-- Comprehensive Apartment Book Club Database Schema
-- This combines your existing schema with the book club requirements
-- Run this AFTER running reset_database.sql

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 1. Create apartments table WITHOUT manager foreign key constraint
CREATE TABLE apartments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  apt_name TEXT NOT NULL,
  no_of_books INT DEFAULT 0,
  manager UUID,  -- no FK constraint here yet
  no_of_readers INT DEFAULT 0,
  membership_cost NUMERIC(10,2),
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'pending')),
  address TEXT,
  city TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Create user_details table WITH FK to apartments
CREATE TABLE user_details (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  phone_number TEXT,
  address TEXT,
  flat_no TEXT,
  apartment_id UUID REFERENCES apartments(id),
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'banned', 'pending')),
  profile_image_url TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Create profiles table
CREATE TABLE profiles (
  user_id UUID PRIMARY KEY REFERENCES user_details(id) ON DELETE CASCADE,
  books_read INT DEFAULT 0,
  favorite_genre TEXT,
  books_borrowed INT DEFAULT 0,
  books_lent INT DEFAULT 0,
  favorite_books TEXT[] DEFAULT '{}',
  read_books TEXT[] DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Create books table (enhanced for book club)
CREATE TABLE books (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,  -- renamed from book_name for consistency
  author TEXT NOT NULL,
  description TEXT DEFAULT '',
  cover_url TEXT DEFAULT '',
  category TEXT DEFAULT '',
  rating DECIMAL(2,1) DEFAULT 0.0,
  pages INTEGER DEFAULT 0,
  isbn TEXT UNIQUE,
  published_date DATE DEFAULT NOW(),
  publisher TEXT,
  max_lending_days INT DEFAULT 14,
  is_available BOOLEAN DEFAULT true,
  is_featured BOOLEAN DEFAULT false,
  is_new_arrival BOOLEAN DEFAULT false,
  lender_id UUID REFERENCES user_details(id),  -- renamed from lender
  apartment_id UUID REFERENCES apartments(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. Create book_listings table (for tracking who owns what books)
CREATE TABLE book_listings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  book_id UUID REFERENCES books(id) ON DELETE CASCADE,
  owner_id UUID REFERENCES user_details(id) ON DELETE CASCADE,
  is_available BOOLEAN DEFAULT true,
  condition TEXT DEFAULT 'Good',
  location TEXT,
  notes TEXT,
  listed_date TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. Create borrow_requests table (enhanced from borrowed_books)
CREATE TABLE borrow_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  book_id UUID REFERENCES books(id) ON DELETE CASCADE,
  borrower_id UUID REFERENCES user_details(id) ON DELETE CASCADE,
  lender_id UUID REFERENCES user_details(id) ON DELETE CASCADE,
  request_date TIMESTAMPTZ DEFAULT NOW(),
  approved_date TIMESTAMPTZ,
  borrowed_date TIMESTAMPTZ,
  due_date DATE,
  return_date TIMESTAMPTZ,
  returned BOOLEAN DEFAULT false,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'returned', 'declined', 'overdue')),
  lending_period_days INTEGER DEFAULT 14,
  renewals INT DEFAULT 0,
  max_renewals INT DEFAULT 2,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. Create book_reviews table (enhanced)
CREATE TABLE book_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  book_id UUID REFERENCES books(id) ON DELETE CASCADE,
  user_id UUID REFERENCES user_details(id) ON DELETE CASCADE,
  rating INTEGER CHECK (rating >= 1 AND rating <= 5),
  review_text TEXT,
  helpful_votes INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(book_id, user_id)  -- One review per user per book
);

-- 8. Create waitlist table
CREATE TABLE waitlist (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES user_details(id) ON DELETE CASCADE,
  book_id UUID REFERENCES books(id) ON DELETE CASCADE,
  priority INT,
  status TEXT DEFAULT 'waiting' CHECK (status IN ('waiting', 'notified', 'fulfilled', 'cancelled')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(book_id, user_id),
  UNIQUE(book_id, priority)
);

-- 9. Create notifications table
CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES user_details(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  type TEXT DEFAULT 'info' CHECK (type IN ('info', 'success', 'warning', 'error', 'book_request', 'book_approved', 'book_due', 'book_returned')),
  is_read BOOLEAN DEFAULT false,
  related_id UUID, -- Can reference borrow_requests, books, etc.
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 10. Create apartment_memberships table (for tracking membership payments)
CREATE TABLE apartment_memberships (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES user_details(id) ON DELETE CASCADE,
  apartment_id UUID REFERENCES apartments(id) ON DELETE CASCADE,
  membership_date TIMESTAMPTZ DEFAULT NOW(),
  amount_paid NUMERIC(10,2),
  payment_status TEXT DEFAULT 'pending' CHECK (payment_status IN ('pending', 'paid', 'overdue')),
  valid_until DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Now add the manager FK constraint in apartments
ALTER TABLE apartments
  ADD CONSTRAINT fk_manager
  FOREIGN KEY (manager) REFERENCES user_details(id);

-- Create indexes for better performance
CREATE INDEX idx_apartments_manager ON apartments(manager);
CREATE INDEX idx_user_details_apartment ON user_details(apartment_id);
CREATE INDEX idx_books_lender ON books(lender_id);
CREATE INDEX idx_books_apartment ON books(apartment_id);
CREATE INDEX idx_books_category ON books(category);
CREATE INDEX idx_books_featured ON books(is_featured);
CREATE INDEX idx_books_available ON books(is_available);
CREATE INDEX idx_book_listings_owner ON book_listings(owner_id);
CREATE INDEX idx_book_listings_book ON book_listings(book_id);
CREATE INDEX idx_book_listings_available ON book_listings(is_available);
CREATE INDEX idx_borrow_requests_borrower ON borrow_requests(borrower_id);
CREATE INDEX idx_borrow_requests_lender ON borrow_requests(lender_id);
CREATE INDEX idx_borrow_requests_status ON borrow_requests(status);
CREATE INDEX idx_waitlist_book ON waitlist(book_id);
CREATE INDEX idx_waitlist_user ON waitlist(user_id);
CREATE INDEX idx_notifications_user_read ON notifications(user_id, is_read);

-- Create updated_at triggers
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_apartments_updated_at BEFORE UPDATE ON apartments FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_user_details_updated_at BEFORE UPDATE ON user_details FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_books_updated_at BEFORE UPDATE ON books FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_book_listings_updated_at BEFORE UPDATE ON book_listings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_borrow_requests_updated_at BEFORE UPDATE ON borrow_requests FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_waitlist_updated_at BEFORE UPDATE ON waitlist FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Row Level Security (RLS) Policies
ALTER TABLE apartments ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_details ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE books ENABLE ROW LEVEL SECURITY;
ALTER TABLE book_listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE borrow_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE book_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE apartment_memberships ENABLE ROW LEVEL SECURITY;

-- Apartments policies
CREATE POLICY "Anyone can view apartments" ON apartments FOR SELECT USING (true);
CREATE POLICY "Managers can update their apartments" ON apartments FOR UPDATE USING (auth.uid() = manager);

-- User details policies
CREATE POLICY "Users can view own profile" ON user_details FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON user_details FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON user_details FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can view apartment members" ON user_details FOR SELECT USING (
  apartment_id IN (SELECT apartment_id FROM user_details WHERE id = auth.uid())
);

-- Profiles policies
CREATE POLICY "Users can view own profile data" ON profiles FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can update own profile data" ON profiles FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own profile data" ON profiles FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Books policies
CREATE POLICY "Users can view books in their apartment" ON books FOR SELECT USING (
  apartment_id IN (SELECT apartment_id FROM user_details WHERE id = auth.uid())
);
CREATE POLICY "Users can add books to their apartment" ON books FOR INSERT WITH CHECK (
  apartment_id IN (SELECT apartment_id FROM user_details WHERE id = auth.uid()) AND
  lender_id = auth.uid()
);
CREATE POLICY "Users can update their own books" ON books FOR UPDATE USING (lender_id = auth.uid());

-- Book listings policies
CREATE POLICY "Users can view listings in their apartment" ON book_listings FOR SELECT USING (
  EXISTS (
    SELECT 1 FROM books b 
    JOIN user_details ud ON b.apartment_id = ud.apartment_id 
    WHERE b.id = book_id AND ud.id = auth.uid()
  )
);
CREATE POLICY "Users can create their own listings" ON book_listings FOR INSERT WITH CHECK (auth.uid() = owner_id);
CREATE POLICY "Users can update their own listings" ON book_listings FOR UPDATE USING (auth.uid() = owner_id);

-- Borrow requests policies
CREATE POLICY "Users can view requests they're involved in" ON borrow_requests 
    FOR SELECT USING (auth.uid() = borrower_id OR auth.uid() = lender_id);
CREATE POLICY "Users can create borrow requests" ON borrow_requests 
    FOR INSERT WITH CHECK (auth.uid() = borrower_id);
CREATE POLICY "Users can update requests they're involved in" ON borrow_requests 
    FOR UPDATE USING (auth.uid() = lender_id OR auth.uid() = borrower_id);

-- Book reviews policies
CREATE POLICY "Anyone can view reviews" ON book_reviews FOR SELECT USING (true);
CREATE POLICY "Users can create their own reviews" ON book_reviews FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own reviews" ON book_reviews FOR UPDATE USING (auth.uid() = user_id);

-- Waitlist policies
CREATE POLICY "Users can view their own waitlist entries" ON waitlist FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can add themselves to waitlist" ON waitlist FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own waitlist entries" ON waitlist FOR UPDATE USING (auth.uid() = user_id);

-- Notifications policies
CREATE POLICY "Users can view their own notifications" ON notifications FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "System can insert notifications" ON notifications FOR INSERT WITH CHECK (true);
CREATE POLICY "Users can update their own notifications" ON notifications FOR UPDATE USING (auth.uid() = user_id);

-- Membership policies
CREATE POLICY "Users can view their own memberships" ON apartment_memberships FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can create their own memberships" ON apartment_memberships FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Schema created successfully! Use separate sample data files for testing.

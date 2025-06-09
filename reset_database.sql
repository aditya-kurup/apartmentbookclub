-- Reset Supabase Database for Apartment Book Club
-- Run this FIRST to clean up existing tables

-- Drop all existing tables (run this carefully!)
DROP TABLE IF EXISTS apartment_memberships CASCADE;
DROP TABLE IF EXISTS book_reviews CASCADE;
DROP TABLE IF EXISTS waitlist CASCADE;
DROP TABLE IF EXISTS borrowed_books CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS profiles CASCADE;
DROP TABLE IF EXISTS user_details CASCADE;
DROP TABLE IF EXISTS apartments CASCADE;

-- Drop apartment book club tables if they exist
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS notifications CASCADE;
DROP TABLE IF EXISTS borrow_requests CASCADE;
DROP TABLE IF EXISTS book_listings CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Also drop any existing functions
DROP FUNCTION IF EXISTS update_updated_at_column() CASCADE;

-- Note: Policies are automatically dropped when tables are dropped with CASCADE
-- No need to explicitly drop policies

-- Drop extensions if needed to recreate
-- Note: Be careful with this in production
-- DROP EXTENSION IF EXISTS "uuid-ossp";
-- DROP EXTENSION IF EXISTS "pgcrypto";

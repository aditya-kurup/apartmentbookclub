# Database Setup Guide

This guide will help you set up your Supabase database with the comprehensive apartment book club schema.

## Steps to Setup Database

### 1. Reset Your Database (CAUTION: This will delete all existing data)
Run the following script in your Supabase SQL Editor:
```sql
-- Copy and paste the contents of reset_database.sql
```

### 2. Create the Comprehensive Schema
Run the following script in your Supabase SQL Editor:
```sql
-- Copy and paste the contents of comprehensive_database_schema.sql
```

### 3. Insert Sample Data (Optional for Testing)

**IMPORTANT**: Choose one of these options:

#### Option A: Simple Testing Data (Recommended for Development)
Run this script for easy testing without authentication complications:
```sql
-- Copy and paste the contents of insert_sample_data_simple.sql
```

#### Option B: Full Production Data (Advanced)
Only use this if you understand Supabase Auth system:
```sql
-- Copy and paste the contents of insert_sample_data.sql
```

**Note**: Option A temporarily disables foreign key constraints to allow testing without real authenticated users. Option B requires understanding of Supabase Auth and may cause errors if not set up properly.

## Quick Setup Summary

### For Development/Testing (Recommended)
1. Run `reset_database.sql` in Supabase SQL Editor
2. Run `comprehensive_database_schema.sql` in Supabase SQL Editor  
3. Run `insert_sample_data_simple.sql` in Supabase SQL Editor
4. Test your Flutter app with the sample data

**IMPORTANT**: The `comprehensive_database_schema.sql` file only creates the schema structure and does NOT include sample data. Use the dedicated sample data files instead.

### For Production
1. Run `reset_database.sql` in Supabase SQL Editor
2. Run `comprehensive_database_schema.sql` in Supabase SQL Editor
3. Set up proper Supabase Auth signup/login in your Flutter app
4. Let users create accounts through the app (this will populate auth.users)
5. Optionally run `insert_sample_data.sql` for testing with real auth users

## Troubleshooting

### Foreign Key Constraint Error
If you get an error like "violates foreign key constraint", you're trying to use sample data that references auth.users entries that don't exist. Use `insert_sample_data_simple.sql` instead, which temporarily removes this constraint for development testing.

### Column Name Error
If you get an error like "column 'genre' does not exist", this means there's a mismatch between the sample data and the actual database schema. The database uses `category` field instead of `genre`. Use the updated sample data files.

### Missing Columns Error
If you get errors about missing columns like `condition`, this is because some fields belong to different tables (e.g., `condition` is in `book_listings` table, not `books` table). The updated sample data correctly separates these fields.

### Duplicate Key/ISBN Error
If you get an error like "duplicate key value violates unique constraint 'books_isbn_key'", this means you're trying to insert the same book twice. This can happen if:
1. You ran the old `comprehensive_database_schema.sql` that included sample data, then tried to run a sample data script
2. You ran the same sample data script twice

**Solution**: Run `reset_database.sql` first, then `comprehensive_database_schema.sql` (which now only contains schema), then your chosen sample data script.

### Models (`lib/models/book.dart`)
- ✅ **Book Model**: Updated with new fields (publisher, maxLendingDays, lenderId, apartmentId, etc.)
- ✅ **UserDetails Model**: New model replacing User to match user_details table
- ✅ **Profile Model**: New model for user profile data
- ✅ **Apartment Model**: New model for apartment management
- ✅ **BorrowRequest Model**: Enhanced with new fields (borrowedDate, dueDate, returned, renewals, etc.)
- ✅ **BookListing Model**: Updated model structure
- ✅ **BookReview Model**: New model for book reviews
- ✅ **Waitlist Model**: New model for book waitlists
- ✅ **Notification Model**: New model for user notifications
- ✅ **ApartmentMembership Model**: New model for membership tracking

### Database Service (`lib/services/database_service.dart`)
- ✅ **Table Names**: Updated to use new table names (user_details vs users)
- ✅ **Field Mappings**: Updated to match new schema field names
- ✅ **Join Queries**: Fixed joins to use correct foreign key relationships
- ✅ **New Methods**: Added methods for all new models

## Database Schema Features

### Core Tables
- **apartments**: Apartment complex management
- **user_details**: User information linked to Supabase Auth
- **profiles**: Extended user profile data
- **books**: Book information with apartment and lender tracking
- **book_listings**: Book availability and condition tracking
- **borrow_requests**: Enhanced borrowing workflow
- **book_reviews**: User reviews and ratings
- **waitlist**: Book waiting lists with priority
- **notifications**: User notification system
- **apartment_memberships**: Membership fee tracking

### Key Features
- **Row Level Security (RLS)**: Proper security policies for all tables
- **Apartment-based Isolation**: Users only see books from their apartment
- **Real-time Updates**: Triggers for updated_at timestamps
- **Proper Indexing**: Optimized queries with strategic indexes
- **Data Integrity**: Foreign key constraints and check constraints

## Next Steps

1. **Run the Database Scripts**: Execute the three SQL files in order
2. **Test the App**: Your app should now work with real Supabase data
3. **Authentication Integration**: Connect Supabase Auth with user_details table
4. **Real-time Features**: Implement real-time updates for borrow requests
5. **Search Enhancement**: Test the improved search functionality
6. **Error Handling**: Add comprehensive error handling throughout the app

## Sample Data Included

The sample data includes:
- 3 apartment complexes in Mumbai
- 4 sample users across different apartments
- 8 books with various categories
- Book listings with different conditions
- Sample borrow requests in different states
- Book reviews and ratings
- Waitlist entries
- Notifications for different scenarios
- Paid memberships for all users

## Testing Search Functionality

With the sample data, you can test:
- Search for "Midnight" (should find "The Midnight Library")
- Search for "Andy Weir" (should find "Project Hail Mary")
- Search for "Fiction" (should find multiple fiction books)
- Browse by categories: Fiction, Science Fiction, Biography, etc.

## Important Notes

- The sample user IDs are placeholder UUIDs. In production, these should come from Supabase Auth
- Make sure your Supabase project has the necessary extensions enabled
- Test the RLS policies to ensure proper data isolation
- Consider implementing apartment invitation/joining workflow

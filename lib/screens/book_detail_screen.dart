import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/database_service.dart';
import '../models/book.dart';

class BookDetailScreen extends StatefulWidget {
  final String title;
  final String author;

  const BookDetailScreen({
    super.key,
    required this.title,
    required this.author,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  String selectedLendingPeriod = '7 days';
  final List<String> lendingPeriods = ['7 days', '14 days', '21 days', '30 days'];
  
  // State variables for real data
  Map<String, dynamic>? _bookData;
  bool _isLoading = true;
  String? _errorMessage;
  
  @override
  void initState() {
    super.initState();
    _loadBookData();
  }
  
  Future<void> _loadBookData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      
      final bookData = await DatabaseService.getBookByTitleAndAuthor(
        widget.title, 
        widget.author
      );
      
      setState(() {
        _bookData = bookData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }
  
  String _getFormattedPublishYear() {
    if (_bookData?['published_date'] != null) {
      try {
        return DateTime.parse(_bookData!['published_date']).year.toString();
      } catch (e) {
        return 'Unknown';
      }
    }
    return 'Unknown';
  }
  
  String _getAvailabilityStatus() {
    if (_bookData?['is_available'] == true) {
      return 'Available';
    } else {
      return 'Not Available';
    }
  }
  
  String _getOwnerName() {
    return _bookData?['user_details']?['username'] ?? 'Unknown Owner';
  }
    String _getOwnerLocation() {
    final flatNo = _bookData?['user_details']?['flat_no'];
    return flatNo != null ? 'Apartment $flatNo' : 'Unknown Location';
  }
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[300],
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load book details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.red[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loadBookData,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_bookData == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(
          child: Text(
            'Book not found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://picsum.photos/200/280?random=${widget.title.hashCode}",
                      width: 140,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 140,
                          height: 180,
                          color: const Color(0xFFF3F4F6),
                          child: const Center(
                            child: Icon(
                              Icons.book,
                              size: 48,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book title and author
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'by ${widget.author}',
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                    // Rating and availability
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFFFBBF24), size: 20),
                          const SizedBox(width: 4),
                          Text(
                            (_bookData?['rating']?.toString() ?? '0.0'),
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _bookData?['is_available'] == true 
                              ? const Color(0xFFDCFCE7) 
                              : const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getAvailabilityStatus(),
                          style: TextStyle(
                            color: _bookData?['is_available'] == true 
                                ? const Color(0xFF059669) 
                                : const Color(0xFFDC2626),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                    // Book description
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _bookData?['description'] ?? 'No description available.',
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Book details
                  const Text(
                    'Book Details',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow('Genre', _bookData?['category'] ?? 'Unknown'),
                  _buildDetailRow('Pages', _bookData?['pages']?.toString() ?? 'Unknown'),
                  _buildDetailRow('Language', 'English'), // Default for now
                  _buildDetailRow('ISBN', _bookData?['isbn'] ?? 'Not available'),
                  _buildDetailRow('Publisher', _bookData?['publisher'] ?? 'Unknown'),
                  _buildDetailRow('Year', _getFormattedPublishYear()),
                  _buildDetailRow('Condition', 'Good'), // Default for now
                  const SizedBox(height: 24),
                    // Owner information
                  const Text(
                    'Book Owner',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: const Color(0xFF3B82F6),
                          child: Text(
                            _getOwnerName()[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getOwnerName(),
                                style: const TextStyle(
                                  color: Color(0xFF111827),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _getOwnerLocation(),
                                style: const TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.message, color: Color(0xFF3B82F6)),
                          onPressed: () {
                            _showContactDialog();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Lending period selection
                  const Text(
                    'Select Lending Period',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      children: [
                        ...lendingPeriods.map((period) => RadioListTile<String>(
                          title: Text(
                            period,
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: period,
                          groupValue: selectedLendingPeriod,
                          onChanged: (value) {
                            setState(() {
                              selectedLendingPeriod = value!;
                            });
                          },
                          activeColor: const Color(0xFF3B82F6),
                          contentPadding: EdgeInsets.zero,
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Lending terms
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFBBF24)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.info_outline, color: Color(0xFF92400E), size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Lending Terms',
                              style: TextStyle(
                                color: Color(0xFF92400E),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '• Return the book in the same condition\n• Late returns may incur penalties\n• Contact owner for extensions\n• Handle with care',
                          style: TextStyle(
                            color: Color(0xFF92400E),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 48,            child: ElevatedButton(
              onPressed: _bookData?['is_available'] == true ? _requestBorrow : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                disabledBackgroundColor: const Color(0xFFE5E7EB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                _bookData?['is_available'] == true 
                    ? 'Request to Borrow ($selectedLendingPeriod)'
                    : 'Not Available',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _requestBorrow() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Sending request...'),
              ],
            ),
          );
        },
      );      // Create borrow request in database
      final borrowRequest = BorrowRequest(
        id: '', // Will be generated by database
        bookId: _bookData?['id'] ?? '', // Use actual book ID from database
        borrowerId: 'current-user-id', // TODO: Get from auth service
        lenderId: _bookData?['lender_id'] ?? '', // Get from book owner
        requestDate: DateTime.now(),
        status: 'pending',
        lendingPeriodDays: int.parse(selectedLendingPeriod.split(' ')[0]),
        notes: 'Request for ${widget.title}',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await DatabaseService.createBorrowRequest(borrowRequest);
      
      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        _showErrorDialog(e.toString());
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCFCE7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Color(0xFF059669),
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Request Sent!',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),              Text(
                'Your borrow request for "${widget.title}" has been sent to ${_getOwnerName()}. You will be notified once they respond.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.pop(); // Go back to previous screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEE2E2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline,
                  color: Color(0xFFDC2626),
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Request Failed',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sorry, we couldn\'t send your borrow request. Please try again.\n\nError: $error',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),          title: Text(
            'Contact ${_getOwnerName()}',
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            'Would you like to send a message to the book owner?',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // In a real app, this would open a messaging interface
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Messaging feature coming soon!'),
                    backgroundColor: Color(0xFF3B82F6),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Send Message',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),      ],
        );
      },
    );
  }
}
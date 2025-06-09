import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BorrowedBookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  const BorrowedBookDetailScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final daysLeft = book['daysLeft'] as int;
    final isOverdue = daysLeft < 0;
    final urgency = _getUrgencyLevel(daysLeft);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF6B7280),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Borrowed Book',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.24,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book Cover and Basic Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book Cover
                        Container(
                          width: 120,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF111827).withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              book['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFF3F4F6),
                                  child: const Icon(
                                    Icons.book,
                                    size: 48,
                                    color: Color(0xFF9CA3AF),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Book Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book['title'],
                                style: const TextStyle(
                                  color: Color(0xFF111827),
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'by ${book['author']}',
                                style: const TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getGenreColor(book['genre']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  book['genre'],
                                  style: TextStyle(
                                    color: _getGenreColor(book['genre']),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Return Status
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: urgency.color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: urgency.color.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      urgency.icon,
                                      size: 16,
                                      color: urgency.color,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      urgency.text,
                                      style: TextStyle(
                                        color: urgency.color,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Lending Details Card
                    _buildInfoCard(
                      title: 'Lending Details',
                      children: [
                        _buildInfoRow('Borrowed from', book['borrowedFrom']),
                        _buildInfoRow('Borrow date', book['borrowDate']),
                        _buildInfoRow('Return date', book['returnDate']),
                        _buildInfoRow(
                          'Days remaining',
                          isOverdue 
                            ? '${daysLeft.abs()} days overdue'
                            : '$daysLeft days left',
                          isImportant: daysLeft <= 7,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Actions Card
                    _buildInfoCard(
                      title: 'Actions',
                      children: [
                        _buildActionButton(
                          icon: Icons.message_rounded,
                          label: 'Message ${book['borrowedFrom'].split(' ').first}',
                          onTap: () => _showContactDialog(context),
                          color: const Color(0xFF6366F1),
                        ),
                        const SizedBox(height: 12),
                        _buildActionButton(
                          icon: isOverdue ? Icons.warning_rounded : Icons.schedule_rounded,
                          label: isOverdue ? 'Request Extension' : 'Request Extension',
                          onTap: () => _showExtensionDialog(context),
                          color: isOverdue ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                        ),
                        const SizedBox(height: 12),
                        _buildActionButton(
                          icon: Icons.check_circle_rounded,
                          label: 'Mark as Returned',
                          onTap: () => _showReturnDialog(context),
                          color: const Color(0xFF059669),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isImportant = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
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
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isImportant ? const Color(0xFFEF4444) : const Color(0xFF111827),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: isImportant ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  UrgencyLevel _getUrgencyLevel(int daysLeft) {
    if (daysLeft < 0) {
      return UrgencyLevel(
        text: '${daysLeft.abs()} days overdue',
        color: const Color(0xFFEF4444),
        icon: Icons.warning_rounded,
      );
    } else if (daysLeft == 0) {
      return UrgencyLevel(
        text: 'Due today',
        color: const Color(0xFFF59E0B),
        icon: Icons.schedule_rounded,
      );
    } else if (daysLeft <= 3) {
      return UrgencyLevel(
        text: '$daysLeft days left',
        color: const Color(0xFFF59E0B),
        icon: Icons.schedule_rounded,
      );
    } else if (daysLeft <= 7) {
      return UrgencyLevel(
        text: '$daysLeft days left',
        color: const Color(0xFF10B981),
        icon: Icons.schedule_rounded,
      );
    } else {
      return UrgencyLevel(
        text: '$daysLeft days left',
        color: const Color(0xFF6B7280),
        icon: Icons.schedule_rounded,
      );
    }
  }

  Color _getGenreColor(String genre) {
    switch (genre.toLowerCase()) {
      case 'fiction':
        return const Color(0xFFEF4444);
      case 'science fiction':
        return const Color(0xFF8B5CF6);
      case 'romance':
        return const Color(0xFFEC4899);
      case 'mystery':
        return const Color(0xFF6366F1);
      case 'non-fiction':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF6B7280);
    }
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Contact ${book['borrowedFrom']}',
          style: const TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        content: const Text(
          'This feature will allow you to send a message to the book owner.',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontFamily: 'Inter',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Send Message',
              style: TextStyle(fontFamily: 'Inter'),
            ),
          ),
        ],
      ),
    );
  }

  void _showExtensionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Request Extension',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Request an extension for "${book['title']}" from ${book['borrowedFrom']}?',
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontFamily: 'Inter',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Request',
              style: TextStyle(fontFamily: 'Inter'),
            ),
          ),
        ],
      ),
    );
  }

  void _showReturnDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Mark as Returned',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Mark "${book['title']}" as returned to ${book['borrowedFrom']}?',
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontFamily: 'Inter',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement return logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF059669),
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Mark Returned',
              style: TextStyle(fontFamily: 'Inter'),
            ),
          ),
        ],
      ),
    );
  }
}

class UrgencyLevel {
  final String text;
  final Color color;
  final IconData icon;

  UrgencyLevel({
    required this.text,
    required this.color,
    required this.icon,
  });
}

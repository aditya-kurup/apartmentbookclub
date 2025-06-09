import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with status bar elements
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Status indicators
                    Row(
                      children: [
                        Container(
                          width: 26,
                          height: 17,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1769FF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Opacity(
                          opacity: 0.6,
                          child: Container(
                            width: 26,
                            height: 17,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3B82F6),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Right side placeholder for system icons
                    const SizedBox(width: 22, height: 22),
                  ],
                ),
              ),
              
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 12),
                      Icon(
                        Icons.search,
                        size: 16,
                        color: Color(0xFFADAEBC),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Search books, authors...',
                          style: TextStyle(
                            color: Color(0xFFADAEBC),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Hero banner
              Container(
                width: double.infinity,
                height: 160,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Explore the world through books',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // First book section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Class XI books just for you!',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
              
              // First book row
              SizedBox(
                height: 270,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildBookCard('Geografi Kelas XI', 'Erlangga'),
                    const SizedBox(width: 12),
                    _buildBookCard('Fisika Kelas XI', 'Erlangga'),
                    const SizedBox(width: 12),
                    _buildBookCard('Kimia Kelas 11', 'Erlangga'),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Second book section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recommended for you',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Second book row
              SizedBox(
                height: 270,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildBookCard('Biologi Kelas XI', 'Erlangga'),
                    const SizedBox(width: 12),
                    _buildBookCard('Matematika XI', 'Erlangga'),
                    const SizedBox(width: 12),
                    _buildBookCard('Bahasa Indonesia XI', 'Erlangga'),
                  ],
                ),
              ),
              
              // Bottom padding for navigation bar
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookCard(String title, String author) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 160,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://picsum.photos/152/200?random=${title.hashCode}",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
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
        const SizedBox(height: 8),
        SizedBox(
          width: 160,
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              letterSpacing: -0.14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          author,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.12,
          ),
        ),
      ],
    );
  }
}

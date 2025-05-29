import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {  final List<Map<String, dynamic>> myBooks = [
    {
      "title": "Atomic Habits",
      "author": "James Clear",
      "progress": 0.75,
      "rating": 4.7,
      "status": "Reading",
      "image": "https://placehold.co/300x450/4ecdc4/ffffff?text=Non-Fiction"
    },
    {
      "title": "The Silent Patient",
      "author": "Alex Michaelides",
      "progress": 1.0,
      "rating": 4.8,
      "status": "Completed",
      "image": "https://placehold.co/400x600/45b7d1/ffffff?text=Mystery"
    },
    {
      "title": "Where the Crawdads Sing",
      "author": "Delia Owens",
      "progress": 0.45,
      "rating": 4.6,
      "status": "Reading",
      "image": "https://placehold.co/400x600/ff6b6b/ffffff?text=Fiction"
    },
    {
      "title": "The Seven Husbands",
      "author": "Taylor Jenkins Reid",
      "progress": 0.0,
      "rating": 0.0,
      "status": "To Read",
      "image": "https://placehold.co/400x600/7b68ee/ffffff?text=Romance"
    },
  ];
    final List<Map<String, dynamic>> borrowedBooks = [
    {
      "title": "The Midnight Library",
      "author": "Matt Haig",
      "daysLeft": 5,
      "borrowDate": "May 15, 2025",
      "returnDate": "June 5, 2025",
      "image": "https://placehold.co/400x600/ff6b6b/ffffff?text=Fiction"
    },
    {
      "title": "Project Hail Mary",
      "author": "Andy Weir",
      "daysLeft": 12,
      "borrowDate": "May 20, 2025",
      "returnDate": "June 12, 2025",
      "image": "https://placehold.co/400x600/4a90e2/ffffff?text=Science+Fiction"
    },
  ];
    final List<Map<String, dynamic>> lentBooks = [
    {
      "title": "The Thursday Murder Club",
      "author": "Richard Osman",
      "borrower": "Alice Smith",
      "lendDate": "May 10, 2025",
      "returnDate": "June 10, 2025",
      "image": "https://placehold.co/400x600/45b7d1/ffffff?text=Mystery"
    },
    {
      "title": "Normal People",
      "author": "Sally Rooney",
      "borrower": "John Doe",
      "lendDate": "May 25, 2025",
      "returnDate": "June 25, 2025",
      "image": "https://placehold.co/400x600/7b68ee/ffffff?text=Romance"
    },
  ];
  String selectedTab = "All";
  final List<String> tabs = ["All", "Reading", "Completed", "To Read"];
  
  String selectedSection = "My Books";
  final List<String> sections = ["My Books", "Borrowing", "Lending"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildSectionSelector(),
              const SizedBox(height: 24),
              if (selectedSection == "My Books") ...[
                _buildTabBar(),
                const SizedBox(height: 24),
                Expanded(
                  child: _buildBooksList(),
                ),
              ] else if (selectedSection == "Borrowing") ...[
                Expanded(
                  child: _buildBorrowedBooksList(),
                ),
              ] else if (selectedSection == "Lending") ...[
                Expanded(
                  child: _buildLentBooksList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [        Text(
          "My Library",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryColor,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: AppTheme.primaryColor,
            size: 28,
          ),
        ),
      ],
    );  }

  Widget _buildSectionSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: sections.map((section) {
          final isSelected = selectedSection == section;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedSection = section;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(25),
                border: isSelected 
                    ? null 
                    : Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
              ),
              child: Text(
                section,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = tab;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(25),
                border: isSelected 
                    ? null 
                    : Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
              ),
              child: Text(
                tab,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBooksList() {
    final filteredBooks = selectedTab == "All" 
        ? myBooks 
        : myBooks.where((book) => book["status"] == selectedTab).toList();

    return ListView.builder(
      itemCount: filteredBooks.length,
      itemBuilder: (context, index) {
        final book = filteredBooks[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 100,
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    book["image"],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppTheme.primaryColor,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      book["title"],
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book["author"],
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (book["status"] == "Reading") ...[
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: book["progress"],
                              backgroundColor: AppTheme.surfaceColor,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppTheme.accentColor,
                              ),
                              minHeight: 5,
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "${(book["progress"] * 100).toInt()}%",
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ] else if (book["status"] == "Completed") ...[
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            book["rating"].toString(),
                            style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "Completed",
                              style: TextStyle(
                                color: AppTheme.accentColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Row(
                        children: [
                          const Icon(
                            Icons.watch_later_outlined,
                            color: AppTheme.textSecondary,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "Added to reading list",
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        );      },
    );
  }
  
  Widget _buildBorrowedBooksList() {
    return ListView.builder(
      itemCount: borrowedBooks.length,
      itemBuilder: (context, index) {
        final book = borrowedBooks[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 100,
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    book["image"],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppTheme.primaryColor,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      book["title"],
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book["author"],
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: book["daysLeft"] < 7 
                                ? Colors.red.withOpacity(0.1) 
                                : AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer,
                                color: book["daysLeft"] < 7 ? Colors.red : AppTheme.primaryColor,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${book["daysLeft"]} days left",
                                style: TextStyle(
                                  color: book["daysLeft"] < 7 ? Colors.red : AppTheme.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Return by: ${book["returnDate"]}",
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme.primaryColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildLentBooksList() {
    return ListView.builder(
      itemCount: lentBooks.length,
      itemBuilder: (context, index) {
        final book = lentBooks[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 100,
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    book["image"],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppTheme.primaryColor,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      book["title"],
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book["author"],
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: AppTheme.accentColor,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                book["borrower"],
                                style: TextStyle(
                                  color: AppTheme.accentColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Return expected: ${book["returnDate"]}",
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme.primaryColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

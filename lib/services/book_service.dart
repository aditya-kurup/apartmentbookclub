import '../models/book.dart';

class BookService {
  static final BookService _instance = BookService._internal();
  factory BookService() => _instance;
  BookService._internal();

  // Mock data for demonstration
  final List<Book> _books = [    Book(
      id: '1',
      title: 'The Seven Husbands of Evelyn Hugo',
      author: 'Taylor Jenkins Reid',
      description: 'A reclusive Hollywood icon finally tells her story to a young journalist.',
      coverUrl: '/placeholder.svg?height=300&width=200',
      category: 'Fiction',
      rating: 4.8,
      pages: 400,
      isbn: '9781501161933',
      publishedDate: DateTime(2017, 6, 13),
      isFeatured: true,
      isNewArrival: false,
      publisher: 'Atria Books',
      maxLendingDays: 14,
      lenderId: null,
      apartmentId: '11111111-1111-1111-1111-111111111111',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),    Book(
      id: '2',
      title: 'Atomic Habits',
      author: 'James Clear',
      description: 'An easy & proven way to build good habits & break bad ones.',
      coverUrl: '/placeholder.svg?height=300&width=200',
      category: 'Self-Help',
      rating: 4.7,
      pages: 320,
      isbn: '9780735211292',
      publishedDate: DateTime(2018, 10, 16),
      isFeatured: true,
      isNewArrival: false,
      publisher: 'Avery',
      maxLendingDays: 14,
      lenderId: null,
      apartmentId: '11111111-1111-1111-1111-111111111111',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),    Book(
      id: '3',
      title: 'The Thursday Murder Club',
      author: 'Richard Osman',
      description: 'Four unlikely friends meet weekly to investigate cold cases.',
      coverUrl: '/placeholder.svg?height=300&width=200',
      category: 'Mystery',
      rating: 4.5,
      pages: 368,
      isbn: '9780241425442',
      publishedDate: DateTime(2020, 9, 3),
      isFeatured: false,
      isNewArrival: true,
      publisher: 'Viking',
      maxLendingDays: 14,
      lenderId: null,
      apartmentId: '11111111-1111-1111-1111-111111111111',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),    Book(
      id: '4',
      title: 'Dune',
      author: 'Frank Herbert',
      description: 'A science fiction epic set on the desert planet Arrakis.',
      coverUrl: '/placeholder.svg?height=300&width=200',
      category: 'Sci-Fi',
      rating: 4.6,
      pages: 688,
      isbn: '9780441172719',
      publishedDate: DateTime(1965, 8, 1),
      isFeatured: false,
      isNewArrival: false,
      publisher: 'Ace Books',
      maxLendingDays: 21,
      lenderId: null,
      apartmentId: '11111111-1111-1111-1111-111111111111',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),    Book(
      id: '5',
      title: 'The Midnight Library',
      author: 'Matt Haig',
      description: 'Between life and death there is a library, and within that library, the shelves go on forever.',
      coverUrl: '/placeholder.svg?height=300&width=200',
      category: 'Fiction',
      rating: 4.4,
      pages: 288,
      isbn: '9780525559474',
      publishedDate: DateTime(2020, 8, 13),
      isFeatured: false,
      isNewArrival: true,
      publisher: 'Doubleday',
      maxLendingDays: 14,
      lenderId: null,
      apartmentId: '11111111-1111-1111-1111-111111111111',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),    Book(
      id: '6',
      title: 'Educated',
      author: 'Tara Westover',
      description: 'A memoir about a young girl who, kept out of school, leaves her survivalist family and goes on to earn a PhD from Cambridge University.',
      coverUrl: '/placeholder.svg?height=300&width=200',
      category: 'Biography',
      rating: 4.9,
      pages: 334,
      isbn: '9780399590504',
      publishedDate: DateTime(2018, 2, 20),
      isFeatured: true,
      isNewArrival: false,
      publisher: 'Random House',
      maxLendingDays: 14,
      lenderId: null,
      apartmentId: '11111111-1111-1111-1111-111111111111',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  Future<List<Book>> getAllBooks() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call
    return _books;
  }

  Future<List<Book>> getFeaturedBooks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _books.where((book) => book.isFeatured).toList();
  }

  Future<List<Book>> getNewArrivals() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _books.where((book) => book.isNewArrival).toList();
  }

  Future<List<Book>> getBooksByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (category == 'All') return _books;
    return _books.where((book) => book.category == category).toList();
  }

  Future<List<Book>> searchBooks(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final lowercaseQuery = query.toLowerCase();
    return _books.where((book) =>
        book.title.toLowerCase().contains(lowercaseQuery) ||
        book.author.toLowerCase().contains(lowercaseQuery) ||
        book.category.toLowerCase().contains(lowercaseQuery)
    ).toList();
  }

  Future<Book?> getBookById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _books.firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }
}

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String description;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
  });

  static List<Product> sampleProducts = [
    Product(
      id: '1',
      name: 'Nike Air Max 270',
      category: 'Shoes',
      price: 149.99,
      rating: 4.8,
      reviewCount: 320,
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&auto=format&fit=crop&q=80',
      description: 'The Nike Air Max 270 delivers unrivaled, all-day comfort with sleek futuristic aesthetics.',
    ),
    Product(
      id: '2',
      name: 'Sony WH-1000XM5',
      category: 'Electronics',
      price: 349.99,
      rating: 4.9,
      reviewCount: 540,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&auto=format&fit=crop&q=80',
      description: 'Industry-leading noise canceling wireless headphones with crystal clear call quality.',
    ),
    Product(
      id: '3',
      name: 'Apple Watch Series 9',
      category: 'Electronics',
      price: 399.00,
      rating: 4.7,
      reviewCount: 210,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&auto=format&fit=crop&q=80',
      description: 'Smarter, brighter, and more powerful fitness tracking right on your wrist.',
    ),
    Product(
      id: '4',
      name: 'Leather Urban Jacket',
      category: 'Fashion',
      price: 189.50,
      rating: 4.6,
      reviewCount: 95,
      imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=600&auto=format&fit=crop&q=80',
      description: 'Premium genuine leather jacket crafted for style, durability, and daily comfort.',
    ),
    Product(
      id: '5',
      name: 'Ray-Ban Aviator Classic',
      category: 'Accessories',
      price: 163.00,
      rating: 4.8,
      reviewCount: 410,
      imageUrl: 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=600&auto=format&fit=crop&q=80',
      description: 'Timeless style with polarized lenses providing 100% UV protection.',
    ),
    Product(
      id: '6',
      name: 'Herschel Supply Backpack',
      category: 'Accessories',
      price: 89.99,
      rating: 4.5,
      reviewCount: 180,
      imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&auto=format&fit=crop&q=80',
      description: 'Spacious everyday backpack featuring padded laptop sleeve and signature fabric liner.',
    ),
  ];
}

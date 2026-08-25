/// Bike Item Model
/// বাইক শপের প্রতিটি আইটেমের ইনফরমেশন ধারণের মডেল।
class BikeItem {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;

  BikeItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
  });
}

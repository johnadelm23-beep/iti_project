class WishlistMovieModel {
  final int id;
  final String title;
  final String posterUrl;
  final double rating;

  const WishlistMovieModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.rating,
  });

  factory WishlistMovieModel.fromJson(Map<String, dynamic> json) {
    return WishlistMovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterUrl: json['posterUrl'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterUrl': posterUrl,
      'rating': rating,
    };
  }
}

import 'package:iti_training/features/wishlist/data/models/wish_list_model.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<WishlistMovieModel> movies;

  WishlistLoaded(this.movies);
}

class WishlistError extends WishlistState {
  final String message;

  WishlistError(this.message);
}

class WishlistActionLoading extends WishlistState {
  final List<WishlistMovieModel> movies;

  WishlistActionLoading(this.movies);
}
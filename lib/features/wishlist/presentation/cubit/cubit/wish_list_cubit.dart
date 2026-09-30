import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_training/features/wishlist/data/models/wish_list_model.dart';
import 'package:iti_training/features/wishlist/data/repo/wish_list_repo.dart';
import 'package:iti_training/features/wishlist/presentation/cubit/cubit/wish_list_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepo wishlistRepo;

  WishlistCubit(this.wishlistRepo) : super(WishlistInitial());

  Future<void> loadWishlist() async {
    emit(WishlistLoading());

    try {
      final movies = await wishlistRepo.getWishlist();

      emit(WishlistLoaded(movies));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> addMovie(
    WishlistMovieModel movie,
  ) async {
    final currentMovies = _currentMovies;

    emit(WishlistActionLoading(currentMovies));

    try {
      await wishlistRepo.addToWishlist(movie);

      final updatedMovies = [
        ...currentMovies,
        movie,
      ];

      emit(WishlistLoaded(updatedMovies));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> removeMovie(int movieId) async {
    final currentMovies = _currentMovies;

    emit(WishlistActionLoading(currentMovies));

    try {
      await wishlistRepo.removeFromWishlist(movieId);

      final updatedMovies = currentMovies
          .where((movie) => movie.id != movieId)
          .toList();

      emit(WishlistLoaded(updatedMovies));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> toggleMovie(
    WishlistMovieModel movie,
  ) async {
    final exists = _currentMovies.any(
      (item) => item.id == movie.id,
    );

    if (exists) {
      await removeMovie(movie.id);
    } else {
      await addMovie(movie);
    }
  }

  bool isMovieInWishlist(int movieId) {
    return _currentMovies.any(
      (movie) => movie.id == movieId,
    );
  }

  List<WishlistMovieModel> get _currentMovies {
    final state = this.state;

    if (state is WishlistLoaded) {
      return state.movies;
    }

    if (state is WishlistActionLoading) {
      return state.movies;
    }

    return [];
  }
}
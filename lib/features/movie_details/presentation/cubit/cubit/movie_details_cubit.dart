import 'package:bloc/bloc.dart';
import 'package:iti_training/features/home/data/models/movie_details.dart';
import 'package:iti_training/features/home/data/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final HomeRepo homeRepo;
  MovieDetailsCubit(this.homeRepo) : super(MovieDetailsInitial());
  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final response = await homeRepo.getMovieDetails(movieId: movieId);
      emit(MovieDetailsSuccess(movie: response));
    } catch (e) {
      emit(MovieDetailsError(message: e.toString()));
    }
  }
}

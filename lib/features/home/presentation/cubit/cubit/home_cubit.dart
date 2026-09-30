import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_training/features/home/data/repo/home_repo.dart';
import 'package:iti_training/features/home/presentation/cubit/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitial());

  Future<void> getHomeMovies() async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        homeRepo.getPopularMovies(),
        homeRepo.getTopRatedMovies(),
        homeRepo.getNowPlayingMovies(),
        homeRepo.getUpcomingMovies(),
      ]);

      emit(
        HomeSuccess(
          popularMovies: results[0],
          topRatedMovies: results[1],
          nowPlayingMovies: results[2],
          upcomingMovies: results[3],
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      return;
    }

    emit(HomeSearchLoading());

    try {
      final movies = await homeRepo.searchMovie(
        query:  query.trim(),
      );

      emit(HomeSearchSuccess(movies));
    } catch (e) {
      emit(
        HomeSearchError(
          e.toString(),
        ),
      );
    }
  }
}
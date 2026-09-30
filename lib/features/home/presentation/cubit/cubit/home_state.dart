import 'package:iti_training/features/home/data/models/movie_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<MovieModel> popularMovies;
  final List<MovieModel> topRatedMovies;
  final List<MovieModel> nowPlayingMovies;
  final List<MovieModel> upcomingMovies;

  HomeSuccess({
    required this.popularMovies,
    required this.topRatedMovies,
    required this.nowPlayingMovies,
    required this.upcomingMovies,
  });
}

class HomeSearchLoading extends HomeState {}

class HomeSearchSuccess extends HomeState {
  final List<MovieModel> movies;

  HomeSearchSuccess(this.movies);
}

class HomeSearchError extends HomeState {
  final String message;

  HomeSearchError(this.message);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
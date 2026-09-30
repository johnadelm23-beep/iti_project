part of 'movie_details_cubit.dart';

@immutable
sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoading extends MovieDetailsState {}

final class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsModel movie;
  MovieDetailsSuccess({required this.movie});
}

final class MovieDetailsError extends MovieDetailsState {
  final String message;
  MovieDetailsError({required this.message});
}

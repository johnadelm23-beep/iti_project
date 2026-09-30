import 'package:iti_training/core/network/api_constants.dart';
import 'package:iti_training/core/network/api_service.dart';
import 'package:iti_training/features/home/data/models/movie_details.dart';
import 'package:iti_training/features/home/data/models/movie_model.dart';

class HomeRepo {
  final ApiService apiService;

  HomeRepo(this.apiService);

  Future<List<MovieModel>> getMovies(String path) async {
    final response = await apiService.get(path);

    final List<dynamic> results = response.data['results'];

    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }

  Future<List<MovieModel>> getPopularMovies() {
    return getMovies(ApiConstants.popularMovies);
  }

  Future<List<MovieModel>> getTopRatedMovies() {
    return getMovies(ApiConstants.topRatedMovies);
  }

  Future<List<MovieModel>> getNowPlayingMovies() {
    return getMovies(ApiConstants.nowPlayingMovies);
  }

  Future<List<MovieModel>> getUpcomingMovies() {
    return getMovies(ApiConstants.upcomingMovies);
  }

  searchMovie({required String query}) async {
    final response = await apiService.get(
      ApiConstants.searchMovies,
      queryParameters: {"query": query},
    );
    final List<dynamic> results = response.data['results'];
    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }

  getMovieDetails({required int movieId}) async {
    final response = await apiService.get(ApiConstants.movieDetails(movieId));
    return MovieDetailsModel.fromJson(response.data);
  }
}

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies/domain/entities/movies/movie.dart';
import 'package:movies/domain/usecase/get_movie_recommendations.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations _getMovieRecommendations;
  MovieRecommendationsBloc(this._getMovieRecommendations)
      : super(MovieRecommendationsEmpty()) {
    on<OnMovieRecommendationsCalled>((event, emit) async {
      final id = event.id;

      emit(MovieRecommendationsLoading());

      final result = await _getMovieRecommendations.execute(id);

      result.fold(
        (failure) => emit(MovieRecommendationsError(failure.message)),
        (data) => data.isNotEmpty
            ? emit(MovieRecommendationsHasData(data))
            : emit(MovieRecommendationsEmpty()),
      );
    });
  }
}

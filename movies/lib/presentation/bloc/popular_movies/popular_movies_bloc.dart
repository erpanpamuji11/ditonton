import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies/domain/entities/movies/movie.dart';
import 'package:movies/domain/usecase/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;
  PopularMoviesBloc(this._getPopularMovies) : super(PopularMoviesEmpty()) {
    on<OnPopularMoviesCalled>((event, emit) async {
      emit(PopularMoviesLoading());

      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) => emit(PopularMoviesError(failure.message)),
        (data) => data.isNotEmpty
            ? emit(PopularMoviesHasData(data))
            : emit(PopularMoviesEmpty()),
      );
    });
  }
}

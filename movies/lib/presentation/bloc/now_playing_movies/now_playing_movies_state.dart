part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMovieState extends Equatable {}

class NowPlayingMovieEmpty extends NowPlayingMovieState {
  @override
  List<Object> get props => [];
}

class NowPlayingMovieLoading extends NowPlayingMovieState {
  @override
  List<Object> get props => [];
}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;
  NowPlayingMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMovieHasData extends NowPlayingMovieState {
  final List<Movie> result;
  NowPlayingMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

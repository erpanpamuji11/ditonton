part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMovieEvent extends Equatable {}

class OnNowPlayingMovieCalled extends NowPlayingMovieEvent {
  @override
  List<Object> get props => [];
}

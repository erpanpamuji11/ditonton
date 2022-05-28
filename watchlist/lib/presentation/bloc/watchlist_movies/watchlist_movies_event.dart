part of 'watchlist_movies_bloc.dart';

@immutable
abstract class WatchlistMoviesEvent extends Equatable {}

class OnWatchlistMoviesCalled extends WatchlistMoviesEvent {
  @override
  List<Object?> get props => [];
}

class FetchWatchlistStatus extends WatchlistMoviesEvent {
  final int id;
  FetchWatchlistStatus(this.id);
  @override
  List<Object?> get props => [id];
}

class AddMovieToWatchlist extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;
  AddMovieToWatchlist(this.movieDetail);
  @override
  List<Object?> get props => [movieDetail];
}

class RemoveMovieFromWatchlist extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;
  RemoveMovieFromWatchlist(this.movieDetail);
  @override
  List<Object?> get props => [movieDetail];
}

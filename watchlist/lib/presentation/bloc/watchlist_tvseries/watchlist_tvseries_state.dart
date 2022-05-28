part of 'watchlist_tvseries_bloc.dart';

@immutable
abstract class WatchlistTvseriesState extends Equatable {}

class WatchlistTvseriesEmpty extends WatchlistTvseriesState {
  @override
  List<Object?> get props => [];
}

class WatchlistTvseriesLoading extends WatchlistTvseriesState {
  @override
  List<Object?> get props => [];
}

class WatchlistTvseriesError extends WatchlistTvseriesState {
  final String message;
  WatchlistTvseriesError(this.message);
  @override
  List<Object?> get props => [message];
}

class WatchlistTvseriesHasData extends WatchlistTvseriesState {
  final List<TvSeries> result;
  WatchlistTvseriesHasData(this.result);
  @override
  List<Object?> get props => [result];
}

class WatchlistTvseriesIsAdded extends WatchlistTvseriesState {
  final bool isAdded;
  WatchlistTvseriesIsAdded(this.isAdded);
  @override
  List<Object?> get props => [isAdded];
}

class WatchlistTvseriesMessage extends WatchlistTvseriesState {
  final String message;

  WatchlistTvseriesMessage(this.message);
  @override
  List<Object?> get props => [message];
}

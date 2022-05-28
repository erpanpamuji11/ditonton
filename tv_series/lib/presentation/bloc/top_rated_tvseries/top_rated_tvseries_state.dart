part of 'top_rated_tvseries_bloc.dart';

@immutable
abstract class TopRatedTvseriesState extends Equatable {}

class TopRatedTvseriesEmpty extends TopRatedTvseriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvseriesLoading extends TopRatedTvseriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvseriesError extends TopRatedTvseriesState {
  final String message;
  TopRatedTvseriesError(this.message);
  @override
  List<Object?> get props => [message];
}

class TopRatedTvseriesHasData extends TopRatedTvseriesState {
  final List<TvSeries> result;
  TopRatedTvseriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

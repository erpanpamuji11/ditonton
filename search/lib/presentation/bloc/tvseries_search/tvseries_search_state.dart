part of 'tvseries_search_bloc.dart';

@immutable
abstract class TvseriesSearchState extends Equatable {
  const TvseriesSearchState();

  @override
  List<Object> get props => [];
}

class TvseriesSearchEmpty extends TvseriesSearchState {}

class TvseriesSearchLoading extends TvseriesSearchState {}

class TvseriesSearchError extends TvseriesSearchState {
  final String message;

  const TvseriesSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class TvseriesSearchHasData extends TvseriesSearchState {
  final List<TvSeries> result;

  const TvseriesSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}

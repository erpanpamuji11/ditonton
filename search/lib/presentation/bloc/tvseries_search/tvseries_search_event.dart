part of 'tvseries_search_bloc.dart';

@immutable
abstract class TvseriesSearchEvent extends Equatable {
  const TvseriesSearchEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesOnQueryChanged extends TvseriesSearchEvent {
  final String query;

  const TvSeriesOnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

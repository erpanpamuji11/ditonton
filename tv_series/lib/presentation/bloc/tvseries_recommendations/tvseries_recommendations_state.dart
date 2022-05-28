part of 'tvseries_recommendations_bloc.dart';

@immutable
abstract class TvseriesRecommendationsState extends Equatable {}

class TvseriesRecommendationsEmpty extends TvseriesRecommendationsState {
  @override
  List<Object?> get props => [];
}

class TvseriesRecommendationsLoading extends TvseriesRecommendationsState {
  @override
  List<Object?> get props => [];
}

class TvseriesRecommendationsError extends TvseriesRecommendationsState {
  final String message;
  TvseriesRecommendationsError(this.message);
  @override
  List<Object?> get props => [message];
}

class TvseriesRecommendationsHasData extends TvseriesRecommendationsState {
  final List<TvSeries> result;
  TvseriesRecommendationsHasData(this.result);
  @override
  List<Object?> get props => [result];
}

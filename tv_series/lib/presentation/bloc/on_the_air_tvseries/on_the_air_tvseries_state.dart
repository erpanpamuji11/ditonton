part of 'on_the_air_tvseries_bloc.dart';

@immutable
abstract class OnTheAirTvseriesState extends Equatable {}

class OnTheAirTvseriesEmpty extends OnTheAirTvseriesState {
  @override
  List<Object> get props => [];
}

class OnTheAirTvseriesLoading extends OnTheAirTvseriesState {
  @override
  List<Object> get props => [];
}

class OnTheAirTvseriesError extends OnTheAirTvseriesState {
  final String message;
  OnTheAirTvseriesError(this.message);

  @override
  List<Object> get props => [message];
}

class OnTheAirTvseriesHasData extends OnTheAirTvseriesState {
  final List<TvSeries> result;
  OnTheAirTvseriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

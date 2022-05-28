part of 'tvseries_detail_bloc.dart';

@immutable
abstract class TvseriesDetailState extends Equatable {}

class TvseriesDetailEmpty extends TvseriesDetailState {
  @override
  List<Object?> get props => [];
}

class TvseriesDetailLoading extends TvseriesDetailState {
  @override
  List<Object?> get props => [];
}

class TvseriesDetailError extends TvseriesDetailState {
  final String message;

  TvseriesDetailError(this.message);
  @override
  List<Object?> get props => [message];
}

class TvseriesDetailHasData extends TvseriesDetailState {
  final TvSeriesDetail result;

  TvseriesDetailHasData(this.result);
  @override
  List<Object?> get props => [result];
}

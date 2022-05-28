part of 'tvseries_detail_bloc.dart';

@immutable
abstract class TvseriesDetailEvent extends Equatable {}

class OnTvseriesDetailCalled extends TvseriesDetailEvent {
  final int id;

  OnTvseriesDetailCalled(this.id);
  @override
  List<Object?> get props => [id];
}

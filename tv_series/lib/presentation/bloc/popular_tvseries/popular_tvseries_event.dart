part of 'popular_tvseries_bloc.dart';

@immutable
abstract class PopularTvseriesEvent extends Equatable {}

class OnPopularTvseriesCalled extends PopularTvseriesEvent {
  @override
  List<Object> get props => [];
}

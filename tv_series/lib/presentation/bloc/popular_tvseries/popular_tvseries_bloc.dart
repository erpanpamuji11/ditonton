import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries.dart';
import 'package:tv_series/domain/usecase/get_popular_tvseries.dart';

part 'popular_tvseries_event.dart';
part 'popular_tvseries_state.dart';

class PopularTvseriesBloc
    extends Bloc<PopularTvseriesEvent, PopularTvseriesState> {
  final GetPopularTvSeries _getPopularTvseries;
  PopularTvseriesBloc(this._getPopularTvseries)
      : super(PopularTvseriesEmpty()) {
    on<OnPopularTvseriesCalled>((event, emit) async {
      emit(PopularTvseriesLoading());

      final result = await _getPopularTvseries.execute();

      result.fold(
        (failure) => emit(PopularTvseriesError(failure.message)),
        (data) => data.isNotEmpty
            ? emit(PopularTvseriesHasData(data))
            : emit(PopularTvseriesEmpty()),
      );
    });
  }
}

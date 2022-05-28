import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries_detail.dart';
import 'package:tv_series/domain/usecase/get_tvseries_detail.dart';

part 'tvseries_detail_event.dart';
part 'tvseries_detail_state.dart';

class TvseriesDetailBloc
    extends Bloc<TvseriesDetailEvent, TvseriesDetailState> {
  final GetTvSeriesDetail _getTvseriesDetail;
  TvseriesDetailBloc(this._getTvseriesDetail) : super(TvseriesDetailEmpty()) {
    on<OnTvseriesDetailCalled>((event, emit) async {
      final id = event.id;

      emit(TvseriesDetailLoading());

      final result = await _getTvseriesDetail.execute(id);

      result.fold((failure) => emit(TvseriesDetailError(failure.message)),
          (data) => emit(TvseriesDetailHasData(data)));
    });
  }
}

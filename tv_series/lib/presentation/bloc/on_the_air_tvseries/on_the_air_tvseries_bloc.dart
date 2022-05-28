import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries.dart';
import 'package:tv_series/domain/usecase/get_now_playing_tvseries.dart';

part 'on_the_air_tvseries_event.dart';
part 'on_the_air_tvseries_state.dart';

class OnTheAirTvseriesBloc
    extends Bloc<OnTheAirTvseriesEvent, OnTheAirTvseriesState> {
  final GetOnTheAirTvSeries _getOnTheAirTvseriess;
  OnTheAirTvseriesBloc(this._getOnTheAirTvseriess)
      : super(OnTheAirTvseriesEmpty()) {
    on<OnTheAirTvseries>((event, emit) async {
      emit(OnTheAirTvseriesLoading());

      final result = await _getOnTheAirTvseriess.execute();

      result.fold((failure) {
        emit(OnTheAirTvseriesError(failure.message));
      }, (data) {
        data.isNotEmpty
            ? emit(OnTheAirTvseriesHasData(data))
            : emit(OnTheAirTvseriesEmpty());
      });
    });
  }
}

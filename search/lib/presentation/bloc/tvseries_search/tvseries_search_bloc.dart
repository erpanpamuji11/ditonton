import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecase/search_tvseries.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries.dart';

part 'tvseries_search_event.dart';
part 'tvseries_search_state.dart';

EventTransformer<T> tvseriesDebounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class TvseriesSearchBloc
    extends Bloc<TvseriesSearchEvent, TvseriesSearchState> {
  final SearchTvSeries _searchTvSeries;
  TvseriesSearchBloc(this._searchTvSeries) : super(TvseriesSearchEmpty()) {
    on<TvSeriesOnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(TvseriesSearchLoading());

        final result = await _searchTvSeries.execute(query);

        result.fold(
          (failure) {
            emit(TvseriesSearchError(failure.message));
          },
          (data) {
            emit(TvseriesSearchHasData(data));
          },
        );
      },
      transformer: tvseriesDebounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries_detail.dart';
import 'package:watchlist/domain/usecase/tvseries/get_watchlist_tvseries.dart';
import 'package:watchlist/domain/usecase/tvseries/get_watchlist_tvseries_status.dart';
import 'package:watchlist/domain/usecase/tvseries/remove_tvseries_watchlist.dart';
import 'package:watchlist/domain/usecase/tvseries/save_tvseries_watchlist.dart';

part 'watchlist_tvseries_event.dart';
part 'watchlist_tvseries_state.dart';

class WatchlistTvseriesBloc
    extends Bloc<WatchlistTvseriesEvent, WatchlistTvseriesState> {
  final GetWatchlistTvSeries _getWatchlistTvseries;
  final GetWatchListStatusTvSeries _getWatchListStatusTvseries;
  final RemoveWatchlistTvSeries _removeWatchlistTvseries;
  final SaveWatchlistTvSeries _saveWatchlistTvseries;
  WatchlistTvseriesBloc(
    this._getWatchlistTvseries,
    this._getWatchListStatusTvseries,
    this._removeWatchlistTvseries,
    this._saveWatchlistTvseries,
  ) : super(WatchlistTvseriesEmpty()) {
    on<OnWatchlistTvseriesCalled>((event, emit) async {
      emit(WatchlistTvseriesLoading());
      final result = await _getWatchlistTvseries.execute();
      result.fold(
        (failure) => emit(WatchlistTvseriesError(failure.message)),
        (data) => data.isNotEmpty
            ? emit(WatchlistTvseriesHasData(data))
            : emit(WatchlistTvseriesEmpty()),
      );
    });

    on<FetchWatchlistStatus>(((event, emit) async {
      final id = event.id;

      final result = await _getWatchListStatusTvseries.execute(id);

      emit(WatchlistTvseriesIsAdded(result));
    }));

    on<AddTvseriesToWatchlist>(
      ((event, emit) async {
        final movie = event.tvseries;

        final result = await _saveWatchlistTvseries.execute(movie);

        result.fold(
          (failure) => emit(WatchlistTvseriesError(failure.message)),
          (message) => emit(
            WatchlistTvseriesMessage(message),
          ),
        );
      }),
    );

    on<RemoveTvseriesFromWatchlist>(
      ((event, emit) async {
        final tvseries = event.tvseries;

        final result = await _removeWatchlistTvseries.execute(tvseries);

        result.fold(
          (failure) => emit(WatchlistTvseriesError(failure.message)),
          (message) => emit(
            WatchlistTvseriesMessage(message),
          ),
        );
      }),
    );
  }
}

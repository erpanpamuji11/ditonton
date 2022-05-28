import 'package:core/data/datasources/db/database_helper_tvseries.dart';
import 'package:core/data/models/tv_series/tvseries_table.dart';
import 'package:core/utils/exception.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlistTvSeries(TvSeriesTable tvSeries);
  Future<String> removeWatchlistTvSeries(TvSeriesTable tvSeries);
  Future<TvSeriesTable?> getMovieByIdTvSeries(int id);
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelperTvSeries databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTvSeries(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertWatchlistTvSeries(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTvSeries(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertWatchlistTvSeries(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getMovieByIdTvSeries(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }
}

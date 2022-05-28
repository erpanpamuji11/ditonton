import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getOnTheAirTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveWatchlistTvSeries(TvSeriesDetail tv);
  Future<Either<Failure, String>> removeWatchlistTvSeries(TvSeriesDetail tv);
  Future<bool> isAddedToWatchlistTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
}

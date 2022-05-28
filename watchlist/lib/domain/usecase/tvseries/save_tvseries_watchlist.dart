import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries_detail.dart';
import 'package:tv_series/domain/repositories/tvseries_repository.dart';

class SaveWatchlistTvSeries {
  final TvSeriesRepository repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvseries) {
    return repository.saveWatchlistTvSeries(tvseries);
  }
}

import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries.dart';
import 'package:tv_series/domain/repositories/tvseries_repository.dart';

class SearchTvSeries {
  final TvSeriesRepository repository;

  SearchTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}

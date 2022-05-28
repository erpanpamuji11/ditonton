import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries.dart';
import 'package:tv_series/domain/repositories/tvseries_repository.dart';

class GetTvSeriesRecommendations {
  final TvSeriesRepository repository;

  GetTvSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getTvSeriesRecommendations(id);
  }
}

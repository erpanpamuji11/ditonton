import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series/tvseries_detail.dart';
import 'package:tv_series/domain/repositories/tvseries_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}

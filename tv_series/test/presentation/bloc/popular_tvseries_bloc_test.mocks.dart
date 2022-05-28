import 'dart:async' as _i5;
import 'package:tv_series/domain/entities/tv_series/tvseries.dart' as _i7;
import 'package:tv_series/domain/repositories/tvseries_repository.dart' as _i2;
import 'package:tv_series/domain/usecase/get_popular_tvseries.dart' as _i4;
import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;


class _FakeTvSeriesRepository_0 extends _i1.Fake
    implements _i2.TvSeriesRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetPopularTvSeries].
class MockGetPopularTvSeries extends _i1.Mock
    implements _i4.GetPopularTvSeries {
  MockGetPopularTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_0()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.TvSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}


import 'dart:async' as _i5;

import 'package:tv_series/domain/entities/tv_series/tvseries.dart' as _i8;
import 'package:tv_series/domain/entities/tv_series/tvseries_detail.dart' as _i10;
import 'package:tv_series/domain/repositories/tvseries_repository.dart' as _i2;
import 'package:watchlist/domain/usecase/tvseries/get_watchlist_tvseries.dart' as _i6;
import 'package:watchlist/domain/usecase/tvseries/get_watchlist_tvseries_status.dart'
as _i4;
import 'package:watchlist/domain/usecase/tvseries/remove_tvseries_watchlist.dart'
as _i9;
import 'package:watchlist/domain/usecase/tvseries/save_tvseries_watchlist.dart' as _i11;
import 'package:core/utils/failure.dart' as _i7;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

class _FakeTvSeriesRepository_0 extends _i1.Fake implements _i2.TvSeriesRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetWatchListStatusMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusTvSeries extends _i1.Mock
    implements _i4.GetWatchListStatusTvSeries {
  MockGetWatchListStatusTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_0()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [GetWatchlistTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTvSeries extends _i1.Mock
    implements _i6.GetWatchlistTvSeries {
  MockGetWatchlistTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.Either<_i7.Failure, List<_i8.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i7.Failure, List<_i8.TvSeries>>>.value(
              _FakeEither_1<_i7.Failure, List<_i8.TvSeries>>())) as _i5
          .Future<_i3.Either<_i7.Failure, List<_i8.TvSeries>>>);
}

/// A class which mocks [RemoveWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTvSeries extends _i1.Mock
    implements _i9.RemoveWatchlistTvSeries {
  MockRemoveWatchlistTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_0()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i7.Failure, String>> execute(
      _i10.TvSeriesDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
          returnValue: Future<_i3.Either<_i7.Failure, String>>.value(
              _FakeEither_1<_i7.Failure, String>()))
      as _i5.Future<_i3.Either<_i7.Failure, String>>);
}

/// A class which mocks [SaveWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTvSeries extends _i1.Mock
    implements _i11.SaveWatchlistTvSeries {
  MockSaveWatchlistTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_0()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i7.Failure, String>> execute(
      _i10.TvSeriesDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
          returnValue: Future<_i3.Either<_i7.Failure, String>>.value(
              _FakeEither_1<_i7.Failure, String>()))
      as _i5.Future<_i3.Either<_i7.Failure, String>>);
}

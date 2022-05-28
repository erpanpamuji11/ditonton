
import 'dart:async' as _i5;

import 'package:movies/domain/entities/movies/movie.dart' as _i8;
import 'package:movies/domain/entities/movies/movie_detail.dart' as _i10;
import 'package:movies/domain/repositories/movie_repository.dart' as _i2;
import 'package:watchlist/domain/usecase/movies/get_watchlist_movies.dart' as _i6;
import 'package:watchlist/domain/usecase/movies/get_watchlist_status.dart'
    as _i4;
import 'package:watchlist/domain/usecase/movies/remove_watchlist.dart'
    as _i9;
import 'package:watchlist/domain/usecase/movies/save_watchlist.dart' as _i11;
import 'package:core/utils/failure.dart' as _i7;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

class _FakeMovieRepository_0 extends _i1.Fake implements _i2.MovieRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetWatchListStatusMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusMovies extends _i1.Mock
    implements _i4.GetWatchListStatus {
  MockGetWatchListStatusMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [GetWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistMovies extends _i1.Mock
    implements _i6.GetWatchlistMovies {
  MockGetWatchlistMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.Either<_i7.Failure, List<_i8.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_1<_i7.Failure, List<_i8.Movie>>())) as _i5
          .Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>);
}

/// A class which mocks [RemoveWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistMovies extends _i1.Mock
    implements _i9.RemoveWatchlist {
  MockRemoveWatchlistMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i7.Failure, String>> execute(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i3.Either<_i7.Failure, String>>.value(
                  _FakeEither_1<_i7.Failure, String>()))
          as _i5.Future<_i3.Either<_i7.Failure, String>>);
}

/// A class which mocks [SaveWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistMovies extends _i1.Mock
    implements _i11.SaveWatchlist {
  MockSaveWatchlistMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i7.Failure, String>> execute(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i3.Either<_i7.Failure, String>>.value(
                  _FakeEither_1<_i7.Failure, String>()))
          as _i5.Future<_i3.Either<_i7.Failure, String>>);
}

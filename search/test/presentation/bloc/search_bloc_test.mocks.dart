import 'dart:async' as _i5;
import 'package:core/utils/failure.dart' as _i6;
import 'package:movies/domain/entities/movies/movie.dart' as _i7;
import 'package:movies/domain/repositories/movie_repository.dart' as _i2;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:search/domain/usecase/search_movies.dart' as _i4;


class _FakeMovieRepository_0 extends _i1.Fake implements _i2.MovieRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [SearchMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchMovies extends _i1.Mock implements _i4.SearchMovies {
  MockSearchMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Movie>>> execute(String? query) =>
      (super.noSuchMethod(Invocation.method(#execute, [query]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.Movie>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Movie>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Movie>>>);
}

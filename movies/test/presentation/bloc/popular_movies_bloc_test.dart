import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecase/get_popular_movies.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesBloc popularMoviesBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  test('the PopularMoviesEmpty initial state should be empty ', () {
    expect(popularMoviesBloc.state, PopularMoviesEmpty());
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'should emits PopularMovieLoading state and then PopularMovieHasData state when data is successfully fetched..',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnPopularMoviesCalled()),
    expect: () => <PopularMoviesState>[
      PopularMoviesLoading(),
      PopularMoviesHasData(testMovieList),
    ],
    verify: (bloc) => verify(mockGetPopularMovies.execute()),
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'should emits PopularMoviesLoading state and then PopularMoviesError state when data is failed fetched..',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnPopularMoviesCalled()),
    expect: () => <PopularMoviesState>[
      PopularMoviesLoading(),
      PopularMoviesError('Server Failure'),
    ],
    verify: (bloc) => PopularMoviesLoading(),
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'should emits PopularMoviesLoading state and then PopularMoviesEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnPopularMoviesCalled()),
    expect: () => <PopularMoviesState>[
      PopularMoviesLoading(),
      PopularMoviesEmpty(),
    ],
  );
}

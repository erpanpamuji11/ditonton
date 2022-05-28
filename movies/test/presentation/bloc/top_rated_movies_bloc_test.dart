import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecase/get_top_rated_movies.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc topRatedMoviesBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  test('the TopRatedMoviesEmpty initial state should be empty ', () {
    expect(topRatedMoviesBloc.state, TopRatedMoviesEmpty());
  });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'should emits PopularMovieLoading state and then PopularMovieHasData state when data is successfully fetched..',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedMoviesCalled()),
    expect: () => <TopRatedMoviesState>[
      TopRatedMoviesLoading(),
      TopRatedMoviesHasData(testMovieList),
    ],
    verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'should emits TopRatedMoviesLoading state and then TopRatedMoviesError state when data is failed fetched..',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedMoviesCalled()),
    expect: () => <TopRatedMoviesState>[
      TopRatedMoviesLoading(),
      TopRatedMoviesError('Server Failure'),
    ],
    verify: (bloc) => TopRatedMoviesLoading(),
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'should emits TopRatedMoviesLoading state and then TopRatedMoviesEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedMoviesCalled()),
    expect: () => <TopRatedMoviesState>[
      TopRatedMoviesLoading(),
      TopRatedMoviesEmpty(),
    ],
  );
}

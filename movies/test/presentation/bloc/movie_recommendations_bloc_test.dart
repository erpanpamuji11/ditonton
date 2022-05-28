import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecase/get_movie_recommendations.dart';
import 'package:movies/presentation/bloc/movie_recommendations/movie_recommendations_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'movie_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecommendationsBloc movieRecommendationsBloc;

  const testId = 1;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsBloc =
        MovieRecommendationsBloc(mockGetMovieRecommendations);
  });

  test('the MovieRecommendationsEmpty initial state should be empty ', () {
    expect(movieRecommendationsBloc.state, MovieRecommendationsEmpty());
  });

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'should emits PopularMovieLoading state and then PopularMovieHasData state when data is successfully fetched..',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnMovieRecommendationsCalled(testId)),
    expect: () => <MovieRecommendationsState>[
      MovieRecommendationsLoading(),
      MovieRecommendationsHasData(testMovieList),
    ],
    verify: (bloc) => verify(mockGetMovieRecommendations.execute(testId)),
  );

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'should emits MovieRecommendationsLoading state and then MovieRecommendationsError state when data is failed fetched..',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnMovieRecommendationsCalled(testId)),
    expect: () => <MovieRecommendationsState>[
      MovieRecommendationsLoading(),
      MovieRecommendationsError('Server Failure'),
    ],
    verify: (bloc) => MovieRecommendationsLoading(),
  );

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'should emits MovieRecommendationsLoading state and then MovieRecommendationsEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnMovieRecommendationsCalled(testId)),
    expect: () => <MovieRecommendationsState>[
      MovieRecommendationsLoading(),
      MovieRecommendationsEmpty(),
    ],
  );
}

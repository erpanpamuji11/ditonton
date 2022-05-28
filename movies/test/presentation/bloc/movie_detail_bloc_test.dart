import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecase/get_movie_detail.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc movieDetailBloc;

  const testId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });
  test('the MovieDetailBloc initial state should be empty', () {
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'should emits MovieDetailLoading state and then MovieDetailHasData state when data is successfully fetched.',
      build: () {
        when(mockGetMovieDetail.execute(testId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnMovieDetailCalled(testId)),
      expect: () => <MovieDetailState>[
            MovieDetailLoading(),
            MovieDetailHasData(testMovieDetail),
          ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(testId));
        return OnMovieDetailCalled(testId).props;
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'should emits MovieDetailLoading state and MovieDetailError when data is failed to fetch.',
    build: () {
      when(mockGetMovieDetail.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnMovieDetailCalled(testId)),
    expect: () => <MovieDetailState>[
      MovieDetailLoading(),
      MovieDetailError('Server Failure'),
    ],
    verify: (bloc) => MovieDetailLoading(),
  );
}

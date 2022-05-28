import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_tvseries_recommendations.dart';
import 'package:tv_series/presentation/bloc/tvseries_recommendations/tvseries_recommendations_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'tvseries_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late MockGetTvSeriesRecommendations mockGetTvseriesRecommendations;
  late TvseriesRecommendationsBloc tvseriesRecommendationsBloc;

  const testId = 1;

  setUp(() {
    mockGetTvseriesRecommendations = MockGetTvSeriesRecommendations();
    tvseriesRecommendationsBloc =
        TvseriesRecommendationsBloc(mockGetTvseriesRecommendations);
  });

  test('the TvseriesRecommendationsEmpty initial state should be empty ', () {
    expect(tvseriesRecommendationsBloc.state, TvseriesRecommendationsEmpty());
  });

  blocTest<TvseriesRecommendationsBloc, TvseriesRecommendationsState>(
    'should emits PopularTvseriesLoading state and then PopularTvseriesHasData state when data is successfully fetched..',
    build: () {
      when(mockGetTvseriesRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testTvList));
      return tvseriesRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnTvseriesRecommendationsCalled(testId)),
    expect: () => <TvseriesRecommendationsState>[
      TvseriesRecommendationsLoading(),
      TvseriesRecommendationsHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetTvseriesRecommendations.execute(testId)),
  );

  blocTest<TvseriesRecommendationsBloc, TvseriesRecommendationsState>(
    'should emits TvseriesRecommendationsLoading state and then TvseriesRecommendationsError state when data is failed fetched..',
    build: () {
      when(mockGetTvseriesRecommendations.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvseriesRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnTvseriesRecommendationsCalled(testId)),
    expect: () => <TvseriesRecommendationsState>[
      TvseriesRecommendationsLoading(),
      TvseriesRecommendationsError('Server Failure'),
    ],
    verify: (bloc) => TvseriesRecommendationsLoading(),
  );

  blocTest<TvseriesRecommendationsBloc, TvseriesRecommendationsState>(
    'should emits TvseriesRecommendationsLoading state and then TvseriesRecommendationsEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetTvseriesRecommendations.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return tvseriesRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnTvseriesRecommendationsCalled(testId)),
    expect: () => <TvseriesRecommendationsState>[
      TvseriesRecommendationsLoading(),
      TvseriesRecommendationsEmpty(),
    ],
  );
}

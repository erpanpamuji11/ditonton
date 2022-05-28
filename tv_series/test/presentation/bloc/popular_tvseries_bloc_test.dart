import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_popular_tvseries.dart';
import 'package:tv_series/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvseries;
  late PopularTvseriesBloc popularTvseriesBloc;

  setUp(() {
    mockGetPopularTvseries = MockGetPopularTvSeries();
    popularTvseriesBloc = PopularTvseriesBloc(mockGetPopularTvseries);
  });

  test('the PopularTvseriesEmpty initial state should be empty ', () {
    expect(popularTvseriesBloc.state, PopularTvseriesEmpty());
  });

  blocTest<PopularTvseriesBloc, PopularTvseriesState>(
    'should emits PopularTvseriesLoading state and then PopularTvseriesHasData state when data is successfully fetched..',
    build: () {
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularTvseriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvseriesCalled()),
    expect: () => <PopularTvseriesState>[
      PopularTvseriesLoading(),
      PopularTvseriesHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetPopularTvseries.execute()),
  );

  blocTest<PopularTvseriesBloc, PopularTvseriesState>(
    'should emits PopularTvseriesLoading state and then PopularTvseriesError state when data is failed fetched..',
    build: () {
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTvseriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvseriesCalled()),
    expect: () => <PopularTvseriesState>[
      PopularTvseriesLoading(),
      PopularTvseriesError('Server Failure'),
    ],
    verify: (bloc) => PopularTvseriesLoading(),
  );

  blocTest<PopularTvseriesBloc, PopularTvseriesState>(
    'should emits PopularTvseriesLoading state and then PopularTvseriesEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => const Right([]));
      return popularTvseriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvseriesCalled()),
    expect: () => <PopularTvseriesState>[
      PopularTvseriesLoading(),
      PopularTvseriesEmpty(),
    ],
  );
}

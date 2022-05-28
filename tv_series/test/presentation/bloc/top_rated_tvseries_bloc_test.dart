import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_top_rated_tvseries.dart';
import 'package:tv_series/presentation/bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvseries;
  late TopRatedTvseriesBloc topRatedTvseriesBloc;

  setUp(() {
    mockGetTopRatedTvseries = MockGetTopRatedTvSeries();
    topRatedTvseriesBloc = TopRatedTvseriesBloc(mockGetTopRatedTvseries);
  });

  test('the TopRatedTvseriesEmpty initial state should be empty ', () {
    expect(topRatedTvseriesBloc.state, TopRatedTvseriesEmpty());
  });

  blocTest<TopRatedTvseriesBloc, TopRatedTvseriesState>(
    'should emits PopularTvseriesLoading state and then PopularTvseriesHasData state when data is successfully fetched..',
    build: () {
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => Right(testTvList));
      return topRatedTvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvseriesCalled()),
    expect: () => <TopRatedTvseriesState>[
      TopRatedTvseriesLoading(),
      TopRatedTvseriesHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetTopRatedTvseries.execute()),
  );

  blocTest<TopRatedTvseriesBloc, TopRatedTvseriesState>(
    'should emits TopRatedTvseriesLoading state and then TopRatedTvseriesError state when data is failed fetched..',
    build: () {
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvseriesCalled()),
    expect: () => <TopRatedTvseriesState>[
      TopRatedTvseriesLoading(),
      TopRatedTvseriesError('Server Failure'),
    ],
    verify: (bloc) => TopRatedTvseriesLoading(),
  );

  blocTest<TopRatedTvseriesBloc, TopRatedTvseriesState>(
    'should emits TopRatedTvseriesLoading state and then TopRatedTvseriesEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => const Right([]));
      return topRatedTvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvseriesCalled()),
    expect: () => <TopRatedTvseriesState>[
      TopRatedTvseriesLoading(),
      TopRatedTvseriesEmpty(),
    ],
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_tvseries_detail.dart';
import 'package:tv_series/presentation/bloc/detail_tvseries/tvseries_detail_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'tvseries_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late MockGetTvSeriesDetail mockGetTvseriesDetail;
  late TvseriesDetailBloc tvseriesDetailBloc;

  const testId = 1;

  setUp(() {
    mockGetTvseriesDetail = MockGetTvSeriesDetail();
    tvseriesDetailBloc = TvseriesDetailBloc(mockGetTvseriesDetail);
  });
  test('the TvseriesDetailBloc initial state should be empty', () {
    expect(tvseriesDetailBloc.state, TvseriesDetailEmpty());
  });

  blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'should emits TvseriesDetailLoading state and then TvseriesDetailHasData state when data is successfully fetched.',
      build: () {
        when(mockGetTvseriesDetail.execute(testId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return tvseriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnTvseriesDetailCalled(testId)),
      expect: () => <TvseriesDetailState>[
            TvseriesDetailLoading(),
            TvseriesDetailHasData(testTvSeriesDetail),
          ],
      verify: (bloc) {
        verify(mockGetTvseriesDetail.execute(testId));
        return OnTvseriesDetailCalled(testId).props;
      });

  blocTest<TvseriesDetailBloc, TvseriesDetailState>(
    'should emits TvseriesDetailLoading state and TvseriesDetailError when data is failed to fetch.',
    build: () {
      when(mockGetTvseriesDetail.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvseriesDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvseriesDetailCalled(testId)),
    expect: () => <TvseriesDetailState>[
      TvseriesDetailLoading(),
      TvseriesDetailError('Server Failure'),
    ],
    verify: (bloc) => TvseriesDetailLoading(),
  );
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecase/tvseries/remove_tvseries_watchlist.dart';

import '../../dummy_data/dummy_objects_tvseries.dart';
import '../../helpers/test_helper.mocks.dart';


void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should remove watchlist TvSeries from repository', () async {
    // arrange
    when(mockTvSeriesRepository.removeWatchlistTvSeries(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.removeWatchlistTvSeries(testTvSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}

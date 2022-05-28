import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/database_helper_tvseries.dart';
import 'package:core/data/datasources/movies/movie_local_data_source.dart';
import 'package:core/data/datasources/movies/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_series/tvseries_local_data_source.dart';
import 'package:core/data/datasources/tv_series/tvseries_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:tv_series/domain/repositories/tvseries_repository.dart';

@GenerateMocks([
  MovieRepository,
  TvSeriesRepository,
  MovieRemoteDataSource,
  TvSeriesRemoteDataSource,
  MovieLocalDataSource,
  TvSeriesLocalDataSource,
  DatabaseHelper,
  DatabaseHelperTvSeries
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}

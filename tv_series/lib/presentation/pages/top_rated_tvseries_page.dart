import 'package:core/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-TvSeries';

  const TopRatedTvSeriesPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TopRatedTvseriesBloc>().add(OnTopRatedTvseriesCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvseriesBloc, TopRatedTvseriesState>(
          builder: (context, state) {
            if (state is TopRatedTvseriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvseriesHasData) {
              final tvseries = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = tvseries[index];
                  return TvSeriesCard(tv);
                },
                itemCount: tvseries.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as TopRatedTvseriesError).message),
              );
            }
          }),
        )
      );
  }
}

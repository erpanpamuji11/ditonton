import 'package:core/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvseries';

  const PopularTvSeriesPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularTvseriesBloc>().add(OnPopularTvseriesCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvseriesBloc, PopularTvseriesState>(
          builder: (context, state) {
            if (state is PopularTvseriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvseriesHasData) {
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
                child: Text((state as PopularTvseriesError).message),
              );
            }
          }),
        )
      );
  }
}

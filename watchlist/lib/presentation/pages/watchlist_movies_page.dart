import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistMoviesBloc>().add(OnWatchlistMoviesCalled()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(OnWatchlistMoviesCalled());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
          builder: (context, state) {
            if (state is WatchlistMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMoviesHasData) {
              final watchlistMovies = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = watchlistMovies[index];
                  return MovieCard(movie);
                },
                itemCount: watchlistMovies.length,
              );
            } else if (state is WatchlistMoviesEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "You don't have whistlist of movies yet, you can add from list movie",
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, HomePage.ROUTE_NAME, (route) => false,
                      ),
                      child: const Text('Add Watchlist'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed to fetch data'),
              );
            }
          }),
        );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

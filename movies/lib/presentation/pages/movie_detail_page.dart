import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/format_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/domain/entities/movies/movie_detail.dart';
import 'package:watchlist/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import '../bloc/movie_detail/movie_detail_bloc.dart';
import '../bloc/movie_recommendations/movie_recommendations_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/movie-detail';
  final int id;
  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(OnMovieDetailCalled(widget.id));
      context
          .read<MovieRecommendationsBloc>()
          .add(OnMovieRecommendationsCalled(widget.id));
      context.read<WatchlistMoviesBloc>().add(FetchWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMovieAddedToWatchlist =
        context.select<WatchlistMoviesBloc, bool>((bloc) {
      if (bloc.state is WatchlistMoviesIsAdded) {
        return (bloc.state as WatchlistMoviesIsAdded).isAdded;
      }
      return false;
    });

    return Scaffold(
      key: const Key('movie_detail_content'),
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            final movie = state.result;
            return SafeArea(
              child: DetailContentMovies(
                movie,
                isMovieAddedToWatchlist,
              ),
            );
          } else {
            return const Text('Failed to fetch data');
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailContentMovies extends StatefulWidget {
  final MovieDetail movie;
  late bool isAddedWatchlist;

  DetailContentMovies(this.movie, this.isAddedWatchlist, {Key? key})
      : super(key: key);

  @override
  State<DetailContentMovies> createState() => _DetailContentMoviesState();
}

class _DetailContentMoviesState extends State<DetailContentMovies> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  context.read<WatchlistMoviesBloc>().add(
                                      AddMovieToWatchlist(widget.movie));
                                } else {
                                  context.read<WatchlistMoviesBloc>().add(
                                      RemoveMovieFromWatchlist(
                                          widget.movie));
                                }

                                String message = "";
                                const watchlistAddSuccessMessage =
                                    'Added to Watchlist';
                                const watchlistRemoveSuccessMessage =
                                    'Removed from Watchlist';

                                final state =
                                    BlocProvider.of<WatchlistMoviesBloc>(
                                        context)
                                        .state;

                                if (state is WatchlistMoviesIsAdded) {
                                  final isAdded = state.isAdded;
                                  message = isAdded == false
                                      ? watchlistAddSuccessMessage
                                      : watchlistRemoveSuccessMessage;
                                } else {
                                  message = !widget.isAddedWatchlist
                                      ? watchlistAddSuccessMessage
                                      : watchlistRemoveSuccessMessage;
                                }
                                if (message == watchlistAddSuccessMessage ||
                                    message == watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      content: Text(message),
                                      duration: const Duration(
                                        milliseconds: 1000,
                                      )));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                                setState(() {
                                  widget.isAddedWatchlist =
                                  !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              showFormatGenres(widget.movie.genres),
                            ),
                            Text(
                              showFormatDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieRecommendationsBloc,
                                MovieRecommendationsState>(
                              builder: (context, state) {
                                if (state is MovieRecommendationsLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MovieRecommendationsError) {
                                  return Text(state.message);
                                } else if (state
                                    is MovieRecommendationsHasData) {
                                  final recommendations = state.result;
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else if (state is MovieRecommendationsEmpty) {
                                  return const Center(
                                    child: Text(
                                      'Recommendation is not available',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}

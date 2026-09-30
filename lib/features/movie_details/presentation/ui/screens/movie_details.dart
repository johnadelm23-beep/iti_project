import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_training/core/di/service_locator.dart';
import 'package:iti_training/core/theme/app_colors.dart';
import 'package:iti_training/features/movie_details/presentation/cubit/cubit/movie_details_cubit.dart';
import 'package:iti_training/features/movie_details/presentation/ui/widgets/info_item.dart';
import 'package:iti_training/features/wishlist/data/models/wish_list_model.dart';
import 'package:iti_training/features/wishlist/presentation/cubit/cubit/wish_list_cubit.dart';
import 'package:iti_training/features/wishlist/presentation/cubit/cubit/wish_list_state.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<MovieDetailsCubit>()
            ..getMovieDetails(movieId),
        ),
        BlocProvider(
          create: (_) => getIt<WishlistCubit>()..loadWishlist(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            if (state is MovieDetailsError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              );
            }

            if (state is MovieDetailsSuccess) {
              final movie = state.movie;

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300.h,
                    pinned: true,
                    backgroundColor:
                        AppColors.scaffoldBackground,
                    iconTheme: IconThemeData(
                      color: Colors.white,
                      size: 26.sp,
                    ),
                    actions: [
                      BlocBuilder<WishlistCubit, WishlistState>(
                        builder: (context, wishlistState) {
                          final wishlistCubit =
                              context.read<WishlistCubit>();

                          final isInWishlist =
                              wishlistCubit.isMovieInWishlist(
                            movie.id,
                          );

                          final isLoading =
                              wishlistState
                                  is WishlistActionLoading;

                          return Padding(
                            padding: EdgeInsets.only(
                              right: 12.w,
                            ),
                            child: Material(
                              color: Colors.black.withValues(
                                alpha: 0.45,
                              ),
                              shape: const CircleBorder(),
                              child: InkWell(
                                customBorder:
                                    const CircleBorder(),
                                onTap: isLoading
                                    ? null
                                    : () {
                                        wishlistCubit.toggleMovie(
                                          WishlistMovieModel(
                                            id: movie.id,
                                            title: movie.title,
                                            posterUrl:
                                                movie.posterUrl,
                                            rating: movie.rating,
                                          ),
                                        );
                                      },
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(9.r),
                                  child: isLoading
                                      ? SizedBox(
                                          width: 20.w,
                                          height: 20.h,
                                          child:
                                              CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Icon(
                                          isInWishlist
                                              ? Icons
                                                  .bookmark_rounded
                                              : Icons
                                                  .bookmark_border_rounded,
                                          size: 23.sp,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          movie.backdropUrl.isNotEmpty
                              ? Image.network(
                                  movie.backdropUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) {
                                    return Container(
                                      color: AppColors.surface,
                                    );
                                  },
                                )
                              : Container(
                                  color: AppColors.surface,
                                ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  AppColors.scaffoldBackground,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h),
                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(12.r),
                                child: movie.posterUrl.isNotEmpty
                                    ? Image.network(
                                        movie.posterUrl,
                                        width: 120.w,
                                        height: 180.h,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (_, __, ___) {
                                          return Container(
                                            width: 120.w,
                                            height: 180.h,
                                            color:
                                                AppColors.surface,
                                            child: Icon(
                                              Icons
                                                  .movie_outlined,
                                              size: 40.sp,
                                              color: AppColors
                                                  .textPrimary,
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        width: 120.w,
                                        height: 180.h,
                                        color: AppColors.surface,
                                        child: Icon(
                                          Icons.movie_outlined,
                                          size: 40.sp,
                                          color: AppColors
                                              .textPrimary,
                                        ),
                                      ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: SizedBox(
                                  height: 180.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        movie.title,
                                        maxLines: 3,
                                        overflow:
                                            TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight:
                                              FontWeight.bold,
                                          color: AppColors
                                              .textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_rounded,
                                            color: Colors.amber,
                                            size: 20.sp,
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            movie.rating
                                                .toStringAsFixed(1),
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight:
                                                  FontWeight.w600,
                                              color: AppColors
                                                  .textPrimary,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            '(${movie.voteCount})',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors
                                                  .textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        movie.releaseDate
                                                .isNotEmpty
                                            ? movie.releaseDate
                                            : 'Unknown',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: AppColors
                                              .textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          if (movie.genres.isNotEmpty) ...[
                            SizedBox(
                              height: 36.h,
                              child: ListView.separated(
                                scrollDirection:
                                    Axis.horizontal,
                                itemCount:
                                    movie.genres.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(width: 8.w),
                                itemBuilder:
                                    (context, index) {
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(
                                      horizontal: 14.w,
                                      vertical: 7.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(
                                        20.r,
                                      ),
                                      border: Border.all(
                                        color:
                                            AppColors.primary,
                                      ),
                                    ),
                                    child: Text(
                                      movie.genres[index],
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color:
                                            AppColors.primary,
                                        fontWeight:
                                            FontWeight.w500,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 24.h),
                          ],
                          if (movie.tagline.isNotEmpty) ...[
                            Text(
                              movie.tagline,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontStyle: FontStyle.italic,
                                color:
                                    AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 18.h),
                          ],
                          Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            movie.overview.isNotEmpty
                                ? movie.overview
                                : 'No overview available.',
                            style: TextStyle(
                              fontSize: 14.sp,
                              height: 1.6,
                              color:
                                  AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              Expanded(
                                child: InfoItem(
                                  icon:
                                      Icons.timer_outlined,
                                  title: 'Runtime',
                                  value: movie.runtime > 0
                                      ? '${movie.runtime} min'
                                      : 'Unknown',
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: InfoItem(
                                  icon:
                                      Icons.info_outline,
                                  title: 'Status',
                                  value:
                                      movie.status.isNotEmpty
                                          ? movie.status
                                          : 'Unknown',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}


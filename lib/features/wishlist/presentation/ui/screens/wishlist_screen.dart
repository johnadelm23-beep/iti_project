import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_training/core/di/service_locator.dart';
import 'package:iti_training/core/theme/app_colors.dart';
import 'package:iti_training/features/movie_details/presentation/ui/screens/movie_details.dart';
import 'package:iti_training/features/wishlist/presentation/cubit/cubit/wish_list_cubit.dart';
import 'package:iti_training/features/wishlist/presentation/cubit/cubit/wish_list_state.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WishlistCubit>()..loadWishlist(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 0,
          title: Text(
            'Wishlist',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            if (state is WishlistError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            }

            final movies = state is WishlistLoaded
                ? state.movies
                : state is WishlistActionLoading
                    ? state.movies
                    : [];

            if (movies.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_border_rounded,
                        size: 70.sp,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Your Wishlist is empty',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Add movies you want to watch later.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.fromLTRB(
                16.w,
                16.h,
                16.w,
                24.h,
              ),
              itemCount: movies.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14.w,
                mainAxisSpacing: 18.h,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                final movie = movies[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailsScreen(
                          movieId: movie.id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBackground,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: 0.08,
                          ),
                          blurRadius: 10.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  movie.posterUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) {
                                    return Container(
                                      color: AppColors.surface,
                                      child: Icon(
                                        Icons.movie_outlined,
                                        size: 45.sp,
                                        color: AppColors
                                            .textPrimary,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                top: 8.h,
                                right: 8.w,
                                child: Material(
                                  color: Colors.black.withValues(
                                    alpha: 0.55,
                                  ),
                                  shape: const CircleBorder(),
                                  child: InkWell(
                                    customBorder:
                                        const CircleBorder(),
                                    onTap: () {
                                      context
                                          .read<WishlistCubit>()
                                          .removeMovie(movie.id);
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(8.r),
                                      child: Icon(
                                        Icons.bookmark_rounded,
                                        size: 20.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    size: 18.sp,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    movie.rating
                                        .toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight:
                                          FontWeight.w600,
                                      color: AppColors
                                          .textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
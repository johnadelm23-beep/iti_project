import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_training/core/di/service_locator.dart';
import 'package:iti_training/core/theme/app_colors.dart';
import 'package:iti_training/core/widgets/custom_text_form_field.dart';
import 'package:iti_training/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:iti_training/features/home/presentation/cubit/cubit/home_state.dart';
import 'package:iti_training/features/home/presentation/ui/widgets/movie_section.dart';
import 'package:iti_training/features/home/presentation/ui/widgets/serach_greid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  Timer? _debounce;

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(
    String query,
    HomeCubit cubit,
  ) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      cubit.getHomeMovies();
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        cubit.searchMovies(query);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userName = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!
        : 'User';

    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..getHomeMovies(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Welcome $userName',
            style: TextStyle(
              fontSize: 25.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    16.w,
                    16.h,
                    16.w,
                    8.h,
                  ),
                  child: CustomTextFormField(
                    controllerl: _searchController,
                    hintText: 'Search movie..',
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textPrimary,
                    ),
                    onChanged: (value) {
                      _onSearchChanged(value, cubit);
                    },
                  ),
                ),
                Expanded(
                  child: _buildContent(state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(HomeState state) {
    if (state is HomeLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }

    if (state is HomeSearchLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }

    if (state is HomeSearchError) {
      return Center(
        child: Text(
          state.message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15.sp,
          ),
        ),
      );
    }

    if (state is HomeSearchSuccess) {
      if (state.movies.isEmpty) {
        return Center(
          child: Text(
            'No movies found',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16.sp,
            ),
          ),
        );
      }

      return SearchMovieGrid(
        movies: state.movies,
      );
    }

    if (state is HomeError) {
      return Center(
        child: Text(
          state.message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15.sp,
          ),
        ),
      );
    }

    if (state is HomeSuccess) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieSection(
              title: 'Popular Movies',
              movies: state.popularMovies,
            ),
            SizedBox(height: 28.h),
            MovieSection(
              title: 'Top Rated',
              movies: state.topRatedMovies,
            ),
            SizedBox(height: 28.h),
            MovieSection(
              title: 'Now Playing',
              movies: state.nowPlayingMovies,
            ),
            SizedBox(height: 28.h),
            MovieSection(
              title: 'Upcoming',
              movies: state.upcomingMovies,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_training/core/theme/app_colors.dart';
import 'package:iti_training/core/widgets/custom_text_form_field.dart';
import 'package:iti_training/features/home/presentation/ui/widgets/custom_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!
        : 'User';

    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore Movies',
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Discover trending cinematic masterworks & box office hits',
              style: TextStyle(
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              controllerl: _searchController,
              hintText: 'Search movie..',
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: MoviesGridView(),
            ),
          ],
        ),
      ),
    );
  }
}
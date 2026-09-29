import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_training/core/routes/app_routes.dart';
import 'package:iti_training/core/theme/app_colors.dart';
import 'package:iti_training/core/widgets/custom_app_button.dart.dart';
import 'package:iti_training/core/widgets/custom_text_form_field.dart';
import 'package:iti_training/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:iti_training/features/auth/presentation/cubit/cubit/auth_state.dart';
import 'package:iti_training/features/auth/presentation/ui/widgets/custom_text_rich.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Please enter your name';
    }

    if (name.length < 3) {
      return 'Name must be at least 3 characters';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain an uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain a lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain a number';
    }

    return null;
  }

  String? _validateConfirmationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  void _register() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16.w),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          backgroundColor: Colors.red.shade700,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          content: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 22.r,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
        }

        if (state is AuthError) {
          _showErrorSnackBar(state.message);
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.surface,
                body: SafeArea(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 24.h,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Text(
                            'Create your account!',
                            style: TextStyle(
                              fontSize: 30.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Create an account to get started.',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          CustomTextFormField(
                            controllerl: _nameController,
                            validator: _validateName,
                            hintText: 'Name',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              size: 22.r,
                            ),
                          ),
                          SizedBox(height: 18.h),
                          CustomTextFormField(
                            controllerl: _emailController,
                            validator: _validateEmail,
                            hintText: 'Email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 22.r,
                            ),
                          ),
                          SizedBox(height: 18.h),
                          CustomTextFormField(
                            controllerl: _passwordController,
                            validator: _validatePassword,
                            hintText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 22.r,
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 18.h),
                          CustomTextFormField(
                            controllerl: _confirmationPasswordController,
                            validator: _validateConfirmationPassword,
                            hintText: 'Confirm password',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 22.r,
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 24.h),
                          Center(
                            child: CustomTextRich(
                              onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRoutes.login,
                                        (route) => false,
                                      );
                                    },
                              firstString: 'Have an account? ',
                              secondString: 'Sign In',
                            ),
                          ),
                          SizedBox(height: 28.h),
                          CustomAppButton(
                            text: 'Register',
                            onPressed: isLoading ? null : _register,
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Positioned.fill(
                  child: AbsorbPointer(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.45),
                      child: Center(
                        child: Container(
                          width: 110.w,
                          height: 110.w,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 36.w,
                              height: 36.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
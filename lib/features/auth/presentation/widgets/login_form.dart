import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onLoginPressed;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.onLoginPressed,
    this.isLoading = false,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FieldLabel(text: 'Email ID or Phone Number'),
          SizedBox(height: 5.h),
          _InputField(
            controller: _emailController,
            hint: 'Enter Registered Email or Phone No.',
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 12.h),

          const _FieldLabel(text: 'Password'),
          SizedBox(height: 5.h),
          _InputField(
            controller: _passwordController,
            hint: 'Enter your password',
            obscureText: _obscurePassword,
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _obscurePassword = !_obscurePassword),
              behavior: HitTestBehavior.opaque,
              child: Icon(
                _obscurePassword
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFFBDBDBD),
                size: 14.w,
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF14B200),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF14B200),
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),

          _GradientLoginButton(
            onPressed: widget.onLoginPressed,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF757575),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const _InputField({
    this.controller,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          color: const Color(0xFF1E1E1E),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            fontSize: 16.sp,
            color: const Color(0xFFB5B5B5),
          ),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Align(
                    alignment: Alignment.centerRight,
                    widthFactor: 1.0,
                    child: suffixIcon,
                  ),
                )
              : null,
          suffixIconConstraints: BoxConstraints(
            minWidth: 32.w,
            minHeight: 40.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
          ),
        ),
      ),
    );
  }
}

class _GradientLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const _GradientLoginButton({
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFB5E500), Color(0xFF19B500)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF53C800).withValues(alpha: 0.12),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.2,
                  ),
                )
              : Text(
                  'Login',
                  style: GoogleFonts.inter(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

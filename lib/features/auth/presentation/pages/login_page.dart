import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/shared/widgets/loading_overlay.dart';
import '../../../../core/utils/extensions.dart';
import '../providers/auth_providers.dart';
import '../providers/auth_state.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form.dart';
import '../widgets/login_footer.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    ref.listen(authViewModelProvider, (previous, next) {
      switch (next) {
        case AuthStateAuthenticated():
          context.go('/home');
        case AuthStateError(:final message):
          context.showSnackBar(message, isError: true);
        default:
          break;
      }
    });

    final isLoading = authState is AuthStateLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SafeArea(
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const LoginHeader(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: [
                              SizedBox(height: 14.h),
                              LoginForm(
                                onLoginPressed: () {
                                  context.showSnackBar(
                                    'Please use Continue with Google.',
                                  );
                                },
                                isLoading: isLoading,
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                        Expanded(
                          child: LoginFooter(
                            onGooglePressed: () {
                              ref
                                  .read(authViewModelProvider.notifier)
                                  .signInWithGoogle();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

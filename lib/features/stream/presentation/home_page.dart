import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/shared/widgets/top_app_bar.dart';
import '../../../../core/shared/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../auth/presentation/providers/auth_providers.dart';
import 'providers/stream_providers.dart';
import 'providers/stream_state.dart';
import 'widgets/category_filter_list.dart';
import 'widgets/stream_grid.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentNavIndex = 0;
  int _currentTopTabIndex = 0;
  final List<String> _topTabs = ['Stream', 'Hot', 'Follow'];

  @override
  Widget build(BuildContext context) {
    final streamState = ref.watch(streamViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      // extendBody: true removes the solid white background behind the curved top edges and notch!
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            TopAppBar(
              title: 'Live Streams',
              onSearchTap: () {
                context.showSnackBar('Search live streams');
              },
              onNotificationTap: () {
                _showUserMenu(context);
              },
            ),
            
            // Top Tabs: Stream | Hot | Follow
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: List.generate(_topTabs.length, (index) {
                  final isSelected = _currentTopTabIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _currentTopTabIndex = index),
                    child: Padding(
                      padding: EdgeInsets.only(right: 24.w, bottom: 4.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _topTabs[index],
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? AppColors.primary : const Color(0xFF9E9E9E),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            height: 2.5.h,
                            width: 28.w,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 12.h),
            
            Expanded(
              child: switch (streamState) {
                StreamStateLoading() => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                StreamStateError(:final message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(message, style: const TextStyle(color: AppColors.error)),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () => ref.read(streamViewModelProvider.notifier).loadInitialData(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                StreamStateLoaded(:final categories, :final streams, :final selectedCategoryId) => Column(
                    children: [
                      // ─── Tweak Top Country Chip Dimensions Here! ───
                      CategoryFilterList(
                        categories: categories,
                        selectedCategoryId: selectedCategoryId,
                        chipHeight: 30.0,            // Try 26.0, 28.0, or 30.0! Now it responds instantly!
                        chipHorizontalPadding: 12.0, // Left and right padding inside chip
                        flagWidth: 14.0,             // Country flag width
                        flagHeight: 10.0,            // Country flag height
                        flagSpacing: 6.0,            // Gap between flag and text
                        fontSize: 12.0,              // Country font size
                        onCategorySelected: (id) {
                          ref.read(streamViewModelProvider.notifier).selectCategory(id);
                        },
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: StreamGrid(
                          streams: streams,
                          onToggleFollow: (id) {
                            ref.read(streamViewModelProvider.notifier).toggleFollow(id);
                          },
                          onCardTap: (stream) {
                            context.showSnackBar('Joining ${stream.streamerName}\'s live stream!');
                          },
                        ),
                      ),
                    ],
                  ),
                _ => const SizedBox.shrink(),
              },
            ),
          ],
        ),
      ),
      // Here you can manually control the gap and curve depth around the Go Live button!
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentNavIndex,
        // Tweak these values anytime to control the notch curve and gap:
        notchRadius: 34.0,      // Increase this to make the gap around the circular button wider
        notchDepth: 36.0,       // Increase or decrease this to control how deep the curve dips
        notchSmoothness: 22.0,  // Controls the slope smoothness entering the notch
        onTap: (index) {
          setState(() => _currentNavIndex = index);
          if (index == 4) {
            _showUserMenu(context);
          }
        },
      ),
    );
  }

  void _showUserMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'User Settings & Account',
              style: GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 20.h),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: Text('Sign Out', style: GoogleFonts.inter(color: AppColors.error, fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(ctx);
                ref.read(authViewModelProvider.notifier).signOut();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}

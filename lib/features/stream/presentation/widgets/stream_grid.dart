import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/shared/widgets/live_stream_card.dart';
import '../../domain/entities/stream_entity.dart';

class StreamGrid extends StatelessWidget {
  final List<StreamEntity> streams;
  final ValueChanged<String> onToggleFollow;
  final ValueChanged<StreamEntity> onCardTap;

  const StreamGrid({
    super.key,
    required this.streams,
    required this.onToggleFollow,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    if (streams.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Text(
            'No live streams available in this category.',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 15.sp),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return GridView.builder(
      // Added bottom padding (90.h) so content scrolls completely clear of floating bottom navbar
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h, bottom: 90.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemCount: streams.length,
      itemBuilder: (context, index) {
        final stream = streams[index];
        return LiveStreamCard(
          imageUrl: stream.thumbnailUrl,
          streamerName: stream.streamerName,
          viewerCount: stream.viewerCount > 999
              ? '${(stream.viewerCount / 1000).toStringAsFixed(1)}k'
              : '${stream.viewerCount}',
          countryFlag: stream.countryCode,
          onFollow: () => onToggleFollow(stream.id),
          onTap: () => onCardTap(stream),
        );
      },
    );
  }
}

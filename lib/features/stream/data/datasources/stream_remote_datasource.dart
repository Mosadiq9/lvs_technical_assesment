import '../../../../core/errors/exceptions.dart';
import '../models/stream_model.dart';
import '../models/category_model.dart';

abstract class StreamRemoteDataSource {
  Future<List<StreamModel>> getStreams({String? categoryId});
  Future<List<CategoryModel>> getCategories();
  Future<StreamModel> followStreamer(String streamId);
}

class StreamRemoteDataSourceImpl implements StreamRemoteDataSource {
  final List<CategoryModel> _categories = const [
    CategoryModel(id: 'all', name: 'Global', flagAsset: 'global'),
    CategoryModel(id: 'india', name: 'India', flagAsset: 'in'),
    CategoryModel(id: 'philippines', name: 'Philippines', flagAsset: 'ph'),
    CategoryModel(id: 'brazil', name: 'Brazil', flagAsset: 'br'),
    CategoryModel(id: 'colombia', name: 'Colombia', flagAsset: 'co'),
    CategoryModel(id: 'mexico', name: 'Mexico', flagAsset: 'mx'),
    CategoryModel(id: 'argentina', name: 'Argentina', flagAsset: 'ar'),
  ];

  late final List<StreamModel> _streams = [
    const StreamModel(
      id: '1',
      streamerName: 'Priya K.',
      streamerAvatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
      thumbnailUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=600',
      viewerCount: 3420,
      countryCode: 'in',
      categoryId: 'india',
      isFollowed: false,
    ),
    const StreamModel(
      id: '2',
      streamerName: 'Angelica S.',
      streamerAvatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400',
      thumbnailUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=600',
      viewerCount: 2890,
      countryCode: 'ph',
      categoryId: 'philippines',
      isFollowed: true,
    ),
    const StreamModel(
      id: '3',
      streamerName: 'Camila R.',
      streamerAvatarUrl: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400',
      thumbnailUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=600',
      viewerCount: 1450,
      countryCode: 'br',
      categoryId: 'brazil',
      isFollowed: false,
    ),
    const StreamModel(
      id: '4',
      streamerName: 'Sophia V.',
      streamerAvatarUrl: 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=400',
      thumbnailUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=600',
      viewerCount: 912,
      countryCode: 'co',
      categoryId: 'colombia',
      isFollowed: false,
    ),
    const StreamModel(
      id: '5',
      streamerName: 'Lucia M.',
      streamerAvatarUrl: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=400',
      thumbnailUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=600',
      viewerCount: 2100,
      countryCode: 'mx',
      categoryId: 'mexico',
      isFollowed: true,
    ),
    const StreamModel(
      id: '6',
      streamerName: 'Valeria G.',
      streamerAvatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400',
      thumbnailUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=600',
      viewerCount: 760,
      countryCode: 'ar',
      categoryId: 'argentina',
      isFollowed: false,
    ),
  ];

  @override
  Future<List<StreamModel>> getStreams({String? categoryId}) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate API latency
    if (categoryId != null && categoryId != 'all') {
      return _streams.where((s) => s.categoryId == categoryId).toList();
    }
    return _streams;
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _categories;
  }

  @override
  Future<StreamModel> followStreamer(String streamId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _streams.indexWhere((s) => s.id == streamId);
    if (index == -1) {
      throw ServerException('Stream not found');
    }
    final current = _streams[index];
    final updated = current.copyWith(isFollowed: !current.isFollowed);
    _streams[index] = updated;
    return updated;
  }
}

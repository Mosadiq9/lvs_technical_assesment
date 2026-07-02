import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/stream_model.dart';
import '../models/category_model.dart';

abstract class StreamRemoteDataSource {
  Future<List<StreamModel>> getStreams({String? categoryId});
  Future<List<CategoryModel>> getCategories();
  Future<StreamModel> followStreamer(String streamId);
}

class StreamRemoteDataSourceImpl implements StreamRemoteDataSource {
  final ApiClient? apiClient;

  StreamRemoteDataSourceImpl({this.apiClient});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<StreamModel>> getStreams({String? categoryId}) async {
    try {
      Query query = firestore.collection('streams');
      if (categoryId != null && categoryId != 'all') {
        query = query.where('categoryId', isEqualTo: categoryId);
      }
      final snapshot = await query.get();
      return snapshot.docs.map((doc) => StreamModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch streams: $e');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final snapshot = await firestore.collection('categories').get();
      return snapshot.docs.map((doc) => CategoryModel.fromJson(doc.data())).toList();
    } catch (e) {
      throw ServerException('Failed to fetch categories: $e');
    }
  }

  @override
  Future<StreamModel> followStreamer(String streamId) async {
    try {
      final docRef = firestore.collection('streams').doc(streamId);
      final snapshot = await docRef.get();
      
      if (!snapshot.exists) {
        throw ServerException('Stream not found');
      }

      final data = snapshot.data()!;
      final currentFollowStatus = data['isFollowed'] as bool? ?? false;
      
      await docRef.update({'isFollowed': !currentFollowStatus});
      
      final updatedSnapshot = await docRef.get();
      return StreamModel.fromJson(updatedSnapshot.data()!);
    } catch (e) {
      throw ServerException('Failed to follow streamer: $e');
    }
  }
}

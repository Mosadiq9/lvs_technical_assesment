import 'package:mockito/annotations.dart';
import 'package:alive_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:alive_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:alive_app/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:alive_app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:alive_app/features/auth/domain/usecases/get_current_user_usecase.dart';

import 'package:alive_app/features/stream/data/datasources/stream_remote_datasource.dart';
import 'package:alive_app/features/stream/domain/repositories/stream_repository.dart';
import 'package:alive_app/features/stream/domain/usecases/get_streams_usecase.dart';
import 'package:alive_app/features/stream/domain/usecases/get_categories_usecase.dart';
import 'package:alive_app/features/stream/domain/usecases/follow_streamer_usecase.dart';

@GenerateNiceMocks([
  MockSpec<AuthRemoteDataSource>(),
  MockSpec<AuthRepository>(),
  MockSpec<SignInWithGoogleUseCase>(),
  MockSpec<SignOutUseCase>(),
  MockSpec<GetCurrentUserUseCase>(),
  MockSpec<StreamRemoteDataSource>(),
  MockSpec<StreamRepository>(),
  MockSpec<GetStreamsUseCase>(),
  MockSpec<GetCategoriesUseCase>(),
  MockSpec<FollowStreamerUseCase>(),
])
void main() {}

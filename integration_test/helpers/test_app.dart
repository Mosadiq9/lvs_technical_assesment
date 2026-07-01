import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alive_app/app.dart';
import 'package:alive_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:alive_app/features/stream/presentation/providers/stream_providers.dart';
import 'package:alive_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:alive_app/features/stream/data/datasources/stream_remote_datasource.dart';

import 'fake_auth_datasource.dart';

Widget createTestApp({
  AuthRemoteDataSource? authDataSource,
  StreamRemoteDataSource? streamDataSource,
}) {
  return ProviderScope(
    overrides: [
      authRemoteDataSourceProvider.overrideWithValue(
        authDataSource ?? FakeAuthRemoteDataSource(),
      ),
      streamRemoteDataSourceProvider.overrideWithValue(
        streamDataSource ?? StreamRemoteDataSourceImpl(),
      ),
    ],
    child: const AliveApp(),
  );
}

import 'package:businessmates_admin/core/utils/injectable_module.dart';
import 'package:businessmates_admin/data/datasources/local_datasource.dart';
import 'package:businessmates_admin/data/datasources/remote_datasource.dart';
import 'package:businessmates_admin/domain/repositories/repository.dart';

import '../data/repositories/repository_impl.dart';

final _injector = _Injector();
final repository = _injector.repository;

class _Injector {
  _Injector._internal();
  static final _singleton = _Injector._internal();
  factory _Injector() => _singleton;

  LocalDataSource get localDataSourceImpl =>
      LocalDataSourceImpl(prefs: sharedPreferences);

  RemoteDataSource get remoteDataSourceImpl => RemoteDataSourceImpl(
        firebaseAuth: firebaseAuth,
        firebaseStorage: firebaseStorage,
        firestore: firestore,
        localDataSource: localDataSourceImpl,
      );

  Repository get repository => RepositoryImpl(
        remoteDataSource: remoteDataSourceImpl,
        networkInfo: networkInfo,
      );
}

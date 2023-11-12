import 'package:get_it/get_it.dart';
import 'package:perfect_feed/features/data/data_source/instagram_remote_data_source.dart';
import 'package:perfect_feed/features/data/repositories/instagram_repository.dart';
import 'package:perfect_feed/features/presentation/blocs/main/main_cubit.dart';
import 'package:perfect_feed/features/presentation/blocs/paywall/paywall_cubit.dart';

final GetIt di = GetIt.instance;

Future<void> diInit() async {
  // start register services
  // end register services

  // start register Bloc
  di.registerLazySingleton(() => MainCubit(instagramRepository: di()));
  di.registerLazySingleton(() => PaywallCubit());
  // end register Bloc

  // start remote source
  di.registerSingleton<InstagramRemoteDataSource>(InstagramRemoteDataSource());
  // end remote source

  // start repository
  di.registerFactory<InstagramRepository>(() => InstagramRepository(dataSource: di()));
  // start repository

}
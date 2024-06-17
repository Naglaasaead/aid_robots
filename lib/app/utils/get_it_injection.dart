import 'package:aid_robot/features/auth_feature/domain/usercases/register_user_case.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth_feature/data/data_sourse/auth_remote_data_source.dart';
import '../../features/auth_feature/data/repo_impl/auth_repo_impl.dart';
import '../../features/auth_feature/domain/repo/auth_repo.dart';
import '../network/network_info.dart';
import '../network/network_manager.dart';
import '../services/cache_service.dart';
import 'navigation_helper.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // data sources
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl( getIt()),);
  // getIt.registerLazySingleton<NotificationRemoteDataSource>(() => NotificationRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<EventsRemoteDataSource>(() => EventsRemoteDataSourceImpl(networkManager: getIt()),);

  //* Repository
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl( getIt(), getIt()),);
  // getIt.registerLazySingleton<NotificationRepo>(() => NotificationRepoImpl( networkInfo: getIt(), notificationRemoteDataSource: getIt()),);
  // getIt.registerLazySingleton<EventsRepo>(() => EventsRepoImpl( networkInfo: getIt(), eventsRemoteDataSource: getIt()),);

  //* Use cases
  _authUseCases();
  _accountUseCases();
  _homeUseCase();
  _searchUseCase();
  _notificationsUseCases();
  _eventsUseCases();


  //! ----------- app -----------
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());
  getIt.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
  // getIt.registerLazySingleton<FirebaseNotificationService>(() => FirebaseNotificationService(),);
  // getIt.registerLazySingleton<FlutterLocalNotificationService>(() => FlutterLocalNotificationService(),);
  getIt.registerSingleton<NavHelper>(NavHelper());
  getIt.registerSingleton<CacheService>(CacheService());
}

void _authUseCases() {
   getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(repository: getIt()));
}


void _accountUseCases() {
  //getIt.registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(repository: getIt()));
}

void _homeUseCase(){
  // getIt.registerLazySingleton<GetHomeDataUseCase>(() => GetHomeDataUseCase(repository: getIt()));
}
void _searchUseCase(){
  // getIt.registerLazySingleton<SearchProductsUseCase>(() => SearchProductsUseCase(repository: getIt()));
}

void _notificationsUseCases() {

}

void _eventsUseCases() {
}
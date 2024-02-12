import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/network_info.dart';
import '../network/network_manager.dart';
import '../services/cache_service.dart';
import 'navigation_helper.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // data sources
  // getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<NotificationRemoteDataSource>(() => NotificationRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<EventsRemoteDataSource>(() => EventsRemoteDataSourceImpl(networkManager: getIt()),);

  //* Repository
  // getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(authRemoteDataSource: getIt(), networkInfo: getIt()),);
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
  // getIt.registerLazySingleton<SignInUseCase>(() => SignInUseCase(repository: getIt()));
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
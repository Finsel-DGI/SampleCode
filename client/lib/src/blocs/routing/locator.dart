import 'package:get_it/get_it.dart';
import '../../modules/services/system/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
 locator.registerLazySingleton(() => NavigationService());
}


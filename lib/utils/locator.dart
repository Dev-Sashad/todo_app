import 'package:get_it/get_it.dart';
import 'package:todo_app/core/services/todo_service.dart';
import 'package:todo_app/utils/progressBarManager/dialog_service.dart';

import 'router/navigation_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ProgressService());
  locator.registerLazySingleton(() => TodoServices());
}

import 'package:base/di/bloc_di.dart';
import 'package:base/di/data_source_di.dart';
import 'package:base/di/external_di.dart';
import 'package:base/di/page_di.dart';
import 'package:base/di/repository_di.dart';
import 'package:get_it/get_it.dart';

class DI {
  DI._();

  static Future<void> init() async {
    final injector = GetIt.instance;
    await ExternalDI.config(injector);
    await DataSourceDI.config(injector);
    await RepositoryDI.config(injector);
    await BlocDI.config(injector);
    await PageDI.config(injector);
  }
}

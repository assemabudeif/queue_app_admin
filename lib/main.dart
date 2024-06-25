import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '/core/services/services_locator.dart';

import 'app.dart';
import 'core/localization/language_manger.dart';
import 'core/utilities/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServicesLocator().init();

  Bloc.observer = AppBlocObserver();
  firstTimeForLanguage();

  runApp(Phoenix(child: const QueueAppAdmin()));
}

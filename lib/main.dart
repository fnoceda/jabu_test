import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'app/app.dart';
import 'app/locator.dart';
import 'app/router.dart';

void main() async {
  await initHiveForFlutter();
  await Locator.setUpLocators();
  AppNavigator.configureRoutes();
  EquatableConfig.stringify = kDebugMode;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

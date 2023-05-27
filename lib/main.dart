import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'app.dart';
import 'locator.dart';

void main() async {
  await initHiveForFlutter();
  await Locator.setUpLocators();
  EquatableConfig.stringify = kDebugMode;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

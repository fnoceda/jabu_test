import 'package:fluro/fluro.dart';

import 'router_handler.dart';

class AppNavigator {
  static final FluroRouter router = FluroRouter();
  static void configureRoutes() {
    router.define(
      '/',
      handler: homeHandler,
      transitionType: TransitionType.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    );

    router.define(
      '/detail/:id',
      handler: detailHandler,
      transitionType: TransitionType.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    );

    router.notFoundHandler = pageNotFoundHandler;
  }
}

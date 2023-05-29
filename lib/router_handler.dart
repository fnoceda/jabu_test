import 'package:fluro/fluro.dart';

import 'presentation/pages/detail/detail_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/not_found_page.dart';

final Handler homeHandler = Handler(
  handlerFunc: (context, params) => const HomePage(),
);

final Handler detailHandler = Handler(handlerFunc: (context, params) {
  String? id = params['id']?[0];
  if (id != null) {
    return DetailPage(id: id);
  } else {
    return const NotFoundPage();
  }
});

final Handler pageNotFoundHandler = Handler(
  handlerFunc: (context, params) => const NotFoundPage(),
);

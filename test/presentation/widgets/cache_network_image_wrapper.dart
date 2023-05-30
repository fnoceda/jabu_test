import 'package:flutter/material.dart';
import 'package:jabu_test/presentation/widgets/cache_network_image_wrapper.dart';

class MockCachedNetworkImageWrapper implements CachedNetworkImageWrapper {
  @override
  Widget getImage({required String imgUrl}) {
    return Container();
  }
}

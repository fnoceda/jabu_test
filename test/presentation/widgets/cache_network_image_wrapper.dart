import 'package:flutter/material.dart';
import 'package:jabu_test_bloc/presentation/widgets/cache_network_image_wrapper.dart';

class MockCachedNetworkImageWrapper implements CachedNetworkImageWrapper {
  Widget getImage({required String imgUrl}) {
    return Container();
  }
}

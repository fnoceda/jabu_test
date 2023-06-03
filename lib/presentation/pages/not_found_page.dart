import 'package:flutter/material.dart';

import '../../app/router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: 200,
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  '404',
                  style: TextStyle(fontSize: 100),
                ),
                ElevatedButton(
                  onPressed: () {
                    AppNavigator.router.navigateTo(context, '/');
                  },
                  child: const Text('Go to Home'),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

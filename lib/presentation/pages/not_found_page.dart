import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: double.infinity,
          height: 200,
          child: Column(
            children: [
              // CustomAppMenu(),
              const Spacer(),
              const Text(
                '404',
                style: TextStyle(fontSize: 100),
              ),
              TextButton(
                onPressed: () => print('click'),
                child: const Text('Volver'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

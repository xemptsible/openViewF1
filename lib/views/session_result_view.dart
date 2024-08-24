import 'package:flutter/material.dart';
import 'package:openViewF1/views/components/components.dart';

class SessionResultView extends StatelessWidget {
  const SessionResultView({super.key, this.queryParams});

  final dynamic queryParams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDesign(),
      body: Center(
        child: FilledButton(
          onPressed: () async {
            print(queryParams);
          },
          child: const Text('test data'),
        ),
      ),
    );
  }
}

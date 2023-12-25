import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/presentation/providers/menu_provider.dart';

import '../../data/models/screen_model.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({
    super.key,
    required this.screens,
  });

  final List<ScreenModel> screens;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("SIP PB-16"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            for (var e in screens)
              Padding(
                padding: const EdgeInsets.all(2),
                child: TextButton(
                  onPressed: () {
                    ref.read(menuProvider.notifier).state = screens.indexOf(e);
                  },
                  child: Text(
                    e.title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

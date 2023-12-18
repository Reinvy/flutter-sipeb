import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/presentation/providers/menu_provider.dart';

import '../../models/screen_model.dart';

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
        title: const Text("SIPEB"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var e in screens)
              TextButton(
                onPressed: () {
                  ref.read(menuProvider.notifier).state = screens.indexOf(e);
                },
                child: Text(e.title),
              ),
          ],
        ),
      ),
    );
  }
}

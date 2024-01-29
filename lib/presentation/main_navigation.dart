import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/models/screen_model.dart';
import 'package:sipeb/presentation/providers/menu_provider.dart';
import 'package:sipeb/presentation/screens/dashboard_screen.dart';
import 'package:sipeb/presentation/screens/karyawan_pimpinan_screen.dart';
import 'package:sipeb/presentation/screens/permintaan_screen.dart';

import 'widgets/side_menu.dart';

class MainNavigation extends ConsumerStatefulWidget {
  const MainNavigation({super.key});

  @override
  ConsumerState<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation> {
  List<ScreenModel> screens = [
    ScreenModel(
      title: "Dashboard",
      screen: const DashboardScreen(),
    ),
    ScreenModel(
      title: "Memo Permintaan",
      screen: const PermintaanScreen(),
    ),
    ScreenModel(
      title: "Karyawan Pimpinan",
      screen: const KaryawanPimpinanScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SideMenu(
              screens: screens,
            ),
          ),
          Expanded(
            flex: 5,
            child: screens[ref.watch(menuProvider)].screen,
          ),
        ],
      ),
    );
  }
}

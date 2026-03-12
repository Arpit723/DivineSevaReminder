import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings_screen.dart';
import 'dashboard/upcoming_tab_screen.dart';
import 'dashboard/task_list_content_screen.dart';
import '../models/task_list_type.dart';
import '../presentation/providers/sidebar_provider.dart';
import '../presentation/providers/task_filter_provider.dart';
import '../presentation/widgets/navigation/sidebar_navigation.dart';
import '../presentation/widgets/navigation/mobile_drawer.dart';

class TodoListScreen extends ConsumerStatefulWidget {
  const TodoListScreen({super.key});

  @override
  ConsumerState<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends ConsumerState<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedItem = ref.watch(sidebarSelectionProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    if (isMobile) {
      // Mobile: Standard Scaffold with AppBar and Drawer
      return Scaffold(
        appBar: AppBar(
          title: Text(selectedItem.label),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              tooltip: 'Settings',
            ),
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: MobileDrawer(
          selectedItem: selectedItem,
          onItemSelected: (item) {
            ref.read(taskFilterStateProvider.notifier).clearFilters();
            ref.read(sidebarSelectionProvider.notifier).selectItem(item);
          },
        ),
        body: _buildSelectedView(selectedItem),
      );
    } else {
      debugPrint('🖥️ DESKTOP/TABLET PATH - Building Row with Sidebar');
      // Desktop/Tablet: Sidebar extends from top, content has its own AppBar
      // Get top safe area padding (for status bar/notch)
      final topPadding = MediaQuery.of(context).padding.top;
      final headerHeight = kToolbarHeight + topPadding;

      return Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Start from top
          children: [
            // Sidebar - extends from top of screen
            SidebarNavigation(
              selectedItem: selectedItem,
              onItemSelected: (item) {
                ref.read(taskFilterStateProvider.notifier).clearFilters();
                ref.read(sidebarSelectionProvider.notifier).selectItem(item);
              },
            ),
            // Content area with AppBar
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max, // Fill available height
                children: [
                  // AppBar for content area - shows selected menu item name
                  Container(
                    height: headerHeight,
                    color: const Color(0xFF8B0000),
                    padding: EdgeInsets.only(left: 16, right: 16, top: topPadding),
                    child: Row(
                      children: [
                        Text(
                          selectedItem.label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.settings, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsScreen(),
                              ),
                            );
                          },
                          tooltip: 'Settings',
                        ),
                      ],
                    ),
                  ),
                  // Content
                  Expanded(
                    child: _buildSelectedView(selectedItem),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildSelectedView(SidebarItem item) {
    switch (item) {
      case SidebarItem.upcoming:
        return const UpcomingTabScreen();
      case SidebarItem.today:
        return const TaskListContentScreen(type: TaskListType.today);
      case SidebarItem.all:
        return const TaskListContentScreen(type: TaskListType.all);
      case SidebarItem.completed:
        return const TaskListContentScreen(type: TaskListType.completed);
    }
  }
}

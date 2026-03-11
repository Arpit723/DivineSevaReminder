import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/sidebar_provider.dart';

class MobileDrawer extends ConsumerWidget {
  final SidebarItem selectedItem;
  final ValueChanged<SidebarItem> onItemSelected;

  const MobileDrawer({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get top safe area padding (for status bar/notch)
    final topPadding = MediaQuery.of(context).padding.top;
    final headerHeight = kToolbarHeight + topPadding;

    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // RED HEADER - Matches AppBar height with safe area
          Container(
            height: headerHeight,
            color: const Color(0xFF8B0000),
            padding: EdgeInsets.only(top: topPadding),
            alignment: Alignment.center,
            child: Text(
              "Seva List",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          // MENU ITEMS
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 8),
                ...SidebarItem.values.map((item) => _buildMenuItem(context, item)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, SidebarItem item) {
    final isSelected = selectedItem == item;

    return ListTile(
      leading: Icon(item.icon, color: isSelected ? const Color(0xFF8B0000) : Colors.grey),
      title: Text(
        item.label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF8B0000) : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: const Color(0xFF8B0000).withValues(alpha: 0.1),
      onTap: () {
        onItemSelected(item);
        Navigator.pop(context); // Close drawer
      },
    );
  }
}
//TODO: Test to do list

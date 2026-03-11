import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/sidebar_provider.dart';

class SidebarNavigation extends ConsumerWidget {
  final SidebarItem selectedItem;
  final ValueChanged<SidebarItem> onItemSelected;

  const SidebarNavigation({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get top safe area padding (for status bar/notch)
    final topPadding = MediaQuery.of(context).padding.top;
    final headerHeight = kToolbarHeight + topPadding;

    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.shade300),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // RED HEADER - Matches AppBar height with safe area
          Container(
            height: headerHeight,
            color: const Color(0xFF8B0000),
            padding: EdgeInsets.only(top: topPadding),
            alignment: Alignment.center,
            child: Icon(
              Icons.menu,
              color: Colors.white.withValues(alpha: 0.7),
              size: 24,
            ),
          ),
          // MENU ITEMS
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: false,
              children: [
                const SizedBox(height: 8),
                ...SidebarItem.values.map((item) => _buildMenuItem(item)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(SidebarItem item) {
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
      selectedTileColor: const Color(0xFF8B0000).withOpacity(0.1),
      onTap: () => onItemSelected(item),
    );
  }
}

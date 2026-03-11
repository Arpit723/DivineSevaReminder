import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sidebar_provider.g.dart';

enum SidebarItem {
  upcoming('Upcoming', Icons.calendar_month),
  today('Today', Icons.today),
  all('All', Icons.list),
  completed('Completed', Icons.check_circle);

  final String label;
  final IconData icon;

  const SidebarItem(this.label, this.icon);
}

@riverpod
class SidebarSelection extends _$SidebarSelection {
  @override
  SidebarItem build() {
    return SidebarItem.today; // Default to Today
  }

  void selectItem(SidebarItem item) {
    state = item;
  }
}

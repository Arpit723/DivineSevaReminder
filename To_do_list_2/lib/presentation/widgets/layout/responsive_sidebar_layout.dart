import 'package:flutter/material.dart';

class ResponsiveSidebarLayout extends StatelessWidget {
  final Widget sidebar;
  final Widget body;

  const ResponsiveSidebarLayout({
    super.key,
    required this.sidebar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const sidebarBreakpoint = 600.0;

    if (width >= sidebarBreakpoint) {
      // Desktop/Tablet: Sidebar extends from top, content has its own AppBar
      return LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sidebar,
                Expanded(
                  child: body,
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Mobile: Body only (drawer is separate)
      return body;
    }
  }
}

import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: colors.surfaceContainerLow,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'TACTICAL SENTINEL',
                style: textTheme.titleMedium?.copyWith(
                  letterSpacing: 1.05,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
            ),
            // Tonal shift separation rather than a line
            Container(height: 16, color: colors.surface),
            Expanded(
              child: Container(
                color: colors.surface,
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  children: const [
                    _DrawerItem(
                      icon: Icons.map_outlined,
                      title: 'FIELD MAP',
                      isActive: true,
                    ),
                    SizedBox(height: 8),
                    _DrawerItem(
                      icon: Icons.analytics_outlined,
                      title: 'STATISTICS',
                      isActive: false,
                    ),
                    SizedBox(height: 8),
                    _DrawerItem(
                      icon: Icons.settings_outlined,
                      title: 'OPERATIONAL SETTINGS',
                      isActive: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: isActive ? colors.surfaceContainerHigh : Colors.transparent,
        borderRadius: BorderRadius.circular(4), // ROUND_FOUR
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            if (isActive)
              Container(
                width: 4,
                color: colors.secondaryContainer,
              )
            else
              const SizedBox(width: 4),
            Expanded(
              child: ListTile(
                leading: Icon(
                  icon,
                  color: isActive ? colors.primary : colors.onSurfaceVariant,
                ),
                title: Text(
                  title,
                  style: textTheme.labelMedium?.copyWith(
                    letterSpacing: 1.05,
                    color: isActive ? colors.onSurface : colors.onSurfaceVariant,
                  ),
                ),
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                dense: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

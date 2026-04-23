import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/theme/app_theme_tokens.dart';
import 'package:mds/l10n/app_localizations.dart';
import 'map_type_button.dart';
import 'package:mds/controllers/map_selection_controller/map_selection_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppThemeTokens.roundEight),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            child: Container(
              color: colors.surfaceContainerHighest.withValues(alpha: 0.6),
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 6.0,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: colors.onSurface),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.searchHint,
                        isDense: true,
                        filled: true,
                        fillColor: colors.surfaceContainerLowest,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 10.0,
                        ),
                        suffixIcon: ListenableBuilder(
                          listenable: _searchController,
                          builder: (context, _) {
                            return _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear, size: 18),
                                    onPressed: () {
                                      _searchController.clear();
                                    },
                                  )
                                : Icon(
                                    Icons.search,
                                    size: 18,
                                    color: colors.onSurfaceVariant,
                                  );
                          },
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            AppThemeTokens.roundFour,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(
                            AppThemeTokens.roundFour,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colors.tertiary.withValues(alpha: 0.5),
                          ),
                          borderRadius: BorderRadius.circular(
                            AppThemeTokens.roundFour,
                          ),
                        ),
                      ),
                      onSubmitted: (value) {
                        context.read<MapSelectionCubit>().searchLocation(value);
                      },
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const MapTypeButton(),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

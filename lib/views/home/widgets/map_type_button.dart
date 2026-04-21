import 'package:flutter/material.dart';
import 'package:mds/views/home/widgets/map_type_selection_sheet.dart';

class MapTypeButton extends StatelessWidget {
  const MapTypeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return IconButton(
      icon: Icon(Icons.layers_outlined, color: colors.onSurface),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => const MapTypeSelectionSheet(),
        );
      },
    );
  }
}

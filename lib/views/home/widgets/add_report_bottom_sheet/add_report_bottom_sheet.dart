import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../controllers/report_controller/report_cubit.dart';
import '../../../../controllers/map_selection_controller/map_selection_cubit.dart';
import '../../../../controllers/map_selection_controller/map_selection_state.dart';
import 'package:mds/l10n/app_localizations.dart';
import 'add_report_bottom_sheet_content.dart';
import 'add_report_image_preview_dialog.dart';

class AddReportBottomSheet extends StatefulWidget {
  const AddReportBottomSheet({super.key});

  @override
  State<AddReportBottomSheet> createState() => _AddReportBottomSheetState();
}

class _AddReportBottomSheetState extends State<AddReportBottomSheet>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  final _imagePicker = ImagePicker();
  String? _selectedImagePath;

  late final AnimationController _animController;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );

    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));

    _animController.forward();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _submitReport(BuildContext context, LatLng position) {
    if (_formKey.currentState!.validate()) {
      final coordinates = [position.latitude, position.longitude];

      ReportCubit reportCubit;
      try {
        reportCubit = context.read<ReportCubit>();
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.reportCubitError),
          ),
        );
        return;
      }

      reportCubit.submitVisitorReport(
        fullName: _fullNameController.text,
        phone: _phoneController.text,
        coordinates: coordinates,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        imagePath: _selectedImagePath,
      );

      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (!mounted || pickedImage == null) return;

      setState(() {
        _selectedImagePath = pickedImage.path;
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorUnknown)),
      );
    }
  }

  void _showImagePreview(BuildContext context) {
    if (_selectedImagePath == null) return;
    showDialog<void>(
      context: context,
      builder: (_) =>
          AddReportImagePreviewDialog(imagePath: _selectedImagePath!),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectionState = context.read<MapSelectionCubit>().state;
    final LatLng position = (selectionState is MapLocationSelected)
        ? selectionState.position
        : const LatLng(0, 0);

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: AddReportBottomSheetContent(
          formKey: _formKey,
          position: position,
          fullNameController: _fullNameController,
          phoneController: _phoneController,
          notesController: _notesController,
          selectedImagePath: _selectedImagePath,
          onPickImage: _pickImage,
          onOpenImagePreview: () => _showImagePreview(context),
          onRemoveImage: () => setState(() => _selectedImagePath = null),
          onSubmit: () => _submitReport(context, position),
        ),
      ),
    );
  }
}

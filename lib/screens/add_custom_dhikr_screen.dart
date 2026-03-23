import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../models/dhikr.dart';
import '../providers/adhkar_provider.dart';

class AddCustomDhikrScreen extends StatefulWidget {
  final bool isMorning;

  const AddCustomDhikrScreen({super.key, required this.isMorning});

  @override
  State<AddCustomDhikrScreen> createState() => _AddCustomDhikrScreenState();
}

class _AddCustomDhikrScreenState extends State<AddCustomDhikrScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _arabicController = TextEditingController();
  final _transliterationController = TextEditingController();
  final _translationController = TextEditingController();
  final _referenceController = TextEditingController();
  int _repetitions = 1;
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _arabicController.dispose();
    _transliterationController.dispose();
    _translationController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  String _generateId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rng = Random.secure();
    return 'custom_${List.generate(12, (_) => chars[rng.nextInt(chars.length)]).join()}';
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    final dhikr = Dhikr(
      id: _generateId(),
      title: _titleController.text.trim(),
      arabicText: _arabicController.text.trim(),
      transliteration: _transliterationController.text.trim(),
      englishTranslation: _translationController.text.trim(),
      repetitions: _repetitions,
      category: widget.isMorning ? 'morning' : 'evening',
      fazail: '',
      reference: _referenceController.text.trim(),
      isCustom: true,
    );

    await context.read<AdhkarProvider>().addCustomDhikr(dhikr);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isMorning ? 'Add Morning Supplication' : 'Add Evening Supplication',
          style: AppTheme.englishStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Text(
                    'Save',
                    style: AppTheme.englishStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.accentGold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppTheme.accentGold, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Only the Arabic text is required. Other fields are optional.',
                        style: AppTheme.englishStyle(fontSize: 13, color: AppTheme.accentGold),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              _buildLabel('Title *'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _titleController,
                hint: 'e.g. Morning Protection Dua',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Title is required' : null,
              ),

              const SizedBox(height: 20),

              _buildLabel('Arabic Text *'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _arabicController,
                maxLines: 4,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: AppTheme.arabicStyle(fontSize: 22, color: isDark ? Colors.white : Colors.black87),
                decoration: _inputDecoration(hint: 'اكتب النص العربي هنا', isDark: isDark),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Arabic text is required' : null,
              ),

              const SizedBox(height: 20),

              _buildLabel('Transliteration', optional: true),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _transliterationController,
                hint: 'e.g. Bismillahir rahmanir raheem...',
                maxLines: 2,
              ),

              const SizedBox(height: 20),

              _buildLabel('English Translation', optional: true),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _translationController,
                hint: 'e.g. In the name of Allah, the most gracious...',
                maxLines: 3,
              ),

              const SizedBox(height: 20),

              _buildLabel('Reference / Source', optional: true),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _referenceController,
                hint: 'e.g. Sahih Bukhari 6306',
              ),

              const SizedBox(height: 24),

              _buildLabel('Daily Repetitions'),
              const SizedBox(height: 12),
              _buildRepetitionsSelector(isDark, subtitleColor),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool optional = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Text(
          text,
          style: AppTheme.englishStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        if (optional)
          Text(
            ' (optional)',
            style: AppTheme.englishStyle(
              fontSize: 12,
              color: isDark ? Colors.grey[500] : Colors.grey[500],
            ),
          ),
      ],
    );
  }

  InputDecoration _inputDecoration({required String hint, required bool isDark}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTheme.englishStyle(
        fontSize: 14,
        color: isDark ? Colors.grey[600] : Colors.grey[400],
      ),
      filled: true,
      fillColor: isDark ? AppTheme.darkCard : Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppTheme.primaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: AppTheme.englishStyle(
        fontSize: 15,
        color: isDark ? Colors.white : Colors.black87,
      ),
      decoration: _inputDecoration(hint: hint, isDark: isDark),
      validator: validator,
    );
  }

  Widget _buildRepetitionsSelector(bool isDark, Color? subtitleColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$_repetitions time${_repetitions == 1 ? '' : 's'} per day',
            style: AppTheme.englishStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          Row(
            children: [
              _repButton(Icons.remove, () {
                if (_repetitions > 1) setState(() => _repetitions--);
              }),
              const SizedBox(width: 8),
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$_repetitions',
                  style: AppTheme.englishStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _repButton(Icons.add, () {
                if (_repetitions < 1000) setState(() => _repetitions++);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _repButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

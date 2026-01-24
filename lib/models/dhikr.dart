class Dhikr {
  final String id;
  final String arabicText;
  final String transliteration;
  final String englishTranslation;
  final int repetitions;
  final String category; // 'morning' or 'evening'
  final String fazail; // Virtues/benefits
  final String reference; // Hadith reference

  const Dhikr({
    required this.id,
    required this.arabicText,
    required this.transliteration,
    required this.englishTranslation,
    required this.repetitions,
    required this.category,
    required this.fazail,
    required this.reference,
  });
}

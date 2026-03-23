class Dhikr {
  final String id;
  final String title;
  final String arabicText;
  final String transliteration;
  final String englishTranslation;
  final int repetitions;
  final String category; // 'morning' or 'evening'
  final String fazail; // Virtues/benefits
  final String reference; // Hadith reference
  final bool isCustom; // User-added supplication

  const Dhikr({
    required this.id,
    required this.title,
    required this.arabicText,
    required this.transliteration,
    required this.englishTranslation,
    required this.repetitions,
    required this.category,
    required this.fazail,
    required this.reference,
    this.isCustom = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'arabicText': arabicText,
        'transliteration': transliteration,
        'englishTranslation': englishTranslation,
        'repetitions': repetitions,
        'category': category,
        'fazail': fazail,
        'reference': reference,
        'isCustom': isCustom,
      };

  factory Dhikr.fromJson(Map<String, dynamic> json) => Dhikr(
        id: json['id'] as String,
        title: json['title'] as String,
        arabicText: json['arabicText'] as String,
        transliteration: json['transliteration'] as String? ?? '',
        englishTranslation: json['englishTranslation'] as String? ?? '',
        repetitions: json['repetitions'] as int? ?? 1,
        category: json['category'] as String,
        fazail: json['fazail'] as String? ?? '',
        reference: json['reference'] as String? ?? '',
        isCustom: json['isCustom'] as bool? ?? true,
      );
}

class Hadith {
  final int id;
  final String arabicText;
  final String englishTranslation;
  final String reference;
  final String book;
  final String narrator;

  const Hadith({
    required this.id,
    required this.arabicText,
    required this.englishTranslation,
    required this.reference,
    required this.book,
    this.narrator = '',
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      id: json['id'] as int,
      arabicText: json['arabic'] as String,
      englishTranslation: json['english'] as String,
      reference: json['reference'] as String,
      book: json['book'] as String,
      narrator: json['narrator'] as String? ?? '',
    );
  }
}

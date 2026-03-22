import '../models/dhikr.dart';

class AdhkarData {
  static const List<Dhikr> morningAdhkar = [
    // 1. Ayat al-Kursi
    Dhikr(
      id: 'morning_1',
      title: 'Ayat al-Kursi',
      arabicText: '''اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ''',
      transliteration: 'Allahu la ilaha illa huwal hayyul qayyum...',
      englishTranslation: 'Allah - there is no deity except Him, the Ever-Living, the Sustainer of existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth. Who is it that can intercede with Him except by His permission? He knows what is before them and what will be after them, and they encompass not a thing of His knowledge except for what He wills. His Kursi extends over the heavens and the earth, and their preservation tires Him not. And He is the Most High, the Most Great.',
      repetitions: 1,
      category: 'morning',
      fazail: 'Whoever recites Ayat al-Kursi in the morning will be protected until evening, and whoever recites it in the evening will be protected until morning.',
      reference: 'An-Nasai, As-Sunan Al-Kubra (9928); Al-Tabarani; Sahih by Al-Albani in Sahih at-Targhib (655)',
    ),

    // 2. Surah Al-Ikhlas
    Dhikr(
      id: 'morning_2',
      title: 'Surah Al-Ikhlas',
      arabicText: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
قُلْ هُوَ اللَّهُ أَحَدٌ ۝ اللَّهُ الصَّمَدُ ۝ لَمْ يَلِدْ وَلَمْ يُولَدْ ۝ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ''',
      transliteration: 'Qul huwa Allahu ahad, Allahus-samad, lam yalid wa lam yulad, wa lam yakun lahu kufuwan ahad',
      englishTranslation: 'Say, "He is Allah, [who is] One, Allah, the Eternal Refuge. He neither begets nor is born, nor is there to Him any equivalent."',
      repetitions: 3,
      category: 'morning',
      fazail: 'Reciting Surah Al-Ikhlas, Al-Falaq, and An-Nas three times in the morning and evening will suffice you in all respects.',
      reference: 'Sunan Abu Dawud (5082); Jami\' at-Tirmidhi (3575); Narrated by Abdullah bin Khubayb',
    ),

    // 3. Surah Al-Falaq
    Dhikr(
      id: 'morning_3',
      title: 'Surah Al-Falaq',
      arabicText: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ۝ مِن شَرِّ مَا خَلَقَ ۝ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ۝ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ۝ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ''',
      transliteration: 'Qul a\'udhu bi rabbil-falaq, min sharri ma khalaq, wa min sharri ghasiqin idha waqab, wa min sharrin-naffathati fil-\'uqad, wa min sharri hasidin idha hasad',
      englishTranslation: 'Say, "I seek refuge in the Lord of daybreak, from the evil of that which He created, and from the evil of darkness when it settles, and from the evil of the blowers in knots, and from the evil of an envier when he envies."',
      repetitions: 3,
      category: 'morning',
      fazail: 'These Surahs provide protection from every evil.',
      reference: 'Sunan Abu Dawud (5082); Jami\' at-Tirmidhi (3575); Narrated by Abdullah bin Khubayb',
    ),

    // 4. Surah An-Nas
    Dhikr(
      id: 'morning_4',
      title: 'Surah An-Nas',
      arabicText: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
قُلْ أَعُوذُ بِرَبِّ النَّاسِ ۝ مَلِكِ النَّاسِ ۝ إِلَٰهِ النَّاسِ ۝ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ۝ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ۝ مِنَ الْجِنَّةِ وَالنَّاسِ''',
      transliteration: 'Qul a\'udhu bi rabbin-nas, malikin-nas, ilahin-nas, min sharril-waswaasil-khannas, alladhi yuwaswisu fi sudurin-nas, minal-jinnati wan-nas',
      englishTranslation: 'Say, "I seek refuge in the Lord of mankind, the Sovereign of mankind, the God of mankind, from the evil of the retreating whisperer - who whispers [evil] into the breasts of mankind - from among the jinn and mankind."',
      repetitions: 3,
      category: 'morning',
      fazail: 'Protection from the whispers of Shaytan and evil.',
      reference: 'Sunan Abu Dawud (5082); Jami\' at-Tirmidhi (3575); Narrated by Abdullah bin Khubayb',
    ),

    // 5. Morning dua - Asbahna
    Dhikr(
      id: 'morning_5',
      title: 'Morning Supplication',
      arabicText: '''أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ. رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَٰذَا الْيَوْمِ وَخَيْرَ مَا بَعْدَهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَٰذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ''',
      transliteration: 'Asbahna wa asbahal-mulku lillah, walhamdu lillah, la ilaha illallahu wahdahu la shareeka lah, lahul-mulku wa lahul-hamd, wa huwa \'ala kulli shay\'in qadeer...',
      englishTranslation: 'We have reached the morning and at this very time the whole kingdom belongs to Allah. All praise is for Allah. None has the right to be worshipped except Allah, alone, without partner. To Him belongs the kingdom and all praise, and He is over all things omnipotent. My Lord, I ask You for the good of this day and the good of what follows it, and I seek refuge in You from the evil of this day and the evil of what follows it. My Lord, I seek refuge in You from laziness and senility. My Lord, I seek refuge in You from the punishment of Hellfire and the punishment of the grave.',
      repetitions: 1,
      category: 'morning',
      fazail: 'A comprehensive morning supplication seeking protection and blessings for the day.',
      reference: 'Sahih Muslim (2723); Narrated by Abdullah ibn Mas\'ud',
    ),

    // 6. Allahumma bika asbahna
    Dhikr(
      id: 'morning_6',
      title: 'Affirming Life & Death',
      arabicText: '''اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ''',
      transliteration: 'Allahumma bika asbahna, wa bika amsayna, wa bika nahya, wa bika namutu, wa ilaykan-nushur',
      englishTranslation: 'O Allah, by Your leave we have reached the morning and by Your leave we have reached the evening; by Your leave we live and die, and unto You is our resurrection.',
      repetitions: 1,
      category: 'morning',
      fazail: 'Acknowledging that all life and death is in Allah\'s hands.',
      reference: 'Jami\' at-Tirmidhi (3391); Sunan Abu Dawud (5068); Narrated by Abu Hurairah; Sahih by Al-Albani',
    ),

    // 7. Allahumma inni asbahtu ush'hiduka
    Dhikr(
      id: 'morning_7',
      title: 'Declaration of Faith',
      arabicText: '''اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَٰهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ''',
      transliteration: 'Allahumma inni asbahtu ush\'hiduka, wa ush\'hidu hamalata \'arshika, wa mala\'ikatika, wa jamee\'a khalqika, annaka antallahu la ilaha illa anta wahdaka la shareeka lak, wa anna Muhammadan \'abduka wa rasuluk',
      englishTranslation: 'O Allah, I have reached the morning and call on You, the bearers of Your throne, Your angels, and all of Your creation to witness that You are Allah, none has the right to be worshipped except You, alone, without partner, and that Muhammad is Your servant and Messenger.',
      repetitions: 4,
      category: 'morning',
      fazail: 'Whoever says this four times in the morning and evening, Allah will free him from the Fire.',
      reference: 'Sunan Abu Dawud (5069); Al-Bukhari, Al-Adab Al-Mufrad (1201); Narrated by Anas bin Malik; Hasan',
    ),

    // 8. Raditu billahi rabba
    Dhikr(
      id: 'morning_8',
      title: 'Contentment with Allah',
      arabicText: '''رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا''',
      transliteration: 'Raditu billahi rabba, wa bil-islami deena, wa bi-Muhammadin sallallahu \'alayhi wa sallama nabiyya',
      englishTranslation: 'I am pleased with Allah as my Lord, with Islam as my religion and with Muhammad (peace be upon him) as my Prophet.',
      repetitions: 3,
      category: 'morning',
      fazail: 'Whoever says this three times in the morning and evening, it is a duty upon Allah to please him on the Day of Judgment.',
      reference: 'Sunan Abu Dawud (5072); Sunan Ibn Majah (3870); Narrated by Thawban; Sahih by Al-Albani',
    ),

    // 9. Ya Hayyu Ya Qayyum
    Dhikr(
      id: 'morning_9',
      title: 'Ya Hayyu Ya Qayyum',
      arabicText: '''يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ''',
      transliteration: 'Ya Hayyu Ya Qayyum, bi-rahmatika astaghith, aslih li sha\'ni kullahu, wa la takilni ila nafsi tarfata \'ayn',
      englishTranslation: 'O Ever-Living, O Self-Sustaining and All-Sustaining, by Your mercy I seek assistance, rectify for me all of my affairs and do not leave me to myself, even for the blink of an eye.',
      repetitions: 3,
      category: 'morning',
      fazail: 'A powerful supplication seeking Allah\'s help in all affairs.',
      reference: 'Al-Hakim, Al-Mustadrak (1/545); An-Nasai, As-Sunan Al-Kubra (10330); Narrated by Anas bin Malik; Hasan by Al-Albani in Sahih al-Jami\' (4777)',
    ),

    // 10. Allahumma 'afini fi badani
    Dhikr(
      id: 'morning_10',
      title: 'Dua for Health & Protection',
      arabicText: '''اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَٰهَ إِلَّا أَنْتَ. اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالْفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَٰهَ إِلَّا أَنْتَ''',
      transliteration: 'Allahumma \'afini fi badani, Allahumma \'afini fi sam\'i, Allahumma \'afini fi basari, la ilaha illa ant. Allahumma inni a\'udhu bika minal-kufri, wal-faqr, wa a\'udhu bika min \'adhabil-qabr, la ilaha illa ant',
      englishTranslation: 'O Allah, grant my body health. O Allah, grant my hearing health. O Allah, grant my sight health. None has the right to be worshipped except You. O Allah, I seek refuge in You from disbelief and poverty, and I seek refuge in You from the punishment of the grave. None has the right to be worshipped except You.',
      repetitions: 3,
      category: 'morning',
      fazail: 'Seeking protection for one\'s health and well-being.',
      reference: 'Sunan Abu Dawud (5090); Al-Adab Al-Mufrad (701); An-Nasa\'i Al-Kubra (10401); Narrated by Abdur-Rahman bin Abi Bakrah; Hasan by Al-Albani',
    ),

    // 11. Hasbiyallahu la ilaha illa hu
    Dhikr(
      id: 'morning_11',
      title: 'Reliance on Allah',
      arabicText: '''حَسْبِيَ اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ، عَلَيْهِ تَوَكَّلْتُ، وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ''',
      transliteration: 'Hasbiyallahu la ilaha illa huwa, \'alayhi tawakkaltu, wa huwa rabbul-\'arshil-\'azeem',
      englishTranslation: 'Allah is Sufficient for me. None has the right to be worshipped except Him. I place my trust in Him and He is the Lord of the Magnificent Throne.',
      repetitions: 7,
      category: 'morning',
      fazail: 'Whoever says this seven times in the morning and evening, Allah will suffice him in all that concerns him.',
      reference: 'Sunan Abu Dawud (5081); Narrated by Abu ad-Darda; Mawquf with ruling of Marfu\'',
    ),

    // 12. SubhanAllah wa bihamdihi
    Dhikr(
      id: 'morning_12',
      title: 'SubhanAllah wa bihamdihi',
      arabicText: '''سُبْحَانَ اللَّهِ وَبِحَمْدِهِ''',
      transliteration: 'SubhanAllahi wa bihamdihi',
      englishTranslation: 'Glory be to Allah and praise be to Him.',
      repetitions: 100,
      category: 'morning',
      fazail: 'Whoever says this one hundred times in the morning and evening, no one will come on the Day of Resurrection with anything better except one who said the same or more.',
      reference: 'Sahih Muslim (2692); Narrated by Abu Hurairah',
    ),

    // 13. La ilaha illallah
    Dhikr(
      id: 'morning_13',
      title: 'Tahlil',
      arabicText: '''لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ''',
      transliteration: 'La ilaha illallahu wahdahu la shareeka lah, lahul-mulku wa lahul-hamd, wa huwa \'ala kulli shay\'in qadeer',
      englishTranslation: 'None has the right to be worshipped except Allah, alone, without partner. To Him belongs the kingdom and all praise, and He is over all things omnipotent.',
      repetitions: 10,
      category: 'morning',
      fazail: 'Whoever says this ten times will have the reward of freeing four slaves from the children of Isma\'il.',
      reference: 'Sahih Muslim (2691); Sunan Abu Dawud (5077); Narrated by Abu Ayyub Al-Ansari',
    ),

    // 14. Astaghfirullah
    Dhikr(
      id: 'morning_14',
      title: 'Seeking Forgiveness',
      arabicText: '''أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ''',
      transliteration: 'Astaghfirullaha wa atubu ilayh',
      englishTranslation: 'I seek the forgiveness of Allah and repent to Him.',
      repetitions: 100,
      category: 'morning',
      fazail: 'The Prophet (ﷺ) used to seek forgiveness from Allah more than seventy times a day.',
      reference: 'Sahih Muslim (2702); Sahih Al-Bukhari (6307); Narrated by Al-Agharr Al-Muzani & Abu Hurairah',
    ),

    // 15. Sayyid al-Istighfar
    Dhikr(
      id: 'morning_15',
      title: 'Sayyid al-Istighfar',
      arabicText: '''اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَٰهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ''',
      transliteration: 'Allahumma anta Rabbi la ilaha illa ant, khalaqtani wa ana \'abduk, wa ana \'ala \'ahdika wa wa\'dika mastata\'t, a\'udhu bika min sharri ma sana\'t, abu\'u laka bi ni\'matika \'alayya, wa abu\'u bi dhanbi, faghfir li fa innahu la yaghfiru-dhunuba illa ant',
      englishTranslation: 'O Allah, You are my Lord. None has the right to be worshipped except You. You created me and I am Your servant, and I abide by Your covenant and promise as best I can. I seek refuge in You from the evil of what I have done. I acknowledge Your favor upon me and I acknowledge my sin, so forgive me, for verily none can forgive sins except You.',
      repetitions: 1,
      category: 'morning',
      fazail: 'Whoever says this during the day with firm faith in it and dies the same day before evening, he will be from the people of Paradise. And if someone says it at night with firm faith and dies before morning, he will be from the people of Paradise.',
      reference: 'Sahih Al-Bukhari (6306); Narrated by Shaddad bin Aus',
    ),

    // 16. Protection from Evil Eye - Prophetic Dua for Children & Self
    Dhikr(
      id: 'morning_16',
      title: 'Protection from Evil Eye',
      arabicText: '''أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّةِ مِنْ كُلِّ شَيْطَانٍ وَهَامَّةٍ وَمِنْ كُلِّ عَيْنٍ لاَمَّةٍ''',
      transliteration: 'A\'ūdhu bi-kalimāti-llāhi-t-tāmmati min kulli shayṭānin wa hāmmah, wa min kulli \'aynin lāmmah',
      englishTranslation: 'I seek refuge in the Perfect Words of Allah from every devil and every poisonous pest, and from every evil, harmful eye.',
      repetitions: 1,
      category: 'morning',
      fazail: 'This is the specific Dua the Prophet Muhammad ﷺ used to recite to protect his grandsons, Al-Hasan and Al-Husain, from the Evil Eye. It is powerful for both preventing and getting rid of Nazar (evil eye).',
      reference: 'Sahih Al-Bukhari (3371); Narrated by Ibn Abbas',
    ),

    // 17. Dua for Healing from Evil Eye
    Dhikr(
      id: 'morning_17',
      title: 'Healing from Evil Eye',
      arabicText: '''بِسْمِ اللَّهِ، اللَّهُمَّ أَذْهِبْ عَنْهُ حَرَّهَا وَبَرْدَهَا وَوَصَبَهَا''',
      transliteration: 'Bismillah, Allahumma azhib \'anhu harraha wa bardaha wa wasabaha',
      englishTranslation: 'In the name of Allah. O Allah, remove from him/me its heat, its cold, and its pain (or illness).',
      repetitions: 1,
      category: 'morning',
      fazail: 'This dua comes from the incident where the companion Sahl ibn Hunaif was struck by the Evil Eye. When the Prophet (ﷺ) was informed, he visited Sahl and recited this dua. For yourself, say "\'anni" (from me) instead of "\'anhu" (from him).',
      reference: 'Musnad Ahmad (16076); An-Nasai, As-Sunan Al-Kubra (7617); Narrated by Sahl ibn Hunaif; Sahih by Al-Albani in Silsilah As-Sahihah (2522)',
    ),
  ];

  static const List<Dhikr> eveningAdhkar = [
    // 1. Ayat al-Kursi
    Dhikr(
      id: 'evening_1',
      title: 'Ayat al-Kursi',
      arabicText: '''اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ''',
      transliteration: 'Allahu la ilaha illa huwal hayyul qayyum...',
      englishTranslation: 'Allah - there is no deity except Him, the Ever-Living, the Sustainer of existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth. Who is it that can intercede with Him except by His permission? He knows what is before them and what will be after them, and they encompass not a thing of His knowledge except for what He wills. His Kursi extends over the heavens and the earth, and their preservation tires Him not. And He is the Most High, the Most Great.',
      repetitions: 1,
      category: 'evening',
      fazail: 'Whoever recites Ayat al-Kursi in the evening will be protected until morning.',
      reference: 'An-Nasai, As-Sunan Al-Kubra (9928); Al-Tabarani; Sahih by Al-Albani in Sahih at-Targhib (655)',
    ),

    // 2. Surah Al-Ikhlas
    Dhikr(
      id: 'evening_2',
      title: 'Surah Al-Ikhlas',
      arabicText: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
قُلْ هُوَ اللَّهُ أَحَدٌ ۝ اللَّهُ الصَّمَدُ ۝ لَمْ يَلِدْ وَلَمْ يُولَدْ ۝ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ''',
      transliteration: 'Qul huwa Allahu ahad, Allahus-samad, lam yalid wa lam yulad, wa lam yakun lahu kufuwan ahad',
      englishTranslation: 'Say, "He is Allah, [who is] One, Allah, the Eternal Refuge. He neither begets nor is born, nor is there to Him any equivalent."',
      repetitions: 3,
      category: 'evening',
      fazail: 'Reciting Surah Al-Ikhlas, Al-Falaq, and An-Nas three times in the morning and evening will suffice you in all respects.',
      reference: 'Sunan Abu Dawud (5082); Jami\' at-Tirmidhi (3575); Narrated by Abdullah bin Khubayb',
    ),

    // 3. Surah Al-Falaq
    Dhikr(
      id: 'evening_3',
      title: 'Surah Al-Falaq',
      arabicText: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ۝ مِن شَرِّ مَا خَلَقَ ۝ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ۝ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ۝ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ''',
      transliteration: 'Qul a\'udhu bi rabbil-falaq, min sharri ma khalaq, wa min sharri ghasiqin idha waqab, wa min sharrin-naffathati fil-\'uqad, wa min sharri hasidin idha hasad',
      englishTranslation: 'Say, "I seek refuge in the Lord of daybreak, from the evil of that which He created, and from the evil of darkness when it settles, and from the evil of the blowers in knots, and from the evil of an envier when he envies."',
      repetitions: 3,
      category: 'evening',
      fazail: 'These Surahs provide protection from every evil.',
      reference: 'Sunan Abu Dawud (5082); Jami\' at-Tirmidhi (3575); Narrated by Abdullah bin Khubayb',
    ),

    // 4. Surah An-Nas
    Dhikr(
      id: 'evening_4',
      title: 'Surah An-Nas',
      arabicText: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
قُلْ أَعُوذُ بِرَبِّ النَّاسِ ۝ مَلِكِ النَّاسِ ۝ إِلَٰهِ النَّاسِ ۝ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ۝ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ۝ مِنَ الْجِنَّةِ وَالنَّاسِ''',
      transliteration: 'Qul a\'udhu bi rabbin-nas, malikin-nas, ilahin-nas, min sharril-waswaasil-khannas, alladhi yuwaswisu fi sudurin-nas, minal-jinnati wan-nas',
      englishTranslation: 'Say, "I seek refuge in the Lord of mankind, the Sovereign of mankind, the God of mankind, from the evil of the retreating whisperer - who whispers [evil] into the breasts of mankind - from among the jinn and mankind."',
      repetitions: 3,
      category: 'evening',
      fazail: 'Protection from the whispers of Shaytan and evil.',
      reference: 'Sunan Abu Dawud (5082); Jami\' at-Tirmidhi (3575); Narrated by Abdullah bin Khubayb',
    ),

    // 5. Evening dua - Amsayna
    Dhikr(
      id: 'evening_5',
      title: 'Evening Supplication',
      arabicText: '''أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ. رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَٰذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَٰذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ''',
      transliteration: 'Amsayna wa amsal-mulku lillah, walhamdu lillah, la ilaha illallahu wahdahu la shareeka lah, lahul-mulku wa lahul-hamd, wa huwa \'ala kulli shay\'in qadeer...',
      englishTranslation: 'We have reached the evening and at this very time the whole kingdom belongs to Allah. All praise is for Allah. None has the right to be worshipped except Allah, alone, without partner. To Him belongs the kingdom and all praise, and He is over all things omnipotent. My Lord, I ask You for the good of this night and the good of what follows it, and I seek refuge in You from the evil of this night and the evil of what follows it. My Lord, I seek refuge in You from laziness and senility. My Lord, I seek refuge in You from the punishment of Hellfire and the punishment of the grave.',
      repetitions: 1,
      category: 'evening',
      fazail: 'A comprehensive evening supplication seeking protection and blessings for the night.',
      reference: 'Sahih Muslim (2723); Narrated by Abdullah ibn Mas\'ud',
    ),

    // 6. Allahumma bika amsayna
    Dhikr(
      id: 'evening_6',
      title: 'Affirming Life & Death',
      arabicText: '''اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيرُ''',
      transliteration: 'Allahumma bika amsayna, wa bika asbahna, wa bika nahya, wa bika namutu, wa ilaykal-maseer',
      englishTranslation: 'O Allah, by Your leave we have reached the evening and by Your leave we have reached the morning; by Your leave we live and die, and unto You is our return.',
      repetitions: 1,
      category: 'evening',
      fazail: 'Acknowledging that all life and death is in Allah\'s hands.',
      reference: 'Jami\' at-Tirmidhi (3391); Sunan Abu Dawud (5068); Narrated by Abu Hurairah; Sahih by Al-Albani',
    ),

    // 7. Allahumma inni amsaytu ush'hiduka
    Dhikr(
      id: 'evening_7',
      title: 'Declaration of Faith',
      arabicText: '''اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَٰهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ''',
      transliteration: 'Allahumma inni amsaytu ush\'hiduka, wa ush\'hidu hamalata \'arshika, wa mala\'ikatika, wa jamee\'a khalqika, annaka antallahu la ilaha illa anta wahdaka la shareeka lak, wa anna Muhammadan \'abduka wa rasuluk',
      englishTranslation: 'O Allah, I have reached the evening and call on You, the bearers of Your throne, Your angels, and all of Your creation to witness that You are Allah, none has the right to be worshipped except You, alone, without partner, and that Muhammad is Your servant and Messenger.',
      repetitions: 4,
      category: 'evening',
      fazail: 'Whoever says this four times in the morning and evening, Allah will free him from the Fire.',
      reference: 'Sunan Abu Dawud (5069); Al-Bukhari, Al-Adab Al-Mufrad (1201); Narrated by Anas bin Malik; Hasan',
    ),

    // 8. Raditu billahi rabba
    Dhikr(
      id: 'evening_8',
      title: 'Contentment with Allah',
      arabicText: '''رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا''',
      transliteration: 'Raditu billahi rabba, wa bil-islami deena, wa bi-Muhammadin sallallahu \'alayhi wa sallama nabiyya',
      englishTranslation: 'I am pleased with Allah as my Lord, with Islam as my religion and with Muhammad (peace be upon him) as my Prophet.',
      repetitions: 3,
      category: 'evening',
      fazail: 'Whoever says this three times in the morning and evening, it is a duty upon Allah to please him on the Day of Judgment.',
      reference: 'Sunan Abu Dawud (5072); Sunan Ibn Majah (3870); Narrated by Thawban; Sahih by Al-Albani',
    ),

    // 9. Ya Hayyu Ya Qayyum
    Dhikr(
      id: 'evening_9',
      title: 'Ya Hayyu Ya Qayyum',
      arabicText: '''يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ''',
      transliteration: 'Ya Hayyu Ya Qayyum, bi-rahmatika astaghith, aslih li sha\'ni kullahu, wa la takilni ila nafsi tarfata \'ayn',
      englishTranslation: 'O Ever-Living, O Self-Sustaining and All-Sustaining, by Your mercy I seek assistance, rectify for me all of my affairs and do not leave me to myself, even for the blink of an eye.',
      repetitions: 3,
      category: 'evening',
      fazail: 'A powerful supplication seeking Allah\'s help in all affairs.',
      reference: 'Al-Hakim, Al-Mustadrak (1/545); An-Nasai, As-Sunan Al-Kubra (10330); Narrated by Anas bin Malik; Hasan by Al-Albani in Sahih al-Jami\' (4777)',
    ),

    // 10. Allahumma 'afini fi badani
    Dhikr(
      id: 'evening_10',
      title: 'Dua for Health & Protection',
      arabicText: '''اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَٰهَ إِلَّا أَنْتَ. اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالْفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَٰهَ إِلَّا أَنْتَ''',
      transliteration: 'Allahumma \'afini fi badani, Allahumma \'afini fi sam\'i, Allahumma \'afini fi basari, la ilaha illa ant. Allahumma inni a\'udhu bika minal-kufri, wal-faqr, wa a\'udhu bika min \'adhabil-qabr, la ilaha illa ant',
      englishTranslation: 'O Allah, grant my body health. O Allah, grant my hearing health. O Allah, grant my sight health. None has the right to be worshipped except You. O Allah, I seek refuge in You from disbelief and poverty, and I seek refuge in You from the punishment of the grave. None has the right to be worshipped except You.',
      repetitions: 3,
      category: 'evening',
      fazail: 'Seeking protection for one\'s health and well-being.',
      reference: 'Sunan Abu Dawud (5090); Al-Adab Al-Mufrad (701); An-Nasa\'i Al-Kubra (10401); Narrated by Abdur-Rahman bin Abi Bakrah; Hasan by Al-Albani',
    ),

    // 11. Hasbiyallahu la ilaha illa hu
    Dhikr(
      id: 'evening_11',
      title: 'Reliance on Allah',
      arabicText: '''حَسْبِيَ اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ، عَلَيْهِ تَوَكَّلْتُ، وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ''',
      transliteration: 'Hasbiyallahu la ilaha illa huwa, \'alayhi tawakkaltu, wa huwa rabbul-\'arshil-\'azeem',
      englishTranslation: 'Allah is Sufficient for me. None has the right to be worshipped except Him. I place my trust in Him and He is the Lord of the Magnificent Throne.',
      repetitions: 7,
      category: 'evening',
      fazail: 'Whoever says this seven times in the morning and evening, Allah will suffice him in all that concerns him.',
      reference: 'Sunan Abu Dawud (5081); Narrated by Abu ad-Darda; Mawquf with ruling of Marfu\'',
    ),

    // 12. SubhanAllah wa bihamdihi
    Dhikr(
      id: 'evening_12',
      title: 'SubhanAllah wa bihamdihi',
      arabicText: '''سُبْحَانَ اللَّهِ وَبِحَمْدِهِ''',
      transliteration: 'SubhanAllahi wa bihamdihi',
      englishTranslation: 'Glory be to Allah and praise be to Him.',
      repetitions: 100,
      category: 'evening',
      fazail: 'Whoever says this one hundred times in the morning and evening, no one will come on the Day of Resurrection with anything better except one who said the same or more.',
      reference: 'Sahih Muslim (2692); Narrated by Abu Hurairah',
    ),

    // 13. La ilaha illallah
    Dhikr(
      id: 'evening_13',
      title: 'Tahlil',
      arabicText: '''لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ''',
      transliteration: 'La ilaha illallahu wahdahu la shareeka lah, lahul-mulku wa lahul-hamd, wa huwa \'ala kulli shay\'in qadeer',
      englishTranslation: 'None has the right to be worshipped except Allah, alone, without partner. To Him belongs the kingdom and all praise, and He is over all things omnipotent.',
      repetitions: 10,
      category: 'evening',
      fazail: 'Whoever says this ten times will have the reward of freeing four slaves from the children of Isma\'il.',
      reference: 'Sahih Muslim (2691); Sunan Abu Dawud (5077); Narrated by Abu Ayyub Al-Ansari',
    ),

    // 14. Astaghfirullah
    Dhikr(
      id: 'evening_14',
      title: 'Seeking Forgiveness',
      arabicText: '''أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ''',
      transliteration: 'Astaghfirullaha wa atubu ilayh',
      englishTranslation: 'I seek the forgiveness of Allah and repent to Him.',
      repetitions: 100,
      category: 'evening',
      fazail: 'The Prophet (ﷺ) used to seek forgiveness from Allah more than seventy times a day.',
      reference: 'Sahih Muslim (2702); Sahih Al-Bukhari (6307); Narrated by Al-Agharr Al-Muzani & Abu Hurairah',
    ),

    // 15. Sayyid al-Istighfar
    Dhikr(
      id: 'evening_15',
      title: 'Sayyid al-Istighfar',
      arabicText: '''اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَٰهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ''',
      transliteration: 'Allahumma anta Rabbi la ilaha illa ant, khalaqtani wa ana \'abduk, wa ana \'ala \'ahdika wa wa\'dika mastata\'t, a\'udhu bika min sharri ma sana\'t, abu\'u laka bi ni\'matika \'alayya, wa abu\'u bi dhanbi, faghfir li fa innahu la yaghfiru-dhunuba illa ant',
      englishTranslation: 'O Allah, You are my Lord. None has the right to be worshipped except You. You created me and I am Your servant, and I abide by Your covenant and promise as best I can. I seek refuge in You from the evil of what I have done. I acknowledge Your favor upon me and I acknowledge my sin, so forgive me, for verily none can forgive sins except You.',
      repetitions: 1,
      category: 'evening',
      fazail: 'Whoever says this during the day with firm faith in it and dies the same day before evening, he will be from the people of Paradise. And if someone says it at night with firm faith and dies before morning, he will be from the people of Paradise.',
      reference: 'Sahih Al-Bukhari (6306); Narrated by Shaddad bin Aus',
    ),

    // 16. Protection from Evil Eye - Prophetic Dua for Children & Self
    Dhikr(
      id: 'evening_16',
      title: 'Protection from Evil Eye',
      arabicText: '''أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّةِ مِنْ كُلِّ شَيْطَانٍ وَهَامَّةٍ وَمِنْ كُلِّ عَيْنٍ لاَمَّةٍ''',
      transliteration: 'A\'ūdhu bi-kalimāti-llāhi-t-tāmmati min kulli shayṭānin wa hāmmah, wa min kulli \'aynin lāmmah',
      englishTranslation: 'I seek refuge in the Perfect Words of Allah from every devil and every poisonous pest, and from every evil, harmful eye.',
      repetitions: 1,
      category: 'evening',
      fazail: 'This is the specific Dua the Prophet Muhammad ﷺ used to recite to protect his grandsons, Al-Hasan and Al-Husain, from the Evil Eye. It is powerful for both preventing and getting rid of Nazar (evil eye).',
      reference: 'Sahih Al-Bukhari (3371); Narrated by Ibn Abbas',
    ),

    // 17. Dua for Healing from Evil Eye
    Dhikr(
      id: 'evening_17',
      title: 'Healing from Evil Eye',
      arabicText: '''بِسْمِ اللَّهِ، اللَّهُمَّ أَذْهِبْ عَنْهُ حَرَّهَا وَبَرْدَهَا وَوَصَبَهَا''',
      transliteration: 'Bismillah, Allahumma azhib \'anhu harraha wa bardaha wa wasabaha',
      englishTranslation: 'In the name of Allah. O Allah, remove from him/me its heat, its cold, and its pain (or illness).',
      repetitions: 1,
      category: 'evening',
      fazail: 'This dua comes from the incident where the companion Sahl ibn Hunaif was struck by the Evil Eye. When the Prophet (ﷺ) was informed, he visited Sahl and recited this dua. For yourself, say "\'anni" (from me) instead of "\'anhu" (from him).',
      reference: 'Musnad Ahmad (16076); An-Nasai, As-Sunan Al-Kubra (7617); Narrated by Sahl ibn Hunaif; Sahih by Al-Albani in Silsilah As-Sahihah (2522)',
    ),
  ];
}

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_kurzcheck_bereich_lu (kmr_bereich_nr, kmr_bereich_bez,
kmr_bereich_bez_cz, kmr_bereich_bez_sk, kmr_bereich_bez_hr, kmr_bereich_bez_pl, kmr_bereich_bez_ro, kmr_bereich_bez_bg,
kmr_bereich_bez_de) AS SELECT CAST(a1 AS BIGNUMERIC) AS kmr_bereich_nr,
 CAST(a2 AS STRING) AS kmr_bereich_bez,
 CAST(a3 AS STRING) AS kmr_bereich_bez_cz,
 CAST(a4 AS STRING) AS kmr_bereich_bez_sk,
 CAST(a5 AS STRING) AS kmr_bereich_bez_hr,
 CAST(a6 AS STRING) AS kmr_bereich_bez_pl,
 CAST(a7 AS STRING) AS kmr_bereich_bez_ro,
 CAST(a8 AS STRING) AS kmr_bereich_bez_bg,
 CAST(a2 AS STRING) AS kmr_bereich_bez_de
FROM (SELECT 0 AS a1,
    'Filialbewertung' AS a2,
    'Hodnocení filiálky' AS a3,
    'Hodnotenie filiálky' AS a4,
    'Poslovnica ukupno' AS a5,
    'Ocena marketu' AS a6,
    'Evaluare magazin' AS a7,
    'О\tценка Филиал' AS a8
   UNION ALL
   SELECT 5,
    'Obst & Gemüse',
    'Ovoce & zelenina',
    'Ovocie & zelenina / rastliny',
    'Voće i povrće',
    'Owoce/Warzywa',
    'Legume & fructe',
    'Плодове и Зеленчуци'
   UNION ALL
   SELECT 10,
    'To go/Convenience',
    'To go/Convenience',
    'To go/Convenience',
    'ToGo/Convenience',
    'To go/dania gotowe',
    'To go/Convenience',
    'To Go/Convenience'
   UNION ALL
   SELECT 15,
    'Backshop',
    'Backshop',
    'Pekáreň',
    'Pekara',
    'Piekarnia',
    'Brutarie',
    'Пекарна'
   UNION ALL
   SELECT 20,
    'SB Fleisch/Geflügel/Fisch',
    'Maso/drůbež/ryby v samoobslužných regálech',
    'SB Mäso/hydina/ryby',
    'Samoposlužno meso/perad/riba',
    'SB mięso/drób/ryby',
    'Carne/pasare/peste SB',
    'SB Пиле/Месо/Риба'
   UNION ALL
   SELECT 25,
    'SB Wurst',
    'Uzeniny v samoobslužných regálech',
    'SB \u00dadeniny',
    'Samoposlužno salame',
    'SB wędliny',
    'Mezeluri SB',
    'SB Колбаси'
   UNION ALL
   SELECT 30,
    'Mopro/gek Feinkost',
    'Mléčné výrobky/lahůdky v samoobslužných regálech',
    'Mliečne výrobky/lahôdky',
    'Mliječno/hlađena delikatesa',
    'Mopro',
    'Lactate/delicatese refrigerate',
    'Млечни/Деликатеси'
   UNION ALL
   SELECT 35,
    'Tiefkühlkost',
    'Mražené potraviny',
    'Mrazené v\u00fdrobky',
    'Duboko smrznuto',
    'Mrożonki',
    'Congelate',
    'Дълбоко замразени'
   UNION ALL
   SELECT 40,
    'Theken',
    'Obslužné pulty',
    'Pulty',
    'Uslužni pult',
    'Lada',
    'Vitrina asistata',
    'Витрина с облсужване'
   UNION ALL
   SELECT 45,
    'Food alkoholische/alkoholfreie Getränke',
    'Food alkoholické/nealkoholické nápoje',
    'Food alkoholické/nealkoholické nápoje',
    'Food Alkoholna/bezalkoholna pića',
    'Food napoje alkoholowe/bezalkoholowe',
    'Food bauturi alcoolice/non-alcoolice',
    'Алкохолни/Безалкохолни напитки'
   UNION ALL
   SELECT 50,
    'Food Drogerie/Wasch/Putzmittel + Tiernahrung',
    'Food drogerie/mycí/čistící prostředky + krmivo pro zvířata',
    'Food drogéria/pracie/čistiace prostriedky + krmivá pre zvieratá',
    'Food Drogerija/sredstva za čišćenje+hrana za ljubimce',
    'Food drogeria/środki do prania/ czystości/zdrowie/dzieci + zwierzęta',
    'Food drogherie/detergenți/solutii de curățare + hrană pentru animale',
    'Дрогерия/Перилни/Почистващи + Храна за животни'
   UNION ALL
   SELECT 55,
    'Food Nahrungsmittel/Sü\u00dfwaren',
    'Food koloniál/cukrovinky',
    'Food potraviny/cukrovinky/konzervy',
    'Food Prehrana/slatkiši',
    'Food żywność/słodycze',
    'Food alimente/dulciuri',
    'Основни храни/Захарни изделия'
   UNION ALL
   SELECT 60,
    'NonFood',
    'Nonfood',
    'NonFood',
    'NonFood',
    'NonFood',
    'NonFood',
    'Нехрани'
   UNION ALL
   SELECT 65,
    'Kasse/SCO',
    'Pokladny/SCO',
    'Pokladne/SCO',
    'Blagajna/SCO',
    'Kasa/kasa samoobsługowa',
    'Case/Case express',
    'Каси/SCO'
   UNION ALL
   SELECT 70,
    'Kundentoilette',
    'Zákaznické toalety',
    'Zákaznícke toalety',
    'Toaleti za kupce',
    'Toaleta dla klientów',
    'Toalete clienti',
    'Клиентски тоалетни'
   UNION ALL
   SELECT 75,
    'Erscheinungsbild Filiale',
    'Vzhled filiálky',
    'Vzhľad filiálky',
    'Izgled poslovnica',
    'Ogólny wygląd marketu',
    'Imagine magazin',
    'Външен вид на филиала'
   UNION ALL
   SELECT 80,
    'Freundlichkeit',
    'Vstřícnost',
    'Prívetivosť',
    'Ljubaznost',
    'Uprzejmość',
    'Amabilitate',
    'Любезно обслужване'
   UNION ALL
   SELECT 85,
    'Imbiss',
    'Imbiss',
    'Imbiss',
    'Imbis',
    'Imbiss',
    'Imbiss',
    'Ред / Хигиена / Имбис'
   UNION ALL
   SELECT 90,
    'K-Card',
    'K-Card',
    'K-Card',
    'K-Card',
    'K-Card',
    'K-Card',
    'K-Card') AS kmr;
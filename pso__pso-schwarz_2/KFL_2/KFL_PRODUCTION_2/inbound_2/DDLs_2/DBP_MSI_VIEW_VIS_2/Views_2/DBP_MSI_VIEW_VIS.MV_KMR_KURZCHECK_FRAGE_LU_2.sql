CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_KURZCHECK_FRAGE_LU_2 (
	KMR_FRAGE_NR,
	KMR_FRAGE_SORT,
	KMR_BEREICH_NR,
	KMR_KATEGORIE_NR,
	KMR_FRAGE_BEZ,
	KMR_FRAGE_BEZ_CZ,
	KMR_FRAGE_BEZ_SK,
	KMR_FRAGE_BEZ_HR,
	KMR_FRAGE_BEZ_PL,
	KMR_FRAGE_BEZ_RO,
	KMR_FRAGE_BEZ_BG,
	KMR_FRAGE_BEZ_DE
) AS 
 
/*
	LOOKUP : KMR Kurzcheck Fragen (ab 2024-08)
	2024-11-19 ssch0611 : Initial + VIS Erweiterung/Aggregationen [AP0237709]
*/
 
SELECT 
  frage_nr ::INTEGER     AS kmr_frage_nr
, frage_sort ::INTEGER   AS kmr_frage_sort
, bereich_nr ::INTEGER   AS kmr_bereich_nr
, kategorie_nr ::INTEGER AS kmr_kategorie_nr
, MAX(bez_de)                        AS kmr_frage_bez    /* DE=default */
, COALESCE(MAX(bez_cz), MAX(bez_de)) AS kmr_frage_bez_cz 
, COALESCE(MAX(bez_sk), MAX(bez_de)) AS kmr_frage_bez_sk 
, COALESCE(MAX(bez_hr), MAX(bez_de)) AS kmr_frage_bez_hr 
, COALESCE(MAX(bez_pl), MAX(bez_de)) AS kmr_frage_bez_pl 
, COALESCE(MAX(bez_ro), MAX(bez_de)) AS kmr_frage_bez_ro 
, COALESCE(MAX(bez_bg), MAX(bez_de)) AS kmr_frage_bez_bg 
, kmr_frage_bez                      AS kmr_frage_bez_de /* not used */ 
 
/* Basisabfrage mit Filterung auf relevante Daten/Fragen */ 
FROM ( 
	SELECT  
	  kmr_frg.sort_nr /* Basisfeld */
	, SUBSTR(kmr_frg.sort_nr, 12, 4) AS frage_nr     /* Frage Kurzform - Sortierung nach Kategorie, Bereich */
	, SUBSTR(kmr_frg.sort_nr, 14, 2) AS bereich_nr   /* Bereich/Hauptbereich */
	, SUBSTR(kmr_frg.sort_nr, 12, 2) AS kategorie_nr /* Kategorie/Unterkategorie */
	, bereich_nr || kategorie_nr     AS frage_sort   /* Sortierung nach Bereich, Kategorie */
	, SUBSTR(kmr_frg.sort_nr,  2, 2) AS land_2         /* Land_2 der Frage*/
	, TRIM(kmr_frg.frage_text)               AS frg_txt
	, POSITION('//', kmr_frg.frage_text)     AS pos_nr
	, TRIM(SUBSTR(frg_txt, pos_nr + 3, 255)) AS txt_de
	, TRIM(SUBSTR(frg_txt, 1, pos_nr - 1))   AS txt_ls
	, CASE WHEN pos_nr > 0  THEN txt_de ELSE frg_txt END AS bez_de
	, CASE WHEN land_2 = 'CZ' THEN txt_ls END AS bez_cz
	, CASE WHEN land_2 = 'SK' THEN txt_ls END AS bez_sk
	, CASE WHEN land_2 = 'HR' THEN txt_ls END AS bez_hr
	, CASE WHEN land_2 = 'PL' THEN txt_ls END AS bez_pl
	, CASE WHEN land_2 = 'RO' THEN txt_ls END AS bez_ro
	, CASE WHEN land_2 = 'BG' THEN txt_ls END AS bez_bg
	FROM DBP_VIEW.V_KMR_FRAGE_2 kmr_frg
	INNER JOIN DBP_VIEW.V_KMR_PRUEFPROGRAMM_KAPITEL_2 kmr_kap
	ON kmr_kap.kapitel_id = kmr_frg.kapitel_id AND kmr_kap.amx_system_id = kmr_frg.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_PRUEFUNG_2 kmr_prf
	ON kmr_prf.pruefung_id = kmr_kap.pruefung_id AND kmr_prf.amx_system_id = kmr_kap.amx_system_id
	WHERE kmr_frg.amx_system_id = 1                    /* OneAudimex */
	AND kmr_prf.pruefung_klasse_id IN (100003)         /* Kurzcheck */
	AND kmr_prf.pruefung_status_id IN (100005, 100041) /* Bericht versandt, Bericht versandt* */
) kmr 
GROUP BY ALL
 
/* VIS Erweiterung : Aggregation pro Bereich auf Kategorie Gesamt/Gesamtbewertung */
UNION ALL SELECT 
  $1 ::INTEGER       AS kmr_frage_nr
, kmr_frage_nr * 100 AS kmr_frage_sort 
, $1 ::INTEGER       AS kmr_bereich_nr 
, 00 ::INTEGER       AS kmr_kategorie_nr 
, $2 ::VARCHAR       AS kmr_frage_bez
, $3 ::VARCHAR       AS kmr_frage_bez_cz
, $4 ::VARCHAR       AS kmr_frage_bez_sk
, $5 ::VARCHAR       AS kmr_frage_bez_hr
, $6 ::VARCHAR       AS kmr_frage_bez_pl
, $7 ::VARCHAR       AS kmr_frage_bez_ro
, $8 ::VARCHAR       AS kmr_frage_bez_bg
, kmr_frage_bez      AS kmr_frage_bez_de 
FROM ( /* Bezeichnungen extrahiert aus FRAGE_TXT */
	SELECT           0005, 'Gesamt / Obst & Gemüse', 'Celkom / Ovoce & zelenina', 'Celkom / Ovocie & zelenina', 'Ukupno / Voće i povrće', 'Suma / Owoce/Warzywa', 'Total / Legume & fructe', 'Обща / Плодове и Зеленчуци' 
	UNION ALL SELECT 0010, 'Gesamt / To go/Convenience', 'Celkom / To go/Convenience', 'Celkom / To go/Convenience', 'Ukupno / ToGo/Convenience', 'Suma / To go/dania gotowe', 'Total / To go/Convenience', 'Обща / To Go/Convenience' 
	UNION ALL SELECT 0015, 'Gesamt / Backshop', 'Celkom / Backshop', 'Celkom / Pekáre_2ň', 'Ukupno / Pekara', 'Suma / Piekarnia', 'Total / Brutarie', 'Обща / Пекарна' 
	UNION ALL SELECT 0020, 'Gesamt / SB Fleisch/Geflügel/Fisch', 'Celkom / Maso/drůbež/ryby v samoobslužných regálech', 'Celkom / SB Mäso/hydina/ryby', 'Ukupno / Samoposlužno meso/perad/riba', 'Suma / SO mięso/drób/ryby', 'Total / Carne/pasare/peste SB', 'Обща / SB Пиле/Месо/Риба' 
	UNION ALL SELECT 0025, 'Gesamt / SB Wurst', 'Celkom / Uzeniny v samoobslužných regálech', 'Celkom / SB Údeniny', 'Ukupno / Samoposlužno salame', 'Suma / SO wędliny', 'Total / Mezeluri SB', 'Обща / SB Колбаси' 
	UNION ALL SELECT 0030, 'Gesamt / Mopro/gek Feinkost', 'Celkom / Mléčné výrobky/lahůdky v samoobslužných regálech', 'Celkom / Mliečne výrobky/lahôdky', 'Ukupno / Mliječno/hlađena delikatesa', 'Suma / Art. mleczne/chłodzone delikatesy', 'Total / Lactate/delicatese refrigerate', 'Обща / Млечни/Деликатеси' 
	UNION ALL SELECT 0035, 'Gesamt / Tiefkühlkost', 'Celkom / Mražené potraviny', 'Celkom / Mrazené výrobky', 'Ukupno / Dubokosmrznuto', 'Suma / Mrożonki', 'Total / Congelate', 'Обща / Дълбоко замразени' 
	UNION ALL SELECT 0040, 'Gesamt / Theken', 'Celkom / Obslužné pulty', 'Celkom / Pulty', 'Ukupno / Uslužni pult', 'Suma / Lada', 'Total / Vitrina asistata', 'Обща / Витрина с облсужване' 
	UNION ALL SELECT 0045, 'Gesamt / Food alkoholische/alkoholfreie Getränke', 'Celkom / Food alkoholické/nealkoholické nápoje', 'Celkom / Food alkoholické/nealkoholické nápoje', 'Ukupno / Food Alkoholna/bezalkoholna pića', 'Suma / Food napoje alkoholowe/bezalkoholowe', 'Total / Food bauturi alcoolice/non-alcoolice', 'Обща / Алкохолни/Безалкохолни напитки' 
	UNION ALL SELECT 0050, 'Gesamt / Food Drogerie/Wasch/Putzmittel + Tiernahrung', 'Celkom / Food drogerie/mycí/čistící prostředky + krmivo pro zvířata', 'Celkom / Food drogéria/pracie/čistiace prostriedky + krmivá pre zvieratá', 'Ukupno / Food Drogerija/sredstva za čišćenje+hrana za ljubimce', 'Suma / Food drogeria/środki do prania/ czystości/zdrowie/dzieci + zwierzęta', 'Total / Food drogherie/detergenți/solutii de curățare + hrană pentru animale', 'Обща / Дрогерия/Перилни/Почистващи + Храна за животни' 
	UNION ALL SELECT 0055, 'Gesamt / Food Nahrungsmittel/Süßwaren', 'Celkom / Food koloniál/cukrovinky', 'Celkom / Food potraviny/cukrovinky', 'Ukupno / Food Prehrana/slatkiši', 'Suma / Food żywność/słodycze', 'Total / Food alimente/dulciuri', 'Обща / Основни храни/Захарни изделия' 
	UNION ALL SELECT 0060, 'Gesamt / NonFood', 'Celkom / Nonfood', 'Celkom / NonFood', 'Ukupno / NonFood', 'Suma / NonFood', 'Total / NonFood', 'Обща / Нехрани' 
	UNION ALL SELECT 0065, 'Gesamt / Kasse/SCO', 'Celkom / Pokladny/SCO', 'Celkom / Pokladne/SCO', 'Ukupno / Blagajna/SCO', 'Suma / Kasa/kasa samoobsługowa', 'Total / Case/Case express', 'Обща / Каси/SCO' 
	UNION ALL SELECT 0070, 'Gesamt / Kundentoilette', 'Celkom / Zákaznické toalety', 'Celkom / Zákaznícke toalety', 'Ukupno / Toaleti za kupce', 'Suma / Toaleta dla klientów', 'Total / Toalete clienti', 'Обща / Клиентски тоалетни' 
	UNION ALL SELECT 0075, 'Gesamt / Erscheinungsbild Filiale', 'Celkom / Vzhled filiálky', 'Celkom / Vzhľad filiálky', 'Ukupno / Izgled poslovnica', 'Suma / Ogólny wygląd marketu', 'Total / Imagine magazin', 'Обща / Външен вид на филиала' 
	UNION ALL SELECT 0080, 'Gesamt / Freundlichkeit', 'Celkom / Vstřícnost', 'Celkom / Prívetivosť', 'Ukupno / Ljubaznost', 'Suma / Uprzejmość', 'Total / Amabilitate', 'Обща / Любезно обслужване' 
	UNION ALL SELECT 0085, 'Gesamt / Imbiss', 'Celkom / Imbiss', 'Celkom / Imbiss', 'Ukupno / Imbis', 'Suma / Imbiss', 'Total / Imbiss', 'Обща / Ред / Хигиена / Имбис' 
) kmr 
 
/* VIS Erweiterung : Aggregation pro Kategorie auf Bereich Filiale/Filialbewertung */
UNION ALL SELECT 
  $1 ::INTEGER          AS kmr_frage_nr
, LEFT($1, 2) ::INTEGER AS kmr_frage_sort
, 00 ::INTEGER          AS kmr_bereich_nr 
, LEFT($1, 2) ::INTEGER AS kmr_kategorie_nr 
, $2 ::VARCHAR          AS kmr_frage_bez
, $3 ::VARCHAR          AS kmr_frage_bez_cz
, $4 ::VARCHAR          AS kmr_frage_bez_sk
, $5 ::VARCHAR          AS kmr_frage_bez_hr
, $6 ::VARCHAR          AS kmr_frage_bez_pl
, $7 ::VARCHAR          AS kmr_frage_bez_ro
, $8 ::VARCHAR          AS kmr_frage_bez_bg
, kmr_frage_bez         AS kmr_frage_bez_de
FROM ( /* Bezeichnungen extrahiert aus FRAGE_TXT */
	SELECT           1000, 'Warenverfügbarkeit Sortiment / Filiale', 'Dostupnost zboží  / Filiálky', 'Dostupnosť tovaru  / Filiálky', 'Raspoloživost asortiman  / Poslovnica', 'Dostępność towaru / Market', 'Disponibilitate sortiment  / Magazin', 'Наличност асортимент  / Филиал' 
	UNION ALL SELECT 2000, 'Warenverfügbarkeit Werbung / Filiale', 'Dostupnost akčního zboží  / Filiálky', 'Dostupnosť akcie  / Filiálky', 'Raspoloživost Reklamnih / Poslovnica', 'Dostępność artykuł reklamowany / Market', 'Disponibilitate promotie  / Magazin', 'Наличие на акция  / Филиал' 
	UNION ALL SELECT 3000, 'Warenfrische / Filiale', 'Čerstvost zboží  / Filiálky', 'Čerstvosť tovaru  / Filiálky', 'Svježina  / Poslovnica', 'Świeżość towaru / Market', 'Prospetime  / Magazin', 'Свежест на стоки  / Филиал' 
	UNION ALL SELECT 4000, 'Sauberkeit/Ordnung/Hygiene / Filiale', 'Čistota/Pořádek/Hygiena   / Filiálky', 'Čistota/Poriadok/Hygiena   / Filiálky', 'Čistoća/Urednost/Higijena  / Poslovnica', 'Czystość/porządek / Market', 'Curatenie/Ordine/Igiena  / Magazin', 'Чистота/Ред/Хигиена  / Филиал' 
	UNION ALL SELECT 5000, 'Preisauszeichnung / Filiale', 'Cenové značení  / Filiálky', 'Cenové značenie  / Filiálky', 'Isticanje cijena  / Poslovnica', 'Oznaczenie cenowe / Market', 'Etichetare  / Magazin', 'Ценово обозначаване  / Филиал' 
	UNION ALL SELECT 6000, 'Abwicklung/Funktionalität / Filiale', 'Odbavení/Funkčnost  / Filiálky', 'Priebeh/Funkčnosť  / Filiálky', 'Odvijanje/Funkcionalnost  / Poslovnica', 'Obsługa/funkcjonalność / Market', 'Derulare/Functionalitate  / Magazin', 'Дейност/Функционалност  / Филиал' 
) kmr 
;
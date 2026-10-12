CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_KURZCHECK_BEREICH_LU_1(
	KMR_BEREICH_NR,
	KMR_BEREICH_BEZ,
	KMR_BEREICH_BEZ_CZ,
	KMR_BEREICH_BEZ_SK,
	KMR_BEREICH_BEZ_HR,
	KMR_BEREICH_BEZ_PL,
	KMR_BEREICH_BEZ_RO,
	KMR_BEREICH_BEZ_BG,
	KMR_BEREICH_BEZ_DE
) AS 

/*
	LOOKUP : KMR Kurzcheck Bereiche (ab 2024-08)
	2024-11-19 ssch0611 : Initial, Extraktion Bezeichnungen aus FRAGE_TXT [AP0237709]
	2025-04-04 ssch0611 : Feedback FB. Anpassung Übersetzungen [AP0237709]
*/


SELECT $1 ::INTEGER		AS kmr_bereich_nr
	, $2 ::VARCHAR		AS kmr_bereich_bez /* default = DE */
	, $3 ::VARCHAR		AS kmr_bereich_bez_cz 
	, $4 ::VARCHAR		AS kmr_bereich_bez_sk 
	, $5 ::VARCHAR		AS kmr_bereich_bez_hr 
	, $6 ::VARCHAR		AS kmr_bereich_bez_pl 
	, $7 ::VARCHAR		AS kmr_bereich_bez_ro 
	, $8 ::VARCHAR		AS kmr_bereich_bez_bg 
	, $2 ::VARCHAR		AS kmr_bereich_bez_de /* not used*/
FROM(
	SELECT           00, 'Filialbewertung', 'Hodnocení filiálky', 'Hodnotenie filiálky', 'Poslovnica ukupno', 'Ocena marketu', 'Evaluare magazin', 'О	ценка Филиал' 
	UNION ALL SELECT 05, 'Obst & Gemüse', 'Ovoce & zelenina', 'Ovocie & zelenina / rastliny', 'Voće i povrće', 'Owoce/Warzywa', 'Legume & fructe', 'Плодове и Зеленчуци' 
	UNION ALL SELECT 10, 'To go/Convenience', 'To go/Convenience', 'To go/Convenience', 'ToGo/Convenience', 'To go/dania gotowe', 'To go/Convenience', 'To Go/Convenience' 
	UNION ALL SELECT 15, 'Backshop', 'Backshop', 'Pekáre_1ň', 'Pekara', 'Piekarnia', 'Brutarie', 'Пекарна' 
	UNION ALL SELECT 20, 'SB Fleisch/Geflügel/Fisch', 'Maso/drůbež/ryby v samoobslužných regálech', 'SB Mäso/hydina/ryby', 'Samoposlužno meso/perad/riba', 'SB mięso/drób/ryby', 'Carne/pasare/peste SB', 'SB Пиле/Месо/Риба' 
	UNION ALL SELECT 25, 'SB Wurst', 'Uzeniny v samoobslužných regálech', 'SB Údeniny', 'Samoposlužno salame', 'SB wędliny', 'Mezeluri SB', 'SB Колбаси' 
	UNION ALL SELECT 30, 'Mopro/gek Feinkost', 'Mléčné výrobky/lahůdky v samoobslužných regálech', 'Mliečne výrobky/lahôdky', 'Mliječno/hlađena delikatesa', 'Mopro', 'Lactate/delicatese refrigerate', 'Млечни/Деликатеси' 
	UNION ALL SELECT 35, 'Tiefkühlkost', 'Mražené potraviny', 'Mrazené výrobky', 'Duboko smrznuto', 'Mrożonki', 'Congelate', 'Дълбоко замразени' 
	UNION ALL SELECT 40, 'Theken', 'Obslužné pulty', 'Pulty', 'Uslužni pult', 'Lada', 'Vitrina asistata', 'Витрина с облсужване' 
	UNION ALL SELECT 45, 'Food alkoholische/alkoholfreie Getränke', 'Food alkoholické/nealkoholické nápoje', 'Food alkoholické/nealkoholické nápoje', 'Food Alkoholna/bezalkoholna pića', 'Food napoje alkoholowe/bezalkoholowe', 'Food bauturi alcoolice/non-alcoolice', 'Алкохолни/Безалкохолни напитки' 
	UNION ALL SELECT 50, 'Food Drogerie/Wasch/Putzmittel + Tiernahrung', 'Food drogerie/mycí/čistící prostředky + krmivo pro zvířata', 'Food drogéria/pracie/čistiace prostriedky + krmivá pre zvieratá', 'Food Drogerija/sredstva za čišćenje+hrana za ljubimce', 'Food drogeria/środki do prania/ czystości/zdrowie/dzieci + zwierzęta', 'Food drogherie/detergenți/solutii de curățare + hrană pentru animale', 'Дрогерия/Перилни/Почистващи + Храна за животни' 
	UNION ALL SELECT 55, 'Food Nahrungsmittel/Süßwaren', 'Food koloniál/cukrovinky', 'Food potraviny/cukrovinky/konzervy', 'Food Prehrana/slatkiši', 'Food żywność/słodycze', 'Food alimente/dulciuri', 'Основни храни/Захарни изделия' 
	UNION ALL SELECT 60, 'NonFood', 'Nonfood', 'NonFood', 'NonFood', 'NonFood', 'NonFood', 'Нехрани' 
	UNION ALL SELECT 65, 'Kasse/SCO', 'Pokladny/SCO', 'Pokladne/SCO', 'Blagajna/SCO', 'Kasa/kasa samoobsługowa', 'Case/Case express', 'Каси/SCO' 
	UNION ALL SELECT 70, 'Kundentoilette', 'Zákaznické toalety', 'Zákaznícke toalety', 'Toaleti za kupce', 'Toaleta dla klientów', 'Toalete clienti', 'Клиентски тоалетни' 
	UNION ALL SELECT 75, 'Erscheinungsbild Filiale', 'Vzhled filiálky', 'Vzhľad filiálky', 'Izgled poslovnica', 'Ogólny wygląd marketu', 'Imagine magazin', 'Външен вид на филиала' 
	UNION ALL SELECT 80, 'Freundlichkeit', 'Vstřícnost', 'Prívetivosť', 'Ljubaznost', 'Uprzejmość', 'Amabilitate', 'Любезно обслужване' 
	UNION ALL SELECT 85, 'Imbiss', 'Imbiss', 'Imbiss', 'Imbis', 'Imbiss', 'Imbiss', 'Ред / Хигиена / Имбис' 
	UNION ALL SELECT 90, 'K-Card', 'K-Card', 'K-Card', 'K-Card', 'K-Card', 'K-Card', 'K-Card' 
	) kmr
;
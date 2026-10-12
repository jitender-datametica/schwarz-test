CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_KURZCHECK_KATEGORIE_LU(
	KMR_KATEGORIE_NR,
	KMR_KATEGORIE_BEZ,
	KMR_KATEGORIE_BEZ_CZ,
	KMR_KATEGORIE_BEZ_SK,
	KMR_KATEGORIE_BEZ_HR,
	KMR_KATEGORIE_BEZ_PL,
	KMR_KATEGORIE_BEZ_RO,
	KMR_KATEGORIE_BEZ_BG,
	KMR_KATEGORIE_BEZ_DE
) AS 
 
/*
	LOOKUP : KMR Kurzcheck Kategorien (ab 2024-08)
	2024-11-19 ssch0611 : Initial, Extraktion aus FRAGE_TXT [AP0237709]
	2025-04-04 ssch0611 : Feedback FB. Anpassung Übersetzungen [AP0237709]
*/
 
SELECT
  $1 ::INTEGER      AS kmr_kategorie_nr
, $2 ::VARCHAR      AS kmr_kategorie_bez     /* DE=default */
, $3 ::VARCHAR      AS kmr_kategorie_bez_cz 
, $4 ::VARCHAR      AS kmr_kategorie_bez_sk 
, $5 ::VARCHAR      AS kmr_kategorie_bez_hr 
, $6 ::VARCHAR      AS kmr_kategorie_bez_pl 
, $7 ::VARCHAR      AS kmr_kategorie_bez_ro 
, $8 ::VARCHAR      AS kmr_kategorie_bez_bg 
, kmr_kategorie_bez AS kmr_kategorie_bez_de /* not used */
/* 
	Advanced Version mit Sonderzeichen Hairspace + bedingter Trennstrich 
	Einblenden in Notepad++ mit : Menu View > Show Symbol > Show Non-Printing Characters 
*/
FROM(
	SELECT           00, 'Gesamt', 'Celkom', 'Celkom', 'Ukupno', 'Suma', 'Total', 'Обща' 
	UNION ALL SELECT 10, 'Waren­verfügbarkeit Sortiment', 'Dostupnost zboží', 'Dostupnosť tovaru', 'Raspoloživost redovno', 'Dostępność towaru', 'Disponibilitate sortiment', 'Наличност асортимент' 
	UNION ALL SELECT 20, 'Waren­verfügbarkeit Werbung', 'Dostupnost akčního zboží', 'Dostupnosť akcie', 'Raspoloživost reklama', 'Dostępność artykuł reklamowany', 'Disponibilitate promotie', 'Наличие на акция' 
	UNION ALL SELECT 30, 'Waren­frische', 'Čerstvost zboží', 'Čerstvosť tovaru', 'Svježina', 'Świeżość towaru', 'Prospetime', 'Свежест на стоки ' 
	UNION ALL SELECT 40, 'Sauberkeit/ Ordnung/ Hygiene', 'Čistota/ Pořádek/ Hygiena ', 'Čistota/ Poriadok/ Hygiena ', 'Čistoća/ Urednost/ Higijena', 'Czystość/ porządek', 'Curatenie/ Ordine/ Igiena', 'Чистота/ Ред/ Хигиена' 
	UNION ALL SELECT 50, 'Preis­auszeichnung', 'Cenové značení', 'Cenové značenie', 'Isticanje cijena', 'Oznaczenie cenowe', 'Etichetare', 'Ценово обозначаване' 
	UNION ALL SELECT 60, 'Abwicklung/ Funktionalität', 'Odbavení/ Funkčnost', 'Priebeh/ Funkčnosť', 'Odvijanje/ Funkcionalnost', 'Obsługa/ funkcjonalność', 'Derulare/ Functionalitate', 'Дейност/ Функционалност' 
) kmr
;
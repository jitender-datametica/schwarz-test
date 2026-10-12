CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_kurzcheck_kategorie_lu_2(kmr_kategorie_nr, kmr_kategorie_bez, kmr_kategorie_bez_cz, kmr_kategorie_bez_sk, kmr_kategorie_bez_hr, kmr_kategorie_bez_pl, kmr_kategorie_bez_ro, kmr_kategorie_bez_bg, kmr_kategorie_bez_de) AS SELECT
    /*
    	LOOKUP : KMR Kurzcheck Kategorien (ab 2024-08)
    	2024-11-19 ssch0611 : Initial, Extraktion aus FRAGE_TXT [AP0237709]
    	2025-04-04 ssch0611 : Feedback FB. Anpassung Übersetzungen [AP0237709]
    */
    round(KMR.const_0, 0) AS kmr_kategorie_nr,
    kmr_kategorie_bez AS kmr_kategorie_bez,
    /* DE=default */
    substr(KMR.const_Celkom, 1, 16777216) AS kmr_kategorie_bez_cz,
    substr(KMR.const_Celkom, 1, 16777216) AS kmr_kategorie_bez_sk,
    substr(KMR.const_Ukupno, 1, 16777216) AS kmr_kategorie_bez_hr,
    substr(KMR.const_Suma, 1, 16777216) AS kmr_kategorie_bez_pl,
    substr(KMR.const_Total, 1, 16777216) AS kmr_kategorie_bez_ro,
    substr(KMR.`const_Обща`, 1, 16777216) AS kmr_kategorie_bez_bg,
    kmr_kategorie_bez AS KMR_KATEGORIE_BEZ_DE
    /* not used */
    /* 
    	Advanced Version mit Sonderzeichen Hairspace + bedingter Trennstrich 
    	Einblenden in Notepad++ mit : Menu View > Show Symbol > Show Non-Printing Characters 
    */
  FROM
    (
      SELECT
          NUMERIC '0' AS const_0,
          'Gesamt' AS const_Gesamt,
          'Celkom' AS const_Celkom,
          'Celkom' AS const_Celkom_0,
          'Ukupno' AS const_Ukupno,
          'Suma' AS const_Suma,
          'Total' AS const_Total,
          'Обща' AS `const_Обща`
      UNION ALL
      SELECT
          NUMERIC '10' AS const_0,
          'Waren­verfügbarkeit Sortiment' AS const_Gesamt,
          'Dostupnost zboží' AS const_Celkom,
          'Dostupnosť tovaru' AS const_Celkom_0,
          'Raspoloživost redovno' AS const_Ukupno,
          'Dostępność towaru' AS const_Suma,
          'Disponibilitate sortiment' AS const_Total,
          'Наличност асортимент' AS `const_Обща`
      UNION ALL
      SELECT
          NUMERIC '20' AS const_0,
          'Waren­verfügbarkeit Werbung' AS const_Gesamt,
          'Dostupnost akčního zboží' AS const_Celkom,
          'Dostupnosť akcie' AS const_Celkom_0,
          'Raspoloživost reklama' AS const_Ukupno,
          'Dostępność artykuł reklamowany' AS const_Suma,
          'Disponibilitate promotie' AS const_Total,
          'Наличие на акция' AS `const_Обща`
      UNION ALL
      SELECT
          NUMERIC '30' AS const_0,
          'Waren­frische' AS const_Gesamt,
          'Čerstvost zboží' AS const_Celkom,
          'Čerstvosť tovaru' AS const_Celkom_0,
          'Svježina' AS const_Ukupno,
          'Świeżość towaru' AS const_Suma,
          'Prospetime' AS const_Total,
          'Свежест на стоки ' AS `const_Обща`
      UNION ALL
      SELECT
          NUMERIC '40' AS const_0,
          'Sauberkeit/ Ordnung/ Hygiene' AS const_Gesamt,
          'Čistota/ Pořádek/ Hygiena ' AS const_Celkom,
          'Čistota/ Poriadok/ Hygiena ' AS const_Celkom_0,
          'Čistoća/ Urednost/ Higijena' AS const_Ukupno,
          'Czystość/ porządek' AS const_Suma,
          'Curatenie/ Ordine/ Igiena' AS const_Total,
          'Чистота/ Ред/ Хигиена' AS `const_Обща`
      UNION ALL
      SELECT
          NUMERIC '50' AS const_0,
          'Preis­auszeichnung' AS const_Gesamt,
          'Cenové značení' AS const_Celkom,
          'Cenové značenie' AS const_Celkom_0,
          'Isticanje cijena' AS const_Ukupno,
          'Oznaczenie cenowe' AS const_Suma,
          'Etichetare' AS const_Total,
          'Ценово обозначаване' AS `const_Обща`
      UNION ALL
      SELECT
          NUMERIC '60' AS const_0,
          'Abwicklung/ Funktionalität' AS const_Gesamt,
          'Odbavení/ Funkčnost' AS const_Celkom,
          'Priebeh/ Funkčnosť' AS const_Celkom_0,
          'Odvijanje/ Funkcionalnost' AS const_Ukupno,
          'Obsługa/ funkcjonalność' AS const_Suma,
          'Derulare/ Functionalitate' AS const_Total,
          'Дейност/ Функционалност' AS `const_Обща`
    ) AS KMR
    CROSS JOIN UNNEST(ARRAY[
      substr(KMR.const_Gesamt, 1, 16777216)
    ]) AS kmr_kategorie_bez
;

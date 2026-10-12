CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_kurzcheck_frage_lu (kmr_frage_nr, kmr_frage_sort,
kmr_bereich_nr, kmr_kategorie_nr, kmr_frage_bez, kmr_frage_bez_cz, kmr_frage_bez_sk, kmr_frage_bez_hr, kmr_frage_bez_pl
, kmr_frage_bez_ro, kmr_frage_bez_bg, kmr_frage_bez_de) AS SELECT ROUND(CAST(SUBSTR(KMR_FRG.sort_nr, 12, 4) AS BIGNUMERIC)
  , 0) AS kmr_frage_nr,
 ROUND(CAST(SUBSTR(KMR_FRG.sort_nr, 14, 2) || SUBSTR(KMR_FRG.sort_nr, 12, 2) AS BIGNUMERIC), 0) AS kmr_frage_sort,
 ROUND(CAST(SUBSTR(KMR_FRG.sort_nr, 14, 2) AS BIGNUMERIC), 0) AS kmr_bereich_nr,
 ROUND(CAST(SUBSTR(KMR_FRG.sort_nr, 12, 2) AS BIGNUMERIC), 0) AS kmr_kategorie_nr,
 MAX(CASE
   WHEN INSTR(KMR_FRG.frage_text, '//') > 0
   THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), INSTR(KMR_FRG.frage_text, '//') + 3, 255))
   ELSE TRIM(KMR_FRG.frage_text)
   END) AS kmr_frage_bez,
 COALESCE(MAX(CASE
    WHEN SUBSTR(KMR_FRG.sort_nr, 2, 2) = 'CZ'
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), 1, INSTR(KMR_FRG.frage_text, '//') - 1))
    ELSE NULL
    END), MAX(CASE
    WHEN INSTR(KMR_FRG.frage_text, '//') > 0
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), INSTR(KMR_FRG.frage_text, '//') + 3, 255))
    ELSE TRIM(KMR_FRG.frage_text)
    END)) AS kmr_frage_bez_cz,
 COALESCE(MAX(CASE
    WHEN SUBSTR(KMR_FRG.sort_nr, 2, 2) = 'SK'
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), 1, INSTR(KMR_FRG.frage_text, '//') - 1))
    ELSE NULL
    END), MAX(CASE
    WHEN INSTR(KMR_FRG.frage_text, '//') > 0
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), INSTR(KMR_FRG.frage_text, '//') + 3, 255))
    ELSE TRIM(KMR_FRG.frage_text)
    END)) AS kmr_frage_bez_sk,
 COALESCE(MAX(CASE
    WHEN SUBSTR(KMR_FRG.sort_nr, 2, 2) = 'HR'
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), 1, INSTR(KMR_FRG.frage_text, '//') - 1))
    ELSE NULL
    END), MAX(CASE
    WHEN INSTR(KMR_FRG.frage_text, '//') > 0
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), INSTR(KMR_FRG.frage_text, '//') + 3, 255))
    ELSE TRIM(KMR_FRG.frage_text)
    END)) AS kmr_frage_bez_hr,
 COALESCE(MAX(CASE
    WHEN SUBSTR(KMR_FRG.sort_nr, 2, 2) = 'PL'
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), 1, INSTR(KMR_FRG.frage_text, '//') - 1))
    ELSE NULL
    END), MAX(CASE
    WHEN INSTR(KMR_FRG.frage_text, '//') > 0
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), INSTR(KMR_FRG.frage_text, '//') + 3, 255))
    ELSE TRIM(KMR_FRG.frage_text)
    END)) AS kmr_frage_bez_pl,
 COALESCE(MAX(CASE
    WHEN SUBSTR(KMR_FRG.sort_nr, 2, 2) = 'RO'
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), 1, INSTR(KMR_FRG.frage_text, '//') - 1))
    ELSE NULL
    END), MAX(CASE
    WHEN INSTR(KMR_FRG.frage_text, '//') > 0
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), INSTR(KMR_FRG.frage_text, '//') + 3, 255))
    ELSE TRIM(KMR_FRG.frage_text)
    END)) AS kmr_frage_bez_ro,
 COALESCE(MAX(CASE
    WHEN SUBSTR(KMR_FRG.sort_nr, 2, 2) = 'BG'
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), 1, INSTR(KMR_FRG.frage_text, '//') - 1))
    ELSE NULL
    END), MAX(CASE
    WHEN INSTR(KMR_FRG.frage_text, '//') > 0
    THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), INSTR(KMR_FRG.frage_text, '//') + 3, 255))
    ELSE TRIM(KMR_FRG.frage_text)
    END)) AS kmr_frage_bez_bg,
 MAX(CASE
   WHEN INSTR(KMR_FRG.frage_text, '//') > 0
   THEN TRIM(SUBSTR(TRIM(KMR_FRG.frage_text), INSTR(KMR_FRG.frage_text, '//') + 3, 255))
   ELSE TRIM(KMR_FRG.frage_text)
   END) AS kmr_frage_bez_de
FROM kfl_production_dbp_view.v_kmr_frage AS KMR_FRG
 INNER JOIN kfl_production_dbp_view.v_kmr_pruefprogramm_kapitel AS KMR_KAP ON KMR_FRG.kapitel_id = KMR_KAP.kapitel_id
  AND KMR_FRG.amx_system_id = KMR_KAP.amx_system_id
 INNER JOIN kfl_production_dbp_view.v_kmr_pruefung AS KMR_PRF ON KMR_KAP.pruefung_id = KMR_PRF.pruefung_id AND KMR_KAP.amx_system_id
    = KMR_PRF.amx_system_id
WHERE KMR_FRG.amx_system_id = 1
 AND KMR_PRF.pruefung_klasse_id IN (100003)
 AND KMR_PRF.pruefung_status_id IN (100005, 100041)
GROUP BY kmr_frage_nr,
 kmr_frage_sort,
 kmr_bereich_nr,
 kmr_kategorie_nr
UNION ALL
SELECT CAST(a1 AS BIGNUMERIC) AS kmr_frage_nr,
  CAST(a1 AS BIGNUMERIC) * 100 AS kmr_frage_sort,
 CAST(a1 AS BIGNUMERIC) AS kmr_bereich_nr,
 0 AS kmr_kategorie_nr,
 a2 AS kmr_frage_bez,
 a3 AS kmr_frage_bez_cz,
 a4 AS kmr_frage_bez_sk,
 a5 AS kmr_frage_bez_hr,
 a6 AS kmr_frage_bez_pl,
 a7 AS kmr_frage_bez_ro,
 a8 AS kmr_frage_bez_bg,
 a2 AS kmr_frage_bez_de
FROM (SELECT 5 AS a1,
    'Gesamt / Obst & Gemüse' AS a2,
    'Celkom / Ovoce & zelenina' AS a3,
    'Celkom / Ovocie & zelenina' AS a4,
    'Ukupno / Voće i povrće' AS a5,
    'Suma / Owoce/Warzywa' AS a6,
    'Total / Legume & fructe' AS a7,
    'Обща / Плодове и Зеленчуци' AS a8
   UNION ALL
   SELECT 10,
    'Gesamt / To go/Convenience',
    'Celkom / To go/Convenience',
    'Celkom / To go/Convenience',
    'Ukupno / ToGo/Convenience',
    'Suma / To go/dania gotowe',
    'Total / To go/Convenience',
    'Обща / To Go/Convenience'
   UNION ALL
   SELECT 15,
    'Gesamt / Backshop',
    'Celkom / Backshop',
    'Celkom / Pekáreň',
    'Ukupno / Pekara',
    'Suma / Piekarnia',
    'Total / Brutarie',
    'Обща / Пекарна') AS kmr
UNION ALL
SELECT CAST(a1 AS BIGNUMERIC) AS kmr_frage_nr,
 ROUND(CAST(LEFT(SUBSTR(CAST(a1 AS STRING), 1, 10), 2) AS BIGNUMERIC), 0) AS kmr_frage_sort,
 0 AS kmr_bereich_nr,
 ROUND(CAST(LEFT(SUBSTR(CAST(a1 AS STRING), 1, 10), 2) AS BIGNUMERIC), 0) AS kmr_kategorie_nr,
 a2 AS kmr_frage_bez,
 a3 AS kmr_frage_bez_cz,
 a4 AS kmr_frage_bez_sk,
 a5 AS kmr_frage_bez_hr,
 a6 AS kmr_frage_bez_pl,
 a7 AS kmr_frage_bez_ro,
 a8 AS kmr_frage_bez_bg,
 a2 AS kmr_frage_bez_de
FROM (SELECT 1000 AS a1,
    'Warenverfügbarkeit Sortiment / Filiale' AS a2,
    'Dostupnost zboží / Filiálky' AS a3,
    'Dostupnosť tovaru / Filiálky' AS a4,
    'Raspoloživost asortiman / Poslovnica' AS a5,
    'Dostępność towaru / Market' AS a6,
    'Disponibilitate sortiment / Magazin' AS a7,
    'Наличност асортимент / Филиал' AS a8
   UNION ALL
   SELECT 2000,
    'Warenverfügbarkeit Werbung / Filiale',
    'Dostupnost akčního zboží / Filiálky',
    'Dostupnosť akcie / Filiálky',
    'Raspoloživost Reklamnih / Poslovnica',
    'Dostępność artykuł reklamowany / Market',
    'Disponibilitate promotie / Magazin',
    'Наличие на акция / Филиал'
   UNION ALL
   SELECT 3000,
    'Warenfrische / Filiale',
    'Čerstvost zboží / Filiálky',
    'Čerstvosť tovaru / Filiálky',
    'Svježina / Poslovnica',
    'Świeżość towaru / Market',
    'Prospetime / Magazin',
    'Свежест на стоки / Филиал') AS kmr;
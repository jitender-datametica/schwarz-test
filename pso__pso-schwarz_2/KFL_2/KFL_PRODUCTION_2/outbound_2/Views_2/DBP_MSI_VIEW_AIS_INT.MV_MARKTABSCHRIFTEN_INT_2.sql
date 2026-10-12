-- Teil 1: Deutsche Abschriften_2 Markt, ohne Aufschriften

-- Werbeabschriften komplett AP0213409/SPEC0247905 sschuecke 16.09.2024
 -- Aufschriften Menge

-- das sind Aufschriften

-- In DE werden statt 2 Spalten für Ab- und Aufschriften neue "AKZ" eingeführt für Aufschriften, damit es mit KMO zusammenführbar ist.

-- Sebastian Gross, 12.08.2024: AKZ wird hier zu negativen Zahlen umgekehrt. Grund ist dass das AUFschriften sind. Damit es mit KMO passt, können wir das nicht wie im AIS DE über eine_2 eigene Metrik darstellen sondern es müssen eigene AKZ sein.

-- Die View fasst alle bestehenden Views aus AIS DE und AIS KMO rund um Abschriften_2 und Preisänderungen zusammmen. Es gibt im Vergleich dazu einige Änderungen.

-- das sind Aufschriften
 -- Sebastian Gross, 12.08.2024
 -- das sind Aufschriften

-- Werbeabschriften AP0213409/SPEC0247905 sschuecke 16.09.2024

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_marktabschriften_int_2 (mandant_id, wup_id, wup_abschrift_id
, positionsnummer, abschriftenart_id, nb_id, dat, abschriften_menge, art_id, abschriftenbetrag_netto,
abschriftenbetrag_brutto, gp_id, wv_kz, wv_grund_id, umbew_beleg_id, wrg_id, werbeabschrift_pv,
werbeabschrift_werbenachvermarktung_manuell, werbeabschrift_aktionsanpassung_filiale, werbeabschrift_rest) AS SELECT V01
 .mandant_id,
 V01.wup_id,
 V01.wup_abschrift_id,
 V01.positionsnummer_id AS positionsnummer,
 CAST(V01.abschriftart_id AS STRING) AS abschriftenart_id,
 V01.nb_id,
 V01.dat,
  CASE
  WHEN V01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND V01.abschriftart_id <> -1 AND V01.abschriftbetrag_netto
      > 0 OR V01.abschrift_menge_einh_id = 'G' AND V01.abschriftart_id <> -1 AND V01.abschriftbetrag_netto > 0
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
  WHEN V01.abschriftbetrag_netto > 0
  THEN CAST(V01.menge_abschrift AS NUMERIC)
  ELSE NULL
  END AS abschriften_menge,
 V01.art_id,
  CASE
  WHEN V01.abschriftbetrag_netto > 0
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS abschriftenbetrag_netto,
  CASE
  WHEN V01.abschriftbetrag_brutto > 0
  THEN V01.abschriftbetrag_brutto
  ELSE 0
  END AS abschriftenbetrag_brutto,
 COALESCE(v02.gp_id, - 1) AS gp_id,
 V01.wv_kz,
 V01.wv_grund_id,
 0 AS umbew_beleg_id,
 V01.wrg_id -- Werbeabschriften AP0213409/SPEC0247905 sschuecke 16.09.2024
,
 0 AS werbeabschrift_pv,
 0 AS werbeabschrift_werbenachvermarktung_manuell,
 0 AS werbeabschrift_aktionsanpassung_filiale,
 0 AS werbeabschrift_rest
FROM kfl_production_dbp_view.v_marktabschriften_2 AS V01
 LEFT JOIN (SELECT art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis
  FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_2
  WHERE mandant_id = 1) AS v02 ON V01.art_id = v02.art_id AND V01.wup_id = v02.wup_id AND V01.dat BETWEEN v02.dat_von
   AND v02.dat_bis
 INNER JOIN (SELECT art_id,
   gewart_id
  FROM kfl_production_dbp_view.v_art_2
  WHERE mandant_id = 1) AS v03 ON V01.art_id = v03.art_id
WHERE V01.mandant_id = 1
 AND V01.abschriftbetrag_netto > 0
  -- 15.10.2024 sschuecke / Herausfiltern abschriftart_id = -1, da diese  im letzten UNION mit mv_artbew_2 ebenfalls enthalten ist

  
 AND V01.abschriftart_id <> - 1
  -- Sebastian Gross, 12.08.2024 Filterung wichtig, damit die Aufschriften nicht mitkommen (die hätten dann zwar alle Wert 0, wären aber als Zeilen da)

  -- Teil 2: Deutsche Abschriften_2 Lager, ohne Aufschriften

UNION ALL
SELECT mandant_id,
 wup_id,
 lagerbew_beleg_id,
 lagerbew_beleg_pos_id
 /* ,CAST(CASE WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0020') THEN 210
      WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0027') THEN 211
      WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0026') THEN 212
      WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0040') THEN 213
      WHEN lager_bewart_id IN ('V50','V51','V52','V53','W50','W51','W52','W53') AND grund_id IN ('0012') THEN 240
      WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0051') THEN 241
      WHEN lager_bewart_id IN ('V54','V55','V56','V57','W54','W55','W56','W57') AND grund_id IN ('0029') THEN 242
      ELSE NULL END AS STRING) AS LAGER_BEWART_ID */
 ,
 CAST(CASE
   WHEN lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10') AND grund_id IN ('0020')
   THEN 'BA0'
   WHEN lager_bewart_id IN ('V25', 'V26', 'V27', 'V28', 'W25', 'W26', 'W27', 'W28') AND grund_id IN ('0027')
   THEN 'BAA'
   WHEN lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10') AND grund_id IN ('0026')
   THEN 'BAB'
   WHEN lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10') AND grund_id IN ('0040')
   THEN 'BAC'
   WHEN lager_bewart_id IN ('V50', 'V51', 'V52', 'V53', 'W50', 'W51', 'W52', 'W53') AND grund_id IN ('0012')
   THEN 'BD0'
   WHEN lager_bewart_id IN ('V25', 'V26', 'V27', 'V28', 'W25', 'W26', 'W27', 'W28') AND grund_id IN ('0051')
   THEN 'BDA'
   WHEN lager_bewart_id IN ('V54', 'V55', 'V56', 'V57', 'W54', 'W55', 'W56', 'W57') AND grund_id IN ('0029')
   THEN 'BDB'
   ELSE NULL
   END AS STRING) AS lager_bewart_id,
 nb_id,
 dat_buch,
  CASE
  WHEN menge_lagerbew_bme < 0
  THEN menge_lagerbew_bme * - 1
  ELSE NULL
  END AS abschriften_menge,
 art_id,
   CASE
   WHEN betrag_vk_netto_vz < 0
   THEN ROUND(CAST(betrag_vk_netto_vz AS NUMERIC), 2)
   ELSE 0
   END * - 1 AS abschriftenbetrag_netto,
   CASE
   WHEN betrag_verkauf < 0
   THEN CAST(betrag_verkauf AS NUMERIC)
   ELSE 0
   END * - 1 AS abschriftenbetrag_brutto,
 gp_id,
 '' AS wv_kz,
 0 AS wv_grund_id,
 0 AS umbew_beleg_id,
 wrg_id -- Werbeabschriften AP0213409/SPEC0247905 sschuecke 16.09.2024
,
 0 AS werbeabschrift_pv,
 0 AS werbeabschrift_werbenachvermarktung_manuell,
 0 AS werbeabschrift_aktionsanpassung_filiale,
 0 AS werbeabschrift_rest
FROM kfl_production_dbp_view.v_lagerbew_det_2
WHERE lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10', 'V25', 'V26', 'V27', 'V28', 'W25',
   'W26', 'W27', 'W28', 'V50', 'V51', 'V52', 'V53', 'W50', 'W51', 'W52', 'W53', 'V54', 'V55', 'V56', 'V57', 'W54', 'W55'
   , 'W56', 'W57')
 AND grund_id IN ('0020', '0027', '0026', '0040', '0012', '0051', '0029')
 AND mandant_id = 1
 AND betrag_vk_netto_vz < 0
  -- Filterung wichtig, damit die Aufschriften nicht mitkommen (die hätten dann zwar alle Wert 0, wären aber als Zeilen da)

  -- Teil 3: Deutsche AUFschriften Markt

UNION ALL
SELECT V01.mandant_id,
 V01.wup_id,
 V01.wup_abschrift_id,
 V01.positionsnummer_id AS positionsnummer,
 CAST(V01.abschriftart_id * - 1 AS STRING) AS v01_abschriftart_id,
 V01.nb_id,
 V01.dat,
  CASE
  WHEN V01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND V01.abschriftart_id <> -1 AND V01.abschriftbetrag_netto
      < 0 OR V01.abschrift_menge_einh_id = 'G' AND V01.abschriftart_id <> -1 AND V01.abschriftbetrag_netto < 0
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
  WHEN V01.abschriftbetrag_netto < 0
  THEN CAST(V01.menge_abschrift AS NUMERIC)
  ELSE NULL
  END AS abschriften_menge,
 V01.art_id,
  CASE
  WHEN V01.abschriftbetrag_netto < 0
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS abschriftenbetrag_netto,
  CASE
  WHEN V01.abschriftbetrag_brutto < 0
  THEN V01.abschriftbetrag_brutto
  ELSE 0
  END AS abschriftenbetrag_brutto,
 COALESCE(v02.gp_id, - 1) AS gp_id,
 V01.wv_kz,
 V01.wv_grund_id,
 0 AS umbew_beleg_id,
 V01.wrg_id -- Werbeabschriften AP0213409/SPEC0247905 sschuecke 16.09.2024
,
 0 AS werbeabschrift_pv,
 0 AS werbeabschrift_werbenachvermarktung_manuell,
 0 AS werbeabschrift_aktionsanpassung_filiale,
 0 AS werbeabschrift_rest
FROM kfl_production_dbp_view.v_marktabschriften_2 AS V01
 LEFT JOIN (SELECT art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis
  FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_2
  WHERE mandant_id = 1) AS v02 ON V01.art_id = v02.art_id AND V01.wup_id = v02.wup_id AND V01.dat BETWEEN v02.dat_von
   AND v02.dat_bis
 INNER JOIN (SELECT art_id,
   gewart_id
  FROM kfl_production_dbp_view.v_art_2
  WHERE mandant_id = 1) AS v03 ON V01.art_id = v03.art_id
WHERE V01.mandant_id = 1
 AND V01.abschriftbetrag_netto < 0 -- Teil 4 Deutsche AUFschriften Lager

 AND V01.abschriftart_id NOT IN (- 1)
UNION ALL
SELECT mandant_id,
 wup_id,
 lagerbew_beleg_id,
 lagerbew_beleg_pos_id
 /* ,CAST(CASE WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0020') THEN -210
      WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0027') THEN -211
      WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0026') THEN -212
      WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0040') THEN -213
      WHEN lager_bewart_id IN ('V50','V51','V52','V53','W50','W51','W52','W53') AND grund_id IN ('0012') THEN -240
      WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0051') THEN -241
      WHEN lager_bewart_id IN ('V54','V55','V56','V57','W54','W55','W56','W57') AND grund_id IN ('0029') THEN -242
      ELSE NULL END AS STRING) AS LAGER_BEWART_ID */
 ,
 CAST(CASE
   WHEN lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10') AND grund_id IN ('0020')
   THEN 'BA0'
   WHEN lager_bewart_id IN ('V25', 'V26', 'V27', 'V28', 'W25', 'W26', 'W27', 'W28') AND grund_id IN ('0027')
   THEN 'BAA'
   WHEN lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10') AND grund_id IN ('0026')
   THEN 'BAB'
   WHEN lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10') AND grund_id IN ('0040')
   THEN 'BAC'
   WHEN lager_bewart_id IN ('V50', 'V51', 'V52', 'V53', 'W50', 'W51', 'W52', 'W53') AND grund_id IN ('0012')
   THEN 'BD0'
   WHEN lager_bewart_id IN ('V25', 'V26', 'V27', 'V28', 'W25', 'W26', 'W27', 'W28') AND grund_id IN ('0051')
   THEN 'BDA'
   WHEN lager_bewart_id IN ('V54', 'V55', 'V56', 'V57', 'W54', 'W55', 'W56', 'W57') AND grund_id IN ('0029')
   THEN 'BDB'
   ELSE NULL
   END AS STRING) AS lager_bewart_id,
 nb_id,
 dat_buch,
  CASE
  WHEN menge_lagerbew_bme > 0
  THEN menge_lagerbew_bme * - 1
  ELSE NULL
  END,
 art_id,
   CASE
   WHEN betrag_vk_netto_vz > 0
   THEN ROUND(CAST(betrag_vk_netto_vz AS NUMERIC), 2)
   ELSE 0
   END * - 1 -- Aufschriften VK_2 netto
,
   CASE
   WHEN betrag_verkauf > 0
   THEN CAST(betrag_verkauf AS NUMERIC)
   ELSE 0
   END * - 1 -- Aufschriften VK_2 brutto
,
 gp_id,
 '' AS wv_kz,
 0 AS wv_grund_id,
 0 AS umbew_beleg_id,
 wrg_id -- Werbeabschriften AP0213409/SPEC0247905 sschuecke 16.09.2024
,
 0 AS werbeabschrift_pv,
 0 AS werbeabschrift_werbenachvermarktung_manuell,
 0 AS werbeabschrift_aktionsanpassung_filiale,
 0 AS werbeabschrift_rest
FROM kfl_production_dbp_view.v_lagerbew_det_2
WHERE lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10', 'V25', 'V26', 'V27', 'V28', 'W25',
   'W26', 'W27', 'W28', 'V50', 'V51', 'V52', 'V53', 'W50', 'W51', 'W52', 'W53', 'V54', 'V55', 'V56', 'V57', 'W54', 'W55'
   , 'W56', 'W57')
 AND grund_id IN ('0020', '0027', '0026', '0040', '0012', '0051', '0029')
 AND mandant_id = 1
 AND betrag_vk_netto_vz > 0
  -- Sebastian Gross, 12.08.2024: Filterung wichtig, damit die ABschriften_2 nicht mitkommen (die hätten dann zwar alle Wert 0, wären aber als Zeilen da)

  -- KMO komplett

UNION ALL
SELECT v01.mandant_id,
 v01.wup_id,
 v01.wup_abschrift_id,
 v01.positionsnummer_id AS positionsnummer,
 v01.abschriftart_id,
 v01.nb_id,
 v01.dat,
   CASE
   WHEN v01.gewart_id = 'KG'
   THEN CAST(v01.menge_abschrift AS NUMERIC) / 1000
   ELSE CAST(v01.menge_abschrift AS NUMERIC)
   END * - 1 AS abschriften_menge,
 v01.art_id -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
,
  CAST(CASE
    WHEN V2000.wrg_typ_id = 1
    THEN COALESCE(v01.abschriftbetrag_netto, 0)
    WHEN V2000.wrg_typ_id = 0 AND V2000.berichtskurs_typ_id = 0
    THEN COALESCE(v01.abschriftbetrag_netto, 0) * v01.umrechnungskurs_0
    WHEN V2000.wrg_typ_id = 0 AND V2000.berichtskurs_typ_id = 1
    THEN COALESCE(v01.abschriftbetrag_netto, 0) * v01.umrechnungskurs_1
    ELSE NULL
    END AS NUMERIC) * - 1 AS abschriftbetrag_netto,
  CAST(CASE
    WHEN V2000.wrg_typ_id = 1
    THEN COALESCE(v01.abschriftbetrag_brutto, 0)
    WHEN V2000.wrg_typ_id = 0 AND V2000.berichtskurs_typ_id = 0
    THEN COALESCE(v01.abschriftbetrag_brutto, 0) * v01.umrechnungskurs_0
    WHEN V2000.wrg_typ_id = 0 AND V2000.berichtskurs_typ_id = 1
    THEN COALESCE(v01.abschriftbetrag_brutto, 0) * v01.umrechnungskurs_1
    ELSE NULL
    END AS NUMERIC) * - 1 AS abschriftbetrag_brutto,
 COALESCE(v01.gp_id, - 1) AS v01_gp_id,
 '' AS wv_kz,
 0 AS wv_grund_id,
 0 AS umbew_beleg_id,
 '' AS wrg_id,
 0 AS werbeabschrift_pv,
 0 AS werbeabschrift_werbenachvermarktung_manuell,
 0 AS werbeabschrift_aktionsanpassung_filiale,
 0 AS werbeabschrift_rest
FROM (SELECT V01.mandant_id,
    V01.wup_id,
    V01.wup_abschrift_id,
    V01.positionsnummer_id,
    CAST(V01.abschriftart_id AS STRING) AS abschriftart_id,
    V01.nb_id,
    V01.dat,
    V01.menge_abschrift,
    V01.art_id,
    V01.abschriftbetrag_netto,
    V01.abschriftbetrag_brutto,
    V02.gp_id,
    V03.gewart_id,
    V200.umrechnungskurs AS umrechnungskurs_0,
    V300.umrechnungskurs AS umrechnungskurs_1
   FROM kfl_production_dbp_view.v_marktabschriften_2 AS V01
    LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_2 AS V02 ON V01.art_id = V02.art_id AND V01.wup_id = V02.wup_id
      AND V01.mandant_id = V02.mandant_id AND V01.dat BETWEEN V02.dat_von AND V02.dat_bis
    INNER JOIN kfl_production_dbp_view.v_art_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
    INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V01.mandant_id = V100.mandant_id
     -- Umrechnung Standardkurs, Tageskurs

     /* Umrechnung Standardkurs, Tageskurs
   JOIN KFL_PRODUCTION.dbp_view.v_kurs_2 v300
   ON  v01.dat BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR' */
     -- CROSS JOIN aktueller Berichtskurs

    INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V200 ON V200.dat_bis = DATE '9999-12-31' AND V01.wrg_id = V200.von_wrg_id
         AND V200.kurstyp_id = 3 AND V200.nach_wrg_id = 'EUR' -- CROSS JOIN historischer Berichtskurs

    INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V300 ON V01.dat BETWEEN V300.dat_von AND V300.dat_bis AND V01.wrg_id =
        V300.von_wrg_id AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR'
   WHERE V01.abschriftart_id BETWEEN 905 AND 994
    AND V01.mandant_id <> 1
    AND (V01.abschriftart_id <> 955 OR V01.mandant_id <> 2)
   UNION ALL
   SELECT V01.mandant_id,
    V01.wup_id,
    V01.lagerbew_beleg_id,
    V01.lagerbew_beleg_pos_id,
    CAST(CASE
      WHEN V01.lager_bewart_id IN ('Y01', 'Y02')
      THEN 210
      WHEN V01.lager_bewart_id IN ('Y07', 'Y08')
      THEN 211
      WHEN V01.lager_bewart_id IN ('Y11', 'Y12')
      THEN 240
      WHEN V01.lager_bewart_id IN ('Y05', 'Y06')
      THEN 241
      WHEN V01.lager_bewart_id IN ('Y35', 'Y36')
      THEN 242
      ELSE NULL
      END AS STRING) AS lager_bewart_id,
    V01.nb_id,
    V01.dat_buch,
     CASE
     WHEN V03.gewart_id = 'KG'
     THEN V01.menge_lagerbew_bme * 1000
     ELSE V01.menge_lagerbew_bme
     END AS menge,
    V01.art_id,
    V01.betrag_vk_netto_vz,
    V01.betrag_verkauf,
    V01.gp_id,
    V03.gewart_id,
    V200.umrechnungskurs AS umrechnungskurs_0,
    V300.umrechnungskurs AS umrechnungskurs_1
   FROM kfl_production_dbp_view.v_lagerbew_det_2 AS V01
    INNER JOIN kfl_production_dbp_view.v_art_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
      /* JOIN KFL_PRODUCTION.dbp_view.v_kurs_2 v300
 ON  v01.dat_buch BETWEEN v300.dat_von AND v300.dat_bis
 AND v01.wrg_id = v300.von_wrg_id
 AND v300.kurstyp_id = 9
 AND v300.nach_wrg_id ='EUR' */
      -- CROSS JOIN aktueller Berichtskurs

    INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V200 ON V200.dat_bis = DATE '9999-12-31' AND V01.wrg_id = V200.von_wrg_id
         AND V200.kurstyp_id = 3 AND V200.nach_wrg_id = 'EUR' -- CROSS JOIN historischer Berichtskurs

    INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V300 ON V01.dat_buch BETWEEN V300.dat_von AND V300.dat_bis AND V01.wrg_id
         = V300.von_wrg_id AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR'
   WHERE V01.lager_bewart_id IN ('Y01', 'Y02', 'Y07', 'Y08', 'Y11', 'Y12', 'Y05', 'Y06', 'Y35', 'Y36')
    AND V01.mandant_id <> 1) AS v01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V2000 ON TRUE
UNION ALL
SELECT mandant_id,
 wup_id,
 0 AS wup_abschrift_id,
 0 AS positionsnummer,
 '' AS abschriftenart_id,
 nb_id,
 dat,
 0 AS abschriften_menge,
 art_id,
 0 AS abschriftenbetrag_netto,
 0 AS abschriftenbetrag_brutto,
 gp_id,
 '' AS wv_kz,
 0 AS wv_grund_id,
 0 AS umbew_beleg_id,
 wrg_2 AS wrg_id,
 werbeabschrift_pv,
 werbeabschrift_werbenachvermarktung_manuell,
 werbeabschrift_aktionsanpassung_filiale,
 werbeabschrift_rest
FROM kfl_production_dbp_msi_view_ais_int.mv_artbew_2;
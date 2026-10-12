-- 21.11.2013 twie: in CZ menge_erf statt menge_umbew als menge_abschrift nehmen und nicht durch 1000 teilen wie in DE

-- Landesbeleg in Euro wird in Landeswaehrung angezeigt

-- 27.09.2013 twie: Abschriften_1 aus CZ, kommen aus anderer Tabelle

-- 15.11.2017 twie: NSR0027844 in DE sind Ab/aufschriften mit abschriftart_id -1 Werbeabschriften, die im Gegensatz zu normalen Abschriften_1 in KG - nicht in Gramm - erfasst werden, deshalb duerfen sie nicht durch 1000 geteilt werden

-- MARA_1 + Retailartikel
 -- 26.10.2011 system_id entfernt
 -- Landesbeleg in Landeswaehrung wird in Euro angezeigt

-- 29.01.2014 twie: Waehrungsumrechnung fuer Teil 1 mit CZ, bei Teil 2 DE nicht noetig, da eh immer Euro

-- Landesbeleg in Landeswaehrung wird in Euro angezeigt

-- 22.07.2021 twie: SPEC0109216 ab/aufschriften_menge wird bei KG Artikeln nicht mehr ausschließlich in G erfassst (Division durch 1000) sondern teilweise direkt in KG, in diesem Fall entfällt /1000

-- 07.10.2013 twie: Brutto in Nettobetrag umrechnen fuer CZ abschriftenbetrag

-- Landesbeleg in Landeswaehrung wird in Euro angezeigt

-- 11.07.2017 twie: SPEC0015191 Datentyp aufschriften auf decimal umgestellt
 -- Abschriften_1 aus DE

-- Landesbeleg in Euro wird in Landeswaehrung angezeigt
 -- Landesbeleg in Euro wird in Landeswaehrung angezeigt

-- 21.10.2013 twie: CROSS JOIN auf in_art_1 jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen

-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

-- 23.06.2017 twie: SPEC0015191 Aufschriften fuer DE hinzufuegen, vk_netto_neu entfernt da nicht mehr benutzt

-- 16.10.2013 twie: CROSS JOIN auf in_kunde_1 vereinfacht ueber wup_id

-- 19.11.2013: MCan: Performanceoptimierung --> Umstellung von UNION auf UNION ALL

-- Landesbeleg in Landeswaehrung wird in Euro angezeigt
 -- Landesbeleg in Landeswaehrung wird in Euro angezeigt

-- 30.11.2011 MR Performance art_id Verbindung
 -- Landesbeleg in Euro wird in Landeswaehrung angezeigt

-- CROSS JOIN auf art_gp_zu_per_1 entfernt
 -- Angepasst Alex Lipkin

-- 14.09.2011 A. Lipkin menge_abschrift   hinzugefuegt
 -- * -1 da VZ in Fakt wieder gedreht wird

-- 26.08.2015 twie: fuer abschriftbetrag_netto in CZ nicht den vk_netto_neu, sondern diff_wert_bestand_netto nehmen

-- Landesbeleg in Euro wird in Landeswaehrung angezeigt

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_marktabschriften_1 AS SELECT V01.mandant_id,
 V01.in_kunde_id,
 V01.kunde_nr,
 V01.kunde_name,
 V01.dat,
 V01.in_art_id,
 V01.in_art_nr,
 V01.abschriften_fg,
 V01.aufschriften_fg,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.diff_wert_bestand_netto * - 1, 0)
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_netto * - 1, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.diff_wert_bestand_netto * - 1, 0) * V500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_netto * - 1, 0)
   ELSE NULL
   END AS NUMERIC) AS abschriftbetrag_netto,
 0 AS aufschriftbetrag_netto,
 CAST(V01.menge_erf AS NUMERIC) AS menge_abschrift,
 0 AS menge_aufschrift,
 V01.preis_aend_grund_id AS abschriftart_id,
 V01.umbew_beleg_id,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.wert_bestand_brutto_alt, 0)
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.wert_bestand_brutto_alt, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.wert_bestand_brutto_alt, 0) * V500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.wert_bestand_brutto_alt, 0)
   ELSE NULL
   END AS NUMERIC) AS wert_bestand_brutto_alt,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.diff_wert_bestand_brutto, 0)
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_brutto, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.diff_wert_bestand_brutto, 0) * V500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_brutto, 0)
   ELSE NULL
   END AS NUMERIC) AS diff_wert_bestand_brutto,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.diff_wert_bestand_netto, 0)
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_netto, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.diff_wert_bestand_netto, 0) * V500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_netto, 0)
   ELSE NULL
   END AS NUMERIC) AS diff_wert_bestand_netto,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.vk_brutto_alt, 0)
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.vk_brutto_alt, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.vk_brutto_alt, 0) * V500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.vk_brutto_alt, 0)
   ELSE NULL
   END AS NUMERIC) AS vk_brutto_alt,
 V01.menge_erf,
 V01.menge_bestand_bme,
 V400.wrg_id
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_marktabschriften_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
  AND V01.dat BETWEEN V500.dat_von AND V500.dat_bis
WHERE V500.nach_wrg_id = 'EUR'
 AND V01.mandant_id = 2
UNION ALL
SELECT V01.mandant_id,
 V07.flw_kunde_id AS in_kunde_id,
 COLLATE(LTRIM(COLLATE(V07.kunde_nr, ''), '0'), 'und:ci') AS kunde_nr,
 V07.kunde_name,
 V01.dat,
 V05.flw_art_id AS in_art_id,
 V05.in_art_nr,
  CASE
  WHEN V01.abschriftbetrag_netto > 0
  THEN 1
  ELSE NULL
  END AS abschriften_fg,
  CASE
  WHEN V01.abschriftbetrag_netto < 0
  THEN 1
  ELSE NULL
  END AS aufschriften_fg,
  V01.abschriftbetrag_netto * CASE
   WHEN V01.abschriftbetrag_netto > 0
   THEN 1
   ELSE NULL
   END AS abschriftbetrag_netto,
  V01.abschriftbetrag_netto * CASE
   WHEN V01.abschriftbetrag_netto < 0
   THEN 1
   ELSE NULL
   END AS aufschriftbetrag_netto,
  CASE
  WHEN V04.gewart_id = 'KG' AND V01.abschrift_menge_einh_id = 'G' AND V01.abschriftart_id <> - 1
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000 * CASE
    WHEN V01.abschriftbetrag_netto > 0
    THEN 1
    ELSE NULL
    END
  ELSE CAST(V01.menge_abschrift AS NUMERIC) * CASE
    WHEN V01.abschriftbetrag_netto > 0
    THEN 1
    ELSE NULL
    END
  END AS menge_abschrift,
  CASE
  WHEN V04.gewart_id = 'KG' AND V01.abschrift_menge_einh_id = 'G' AND V01.abschriftart_id <> - 1
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000 * CASE
    WHEN V01.abschriftbetrag_netto < 0
    THEN 1
    ELSE NULL
    END
  ELSE CAST(V01.menge_abschrift AS NUMERIC) * CASE
    WHEN V01.abschriftbetrag_netto < 0
    THEN 1
    ELSE NULL
    END
  END AS menge_aufschrift,
 V01.abschriftart_id,
 - 1 AS umbew_beleg_id,
 CAST(NULL AS NUMERIC) AS wert_bestand_brutto_alt,
 CAST(NULL AS NUMERIC) AS diff_wert_bestand_brutto,
 CAST(NULL AS NUMERIC) AS diff_wert_bestand_netto,
 CAST(NULL AS NUMERIC) AS vk_brutto_alt,
 CAST(NULL AS NUMERIC) AS menge_erf,
 CAST(NULL AS NUMERIC) AS menge_bestand_bme,
 V01.wrg_id
FROM kfl_production_dbp_view.v_marktabschriften_1 AS V01
 INNER JOIN (SELECT art_id,
   gewart_id
  FROM kfl_production_dbp_view.v_art_1
  WHERE mandant_id = 1) AS v03 ON V01.art_id = v03.art_id
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id AND V01
   .dat BETWEEN V04.dat_von AND V04.dat_bis
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_in_art_1 AS V05 ON V04.art_id = V05.art_id AND V04.mandant_id = V05.mandant_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde_1 AS V07 ON V01.wup_id = V07.wup_id AND V01.mandant_id = V07.mandant_id
WHERE V01.mandant_id = 1;


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_marktabschriften_1 (mandant_id, in_kunde_id,
kunde_nr, kunde_name, dat, in_art_id, in_art_nr, abschriften_fg, aufschriften_fg, abschriftbetrag_netto,
aufschriftbetrag_netto, menge_abschrift, menge_aufschrift, abschriftart_id, umbew_beleg_id, wert_bestand_brutto_alt,
diff_wert_bestand_brutto, diff_wert_bestand_netto, vk_brutto_alt, menge_erf, menge_bestand_bme, wrg_id) AS SELECT V01.mandant_id
 ,
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
   THEN COALESCE(V01.diff_wert_bestand_netto * -1, 0)
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_netto * -1, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.diff_wert_bestand_netto * -1, 0) * V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_netto * -1, 0)
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
   THEN COALESCE(V01.wert_bestand_brutto_alt, 0) * V500.umrechnungskurs
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
   THEN COALESCE(V01.diff_wert_bestand_brutto, 0) * V500.umrechnungskurs
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
   THEN COALESCE(V01.diff_wert_bestand_netto, 0) * V500.umrechnungskurs
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
   THEN COALESCE(V01.vk_brutto_alt, 0) * V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.vk_brutto_alt, 0)
   ELSE NULL
   END AS NUMERIC) AS vk_brutto_alt,
 V01.menge_erf,
 V01.menge_bestand_bme,
 V400.wrg_id
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_marktabschriften_1 AS V01
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
  WHEN V04.gewart_id = 'KG' AND V01.abschrift_menge_einh_id = 'G' AND V01.abschriftart_id <> -1
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
  WHEN V04.gewart_id = 'KG' AND V01.abschrift_menge_einh_id = 'G' AND V01.abschriftart_id <> -1
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
 -1 AS umbew_beleg_id,
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
 INNER JOIN kfl_production_dbp_msi_view_flw_materialized.mv_l_in_art_1 AS V05 ON V04.art_id = V05.art_id AND V04.mandant_id
    = V05.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde_1 AS V07 ON V01.wup_id = V07.wup_id AND V01.mandant_id = V07.mandant_id
WHERE V01.mandant_id = 1;


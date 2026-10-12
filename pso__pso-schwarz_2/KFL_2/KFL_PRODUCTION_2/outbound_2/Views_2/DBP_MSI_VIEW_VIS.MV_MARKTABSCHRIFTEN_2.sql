CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_marktabschriften_2 (mandant_id, nb_id, wup_id, wrg_id, dat,
art_id, abschriftart_id, gewart_id, abschrift_netto, abschrift_brutto, abschrift_menge, menge_abschrift, m_absch_menge,
m_aufsch_menge, abschriftbetrag_netto, aufschriftbetrag_netto, wup_abschrift_id, positionsnummer_id, lastupd_dat,
woche_id, ereignistyp_id, ereignis_id) AS SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 krs.nach_wrg_id AS wrg_id,
 V01.dat,
 V01.art_id,
 V01.abschriftart_id,
 v03.gewart_id,
  V01.abschriftbetrag_netto * krs.umrechnungskurs AS abschrift_netto,
  V01.abschriftbetrag_brutto * krs.umrechnungskurs AS abschrift_brutto,
  CASE
  WHEN V01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND V01.abschriftart_id <> -1 OR V01.abschrift_menge_einh_id
      = 'G' AND V01.abschriftart_id <> -1
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
  ELSE CAST(V01.menge_abschrift AS NUMERIC)
  END AS abschrift_menge,
 V01.menge_abschrift,
  CASE
  WHEN V01.abschriftbetrag_netto > 0
  THEN CASE
   WHEN V01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND V01.abschriftart_id <> -1 OR V01.abschrift_menge_einh_id
       = 'G' AND V01.abschriftart_id <> -1
   THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
   ELSE CAST(V01.menge_abschrift AS NUMERIC)
   END
  ELSE NULL
  END AS m_absch_menge,
   CASE
   WHEN V01.abschriftbetrag_netto < 0
   THEN CASE
    WHEN V01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND V01.abschriftart_id <> -1 OR V01.abschrift_menge_einh_id
        = 'G' AND V01.abschriftart_id <> -1
    THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
    ELSE CAST(V01.menge_abschrift AS NUMERIC)
    END
   ELSE NULL
   END * - 1 AS m_aufsch_menge,
   CASE
   WHEN V01.abschriftbetrag_netto > 0
   THEN V01.abschriftbetrag_netto
   ELSE NULL
   END * krs.umrechnungskurs AS abschriftbetrag_netto,
   CASE
   WHEN V01.abschriftbetrag_netto < 0
   THEN V01.abschriftbetrag_netto
   ELSE NULL
   END * krs.umrechnungskurs AS aufschriftbetrag_netto,
 V01.wup_abschrift_id,
 V01.positionsnummer_id,
 V01.lastupd_dat,
 V01.woche_id,
 102 AS ereignistyp_id,
 - 1 AS ereignis_id
FROM kfl_production_dbp_view.v_marktabschriften_2 AS V01
 INNER JOIN (SELECT mandant_id,
   art_id,
   gewart_id
  FROM kfl_production_dbp_view.v_art_2) AS v03 ON V01.art_id = v03.art_id AND V01.mandant_id = v03.mandant_id
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_2 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_2 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON V01.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id
UNION ALL
SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 krs.nach_wrg_id AS wrg_id,
 V01.dat_umbew AS dat,
 V01.art_id,
 V01.preis_aend_grund_id AS abschriftart_id,
 '0' AS gewart_id,
  V01.diff_wert_bestand_netto * krs.umrechnungskurs AS abschrift_netto,
  V01.diff_wert_bestand_brutto * krs.umrechnungskurs AS abschrift_brutto,
   CASE
   WHEN V01.preis_aend_grund_id IN (10, 20) OR V01.wert_bestand_brutto_alt < 0 AND V01.menge_bestand_bme < 0 AND V01.menge_umbew
       = 0
   THEN - 1
   ELSE 1
   END * V01.menge_erf AS abschrift_menge,
 V01.menge_erf AS menge_abschrift,
 0 AS m_absch_menge,
 0 AS m_aufsch_menge,
 0 AS abschriftbetrag_netto,
 0 AS aufschriftbetrag_netto,
 0 AS wup_abschrift_id,
 0 AS positionsnummer_id,
 V01.dat_umbew AS lastupd_dat,
 0 AS woche_id,
 102 AS ereignistyp_id,
 - 1 AS ereignis_id
FROM kfl_production_dbp_view.v_art_umbewertung_2 AS V01
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_2 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_2 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON V01.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id
WHERE V01.mandant_id IN (2, 5) AND V01.preis_aend_grund_id IN (7, 10, 20, 26)
 OR V01.mandant_id IN (3) AND V01.preis_aend_grund_id IN (11, 20, 26)
 OR V01.mandant_id IN (6) AND V01.preis_aend_grund_id IN (2, 20, 26)
 OR V01.mandant_id IN (4, 7, 8) AND V01.preis_aend_grund_id IN (7, 20, 26);
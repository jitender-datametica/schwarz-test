CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_marktabschriften (mandant_id, wup_id, wup_abschrift_id,
positionsnummer_id, abschriftart_id, nb_id, dat, woche_id, absch_menge, art_id, gp_id, lastupd_dat,
abschriftbetrag_netto, abschriftbetrag_brutto, posten_kz_per) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.wup_abschrift_id,
 V01.positionsnummer_id,
 V01.abschriftart_id,
 V01.nb_id,
 V01.dat,
 V01.woche_id,
   CASE
   WHEN V01.abschrift_menge_einh_id = 'G'
   THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
   ELSE CAST(V01.menge_abschrift AS NUMERIC)
   END * - 1 AS absch_menge,
 V01.art_id,
 V04.gp_id,
 V01.lastupd_dat,
  CASE
  WHEN V2.wrg_typ_id = 0 AND V2.berichtskurs_typ_id = 0
  THEN ROUND(CAST(V01.abschriftbetrag_netto * V300.umrechnungskurs AS NUMERIC), 6)
  WHEN V2.wrg_typ_id = 0 AND V2.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.abschriftbetrag_netto * V400.umrechnungskurs AS NUMERIC), 6)
  ELSE CAST(V01.abschriftbetrag_netto AS NUMERIC)
  END AS abschriftbetrag_netto,
  CASE
  WHEN V2.wrg_typ_id = 0 AND V2.berichtskurs_typ_id = 0
  THEN ROUND(CAST(V01.abschriftbetrag_brutto * V300.umrechnungskurs AS NUMERIC), 6)
  WHEN V2.wrg_typ_id = 0 AND V2.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.abschriftbetrag_brutto * V400.umrechnungskurs AS NUMERIC), 6)
  ELSE CAST(V01.abschriftbetrag_brutto AS NUMERIC)
  END AS abschriftbetrag_brutto,
 SUBSTR(CASE
   WHEN V05.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_marktabschriften AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V2 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V300 ON V300.dat_bis = DATE '9999-12-31' AND V01.wrg_id = V300.von_wrg_id
   AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_kurs AS V400 ON V01.dat BETWEEN V400.dat_von AND V400.dat_bis AND V01.wrg_id =
     V400.von_wrg_id AND V400.kurstyp_id = 3 AND V400.nach_wrg_id = 'EUR'
 LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS V04 ON V01.art_id = V04.art_id AND V01.wup_id = V04.wup_id AND
    V01.mandant_id = V04.mandant_id AND V01.dat BETWEEN V04.dat_von AND V04.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_per AS V05 ON V01.art_id = V05.art_id AND V01.mandant_id = V05.mandant_id AND
    V01.dat BETWEEN DATE_SUB(V05.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V05.dat_bis, INTERVAL 1 DAY)) AND (V01.abschriftart_id
      <> 955 OR V01.mandant_id <> 2)
WHERE V01.mandant_id <> 1
UNION ALL
SELECT V01.mandant_id,
 V01.wup_id,
 V01.wup_abschrift_id,
 V01.positionsnummer_id,
 V01.abschriftart_id,
 V01.nb_id,
 V01.dat,
 V01.woche_id,
  CASE
  WHEN V01.abschrift_menge_einh_id = 'G' AND V01.abschriftart_id <> -1
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
  ELSE CAST(V01.menge_abschrift AS NUMERIC)
  END AS absch_menge,
 V01.art_id,
 V04.gp_id,
 V01.lastupd_dat,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.abschriftbetrag_netto * V3.umrechnungskurs AS NUMERIC), 6)
  ELSE CAST(V01.abschriftbetrag_netto AS NUMERIC)
  END AS abschriftbetrag_netto,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.abschriftbetrag_brutto * V3.umrechnungskurs AS NUMERIC), 6)
  ELSE CAST(V01.abschriftbetrag_brutto AS NUMERIC)
  END AS abschriftbetrag_brutto,
 SUBSTR(CASE
   WHEN V05.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_marktabschriften AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V2 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V3 ON V01.dat BETWEEN V3.dat_von AND V3.dat_bis AND V01.wrg_id = V3.von_wrg_id
      AND V3.kurstyp_id = 9 AND V3.nach_wrg_id = 'EUR'
 LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS V04 ON V01.art_id = V04.art_id AND V01.wup_id = V04.wup_id AND
    V01.mandant_id = V04.mandant_id AND V01.dat BETWEEN V04.dat_von AND V04.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_per AS V05 ON V01.art_id = V05.art_id AND V01.mandant_id = V05.mandant_id AND
   V01.dat BETWEEN DATE_SUB(V05.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V05.dat_bis, INTERVAL 1 DAY))
WHERE V01.mandant_id = 1;
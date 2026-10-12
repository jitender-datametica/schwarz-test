CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_marktabschriften_wg_sum (mandant_id, wup_id, nb_id,
abschriftart_id, wg_id, arthiertyp_id, dat, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id) AS SELECT V01.mandant_id
 ,
 V01.wup_id,
 V01.nb_id,
 V01.abschriftart_id,
 V01.wg_id,
 V01.arthiertyp_id,
 V01.dat,
  CAST(CASE
    WHEN V200.wrg_typ_id = 1
    THEN COALESCE(V01.abschriftbetrag_netto, 0)
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN COALESCE(V01.abschriftbetrag_netto, 0) * V300.umrechnungskurs
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN COALESCE(V01.abschriftbetrag_netto, 0) * V400.umrechnungskurs
    ELSE NULL
    END AS NUMERIC) * - 1 AS abschriftbetrag_netto,
  CAST(CASE
    WHEN V200.wrg_typ_id = 1
    THEN COALESCE(V01.abschriftbetrag_brutto, 0)
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN COALESCE(V01.abschriftbetrag_brutto, 0) * V300.umrechnungskurs
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN COALESCE(V01.abschriftbetrag_brutto, 0) * V400.umrechnungskurs
    ELSE NULL
    END AS NUMERIC) * - 1 AS abschriftbetrag_brutto,
 V01.wrg_id
FROM kfl_production_dbp_view.v_marktabschriften_wg_sum AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V300 ON V01.wrg_id = V300.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs AS V400 ON V01.dat BETWEEN V400.dat_von AND V400.dat_bis AND V01.wrg_id =
   V400.von_wrg_id
WHERE V400.kurstyp_id = 3
 AND V400.nach_wrg_id = 'EUR'
 AND V300.dat_bis = DATE '9999-12-31'
 AND V300.kurstyp_id = 3
 AND V300.nach_wrg_id = 'EUR'
 AND V01.mandant_id <> 1
 AND V01.abschriftart_id > 900;
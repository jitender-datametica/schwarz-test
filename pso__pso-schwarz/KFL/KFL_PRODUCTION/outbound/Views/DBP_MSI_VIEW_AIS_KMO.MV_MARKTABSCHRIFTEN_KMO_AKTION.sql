CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_marktabschriften_kmo_aktion (wup_id, nb_id, aktion_id,
mandant_id, dat, art_id, menge_abschrift, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id) AS SELECT V01.wup_id,
 V01.nb_id,
 V01.aktion_id,
 V01.mandant_id,
 V01.dat,
 V01.art_id,
 V01.menge_abschrift,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.abschriftbetrag_netto, 0)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.abschriftbetrag_netto, 0) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.abschriftbetrag_netto, 0) * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS abschriftbetrag_netto,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.abschriftbetrag_brutto, 0)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.abschriftbetrag_brutto, 0) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.abschriftbetrag_brutto, 0) * V400.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS abschriftbetrag_brutto,
 V01.wrg_id
FROM kfl_production_dbp_view.v_marktabschriften_kmo_aktion AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V300 ON V100.default_wrg = V300.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs AS V400 ON V01.dat BETWEEN V400.dat_von AND V400.dat_bis AND V100.default_wrg
    = V400.von_wrg_id
WHERE V400.kurstyp_id = 3
 AND V400.nach_wrg_id = 'EUR'
 AND V300.dat_bis = DATE '9999-12-31'
 AND V300.kurstyp_id = 3
 AND V300.nach_wrg_id = 'EUR'
 AND V01.mandant_id > 1
 AND V01.aktion_relevant_fg = 1;
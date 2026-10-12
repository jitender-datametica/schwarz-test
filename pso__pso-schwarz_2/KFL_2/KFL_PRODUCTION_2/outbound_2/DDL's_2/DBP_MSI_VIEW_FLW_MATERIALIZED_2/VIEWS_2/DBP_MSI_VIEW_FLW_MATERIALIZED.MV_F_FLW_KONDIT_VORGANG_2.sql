CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_kondit_vorgang_2 (mandant_id,
beleg_kondition_id, beleg_kondition_pos_id, beleg_konditionsart_id, betrag_beleg_kondition, werk_id, loesch_id,
best_beleg_pos_id, best_beleg_id, in_art_id, in_lief_id) AS SELECT V01.mandant_id,
 V01.beleg_kondition_id,
 V01.beleg_kondition_pos_id,
 V01.beleg_konditionsart_id,
  CASE
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.betrag_beleg_kondition
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
  THEN V01.betrag_beleg_kondition / V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.betrag_beleg_kondition * V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
  THEN V01.betrag_beleg_kondition
  ELSE NULL
  END AS betrag_beleg_kondition,
 V01.werk_id,
 V01.loesch_id,
 V01.best_beleg_pos_id,
 V01.best_beleg_id,
 V01.in_art_id,
 V01.in_lief_id
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_flw_kondit_vorgang_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_lief_wunsch BETWEEN V500.dat_von AND V500.dat_bis;
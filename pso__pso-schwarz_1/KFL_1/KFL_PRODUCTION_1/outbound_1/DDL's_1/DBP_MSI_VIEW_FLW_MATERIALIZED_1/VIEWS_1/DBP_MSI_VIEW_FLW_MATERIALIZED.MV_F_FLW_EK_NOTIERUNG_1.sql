CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_ek_notierung_1 (mandant_id, ek_notierung_id,
dat, plan_fg, pjwo, betrag, wrg_id) AS SELECT V01.mandant_id,
 V01.ek_notierung_id,
 V01.dat,
 V01.plan_fg,
 V01.pjwo,
  CASE
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.betrag
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
  THEN V01.betrag / V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.betrag * V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
  THEN V01.betrag
  ELSE NULL
  END AS betrag,
 V400.wrg_id
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_flw_ek_notierung_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
   AND V500.nach_wrg_id = 'EUR' AND V01.dat BETWEEN V500.dat_von AND V500.dat_bis;
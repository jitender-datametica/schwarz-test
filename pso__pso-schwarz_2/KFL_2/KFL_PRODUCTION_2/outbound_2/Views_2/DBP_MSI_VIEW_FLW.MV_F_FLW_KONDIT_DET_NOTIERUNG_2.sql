CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_kondit_det_notierung_2 AS SELECT V01.mandant_id,
 V01.werk_id,
 V01.flw_lief_id AS in_lief_id,
 V01.flw_art_id AS in_art_id,
 V01.loesch_fg,
 V01.konditionsart_id,
 V01.dat_von,
 V01.dat,
 V01.kondition_id,
  CASE
  WHEN V01.kondition_einh_id <> V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.betrag_kondition
  WHEN V01.kondition_einh_id <> V01.default_wrg AND V200.wrg_typ_id = 1
  THEN V01.betrag_kondition / V500.umrechnungskurs
  WHEN V01.kondition_einh_id = V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V01.betrag_kondition * V500.umrechnungskurs
  WHEN V01.kondition_einh_id = V01.default_wrg AND V200.wrg_typ_id = 1
  THEN V01.betrag_kondition
  ELSE NULL
  END AS betrag_kondition,
 V01.fleisch_kategorie_id,
 V01.kpi_kategorie_id
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_kondit_det_notierung_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.kondition_einh_id = V500
     .von_wrg_id AND V500.nach_wrg_id = 'EUR' AND V01.dat BETWEEN V500.dat_von AND V500.dat_bis;
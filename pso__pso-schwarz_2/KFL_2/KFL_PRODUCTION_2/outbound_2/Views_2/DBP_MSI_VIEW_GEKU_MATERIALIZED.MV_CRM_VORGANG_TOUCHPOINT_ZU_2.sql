CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_crm_vorgang_touchpoint_zu_2 (mandant_id,
crm_vorgang_id, touchpoint_id, touchpoint_count, touchpoint_fg, dat_start, dat_ende, dat_start_processing,
dat_end_processing, sec_kz) AS SELECT V01.mandant_id,
 V01.crm_vorgang_id,
 V01.touchpoint_id,
 V01.touchpoint_count,
  CASE
  WHEN V01.touchpoint_count > 0
  THEN 1
  ELSE 0
  END AS touchpoint_fg,
 DATE(V02.dat_start) AS dat_start,
 DATE(V02.dat_ende) AS dat_ende,
 DATE(V02.dat_start_processing) AS dat_start_processing,
 DATE(V02.dat_end_processing) AS dat_end_processing,
 3 AS sec_kz
FROM kfl_production_dbp_view.v_crm_vorgang_touchpoint_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_crm_vorgang_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.crm_vorgang_id = V02
   .crm_vorgang_id;
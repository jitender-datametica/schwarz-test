-- 02.05.2024 twie: SPEC0247600 neue Datumsfelder aus Vorgang
 -- staeblern AP0097264 SPEC0134521 initiale Anlage_2

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_crm_vorgang_touchpoint_zu_2 (mandant_id, crm_vorgang_id,
touchpoint_id, touchpoint_count, touchpoint_fg, dat_start, dat_ende, dat_start_processing, dat_end_processing, sec_kz)
AS SELECT v01.mandant_id,
 v01.crm_vorgang_id,
 v01.touchpoint_id,
 v01.touchpoint_count,
  CASE
  WHEN v01.touchpoint_count > 0
  THEN 1
  ELSE 0
  END AS touchpoint_fg,
 DATE(v02.dat_start) AS dat_start,
 DATE(v02.dat_ende) AS dat_ende,
 DATE(v02.dat_start_processing) AS dat_start_processing,
 DATE(v02.dat_end_processing) AS dat_end_processing,
 3 AS sec_kz
FROM kfl_production_dbp_view.v_crm_vorgang_touchpoint_zu_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_crm_vorgang_2 AS v02 ON v01.mandant_id = v02.mandant_id AND v01.crm_vorgang_id = v02
   .crm_vorgang_id;
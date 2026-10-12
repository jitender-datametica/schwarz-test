CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_struktur_ker_2 AS SELECT ker_lv,
 ker_id,
 spr_id,
 ker_bez,
 SUBSTR(CAST(SUBSTR(ker_id, 1, 2) AS STRING), 1, 10) AS ker_grp_id,
 CAST(SUBSTR(ker_id, 1, 2) AS STRING) AS ker_grp_bez
FROM kfl_production_dbp_msi_v_view.v_vis_struktur_ker_2 AS V01;
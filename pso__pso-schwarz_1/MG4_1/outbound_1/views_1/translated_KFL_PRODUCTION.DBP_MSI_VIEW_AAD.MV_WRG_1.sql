-- 21.06.2023 snik: SPEC0200569 WRG_1
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_wrg_1 (wrg_id, wrg_bez) AS SELECT wrg_id,
 wrg_bez
FROM kfl_production_dbp_view.v_wrg_1 AS v01;
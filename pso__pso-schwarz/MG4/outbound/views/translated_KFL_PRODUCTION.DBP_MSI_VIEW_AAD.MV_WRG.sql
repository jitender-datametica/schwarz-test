-- 21.06.2023 snik: SPEC0200569 WRG
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_wrg (wrg_id, wrg_bez) AS SELECT wrg_id,
 wrg_bez
FROM kfl_production_dbp_view.v_wrg AS v01;
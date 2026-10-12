CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_bvv_akte_1 (bvv_akte_id, mandant_id, bvv_vertrag_nr,
dat_vertrag_beginn) AS SELECT DISTINCT bvv_akte_id,
 mandant_id,
 bvv_vertrag_nr,
 dat_vertrag_beginn
FROM kfl_production_dbp_view.v_ivs_l_bvv_akte_1 AS V01;
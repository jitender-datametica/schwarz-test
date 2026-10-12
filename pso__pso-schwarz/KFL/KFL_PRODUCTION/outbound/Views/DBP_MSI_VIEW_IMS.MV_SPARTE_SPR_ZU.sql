CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_sparte_spr_zu AS SELECT sparte_id,
 sparte_bez
FROM kfl_production_dbp_view.v_sparte_spr_zu
WHERE spr_id = 22;
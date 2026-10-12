CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_belos_tourstatus_2 (mandant_id, belos_tourstatus_id) AS SELECT
 mandant_id,
 belos_tourstatus_id
FROM kfl_production_dbp_view.v_l_belos_tourstatus_2;
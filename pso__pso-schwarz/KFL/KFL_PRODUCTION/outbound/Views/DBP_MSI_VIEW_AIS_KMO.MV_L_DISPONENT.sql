CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_disponent (disponent_id, mandant_id) AS SELECT
 disponent_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_disponent
WHERE mandant_id <> 1;
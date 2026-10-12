CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_sm_1 (sm_id, sm_bez, mandant_id, spr_id) AS SELECT sm_id,
 sm_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_sm_1
WHERE mandant_id = 1
 AND sm_id <> - 9;
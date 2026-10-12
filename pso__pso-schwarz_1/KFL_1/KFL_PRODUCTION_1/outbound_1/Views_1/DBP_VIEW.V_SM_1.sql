CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sm_1 AS SELECT sm_id,
 mandant_id,
 spr_id,
 sm_bez,
 sap_sm_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.sm_1;
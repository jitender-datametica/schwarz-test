CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_status_spr_zu_1 AS SELECT crm_status_id,
 spr_id,
 crm_status_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_status_spr_zu_1;
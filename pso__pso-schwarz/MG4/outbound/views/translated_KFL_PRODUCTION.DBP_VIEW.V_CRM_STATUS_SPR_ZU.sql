CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_status_spr_zu (crm_status_id, spr_id, crm_status_bez, td_update,
td_insert) AS SELECT *
FROM kfl_production_dbp_data.crm_status_spr_zu;
CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_eigenmarke_spr_zu_1 (crm_eigenmarke_id, spr_id, crm_eigenmarke_bez,
td_update, td_insert) AS SELECT crm_eigenmarke_id,
 spr_id,
 crm_eigenmarke_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_eigenmarke_spr_zu_1;
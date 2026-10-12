CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_fremdkoerper_spr_zu (crm_fremdkoerper_id, spr_id,
crm_fremdkoerper_bez, td_update, td_insert) AS SELECT crm_fremdkoerper_id,
 spr_id,
 crm_fremdkoerper_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_fremdkoerper_spr_zu;
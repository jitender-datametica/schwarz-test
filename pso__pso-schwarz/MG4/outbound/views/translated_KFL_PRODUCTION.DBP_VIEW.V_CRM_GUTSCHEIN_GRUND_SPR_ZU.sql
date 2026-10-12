CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_gutschein_grund_spr_zu (crm_gutschein_grund_id, spr_id,
crm_gutschein_grund_bez, td_update, td_insert) AS SELECT crm_gutschein_grund_id,
 spr_id,
 crm_gutschein_grund_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_gutschein_grund_spr_zu;
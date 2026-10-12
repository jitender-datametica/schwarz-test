CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_schaedlingsart_spr_zu_2 (crm_schaedlingsart_id, spr_id,
crm_schaedlingsart_bez, td_update, td_insert) AS SELECT crm_schaedlingsart_id,
 spr_id,
 crm_schaedlingsart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_schaedlingsart_spr_zu_2;
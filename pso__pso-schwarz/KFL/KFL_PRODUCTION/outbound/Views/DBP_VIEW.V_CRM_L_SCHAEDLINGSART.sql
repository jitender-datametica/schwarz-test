CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_l_schaedlingsart AS SELECT crm_schaedlingsart_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_l_schaedlingsart;
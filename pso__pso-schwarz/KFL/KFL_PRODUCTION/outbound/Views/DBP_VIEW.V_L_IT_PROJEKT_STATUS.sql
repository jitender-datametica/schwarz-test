CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_it_projekt_status AS SELECT it_projekt_status_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_it_projekt_status;
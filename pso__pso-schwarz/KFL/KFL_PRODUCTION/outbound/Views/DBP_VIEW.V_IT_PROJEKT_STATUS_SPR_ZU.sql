CREATE OR REPLACE VIEW kfl_production_dbp_view.v_it_projekt_status_spr_zu AS SELECT it_projekt_status_id,
 spr_id,
 it_projekt_status_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.it_projekt_status_spr_zu;
CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_vz_dispo_status AS SELECT mandant_id,
 vz_dispo_status_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_vz_dispo_status;
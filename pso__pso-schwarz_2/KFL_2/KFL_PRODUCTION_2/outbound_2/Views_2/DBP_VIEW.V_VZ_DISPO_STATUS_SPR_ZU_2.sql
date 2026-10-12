CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vz_dispo_status_spr_zu_2 AS SELECT mandant_id,
 spr_id,
 vz_dispo_status_id,
 vz_dispo_status_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.vz_dispo_status_spr_zu_2;
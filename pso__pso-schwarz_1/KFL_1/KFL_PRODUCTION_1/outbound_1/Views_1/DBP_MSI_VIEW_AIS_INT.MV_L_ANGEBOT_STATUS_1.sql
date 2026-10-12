CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_angebot_status_1 (mandant_id, angebot_status_id) AS SELECT
 mandant_id,
 angebot_status_id
FROM kfl_production_dbp_data.l_angebot_status_1;
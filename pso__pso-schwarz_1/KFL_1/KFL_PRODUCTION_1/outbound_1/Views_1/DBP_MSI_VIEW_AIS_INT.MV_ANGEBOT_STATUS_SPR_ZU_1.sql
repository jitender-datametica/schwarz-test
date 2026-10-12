CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_angebot_status_spr_zu_1 (mandant_id, angebot_status_id,
angebot_status_bez) AS SELECT mandant_id,
 angebot_status_id,
 angebot_status_bez
FROM kfl_production_dbp_data.angebot_status_spr_zu_1
WHERE spr_id = 22;
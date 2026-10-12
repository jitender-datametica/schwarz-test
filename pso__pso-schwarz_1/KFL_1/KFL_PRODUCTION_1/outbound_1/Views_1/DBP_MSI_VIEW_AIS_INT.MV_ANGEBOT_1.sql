CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_angebot_1 (mandant_id, angebot_nr, kjwo_ww) AS SELECT
 mandant_id,
 angebot_nr,
 kjwo_ww
FROM kfl_production_dbp_data.angebot_1;
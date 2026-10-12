CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gruppe (gruppe_id, gruppe_bez) AS SELECT gruppe_id,
 gruppe_bez
FROM kfl_production_dbp_security.gruppe AS V01
WHERE gruppe_id <> 0;
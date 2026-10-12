CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gruppe (gruppe_id, gruppe_bez) AS SELECT lbs_gruppe_id AS
 gruppe_id,
 lbs_gruppe_bez AS gruppe_bez
FROM kfl_production_dbp_security.lbs_gruppe AS V01
WHERE lbs_gruppe_id <> 0;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gruppe_user_matrix_loesch_2 (gruppe_id, user_id, loesch_fg) AS
SELECT lbs_gruppe_id AS gruppe_id,
 user_id,
 0 AS loesch_fg
FROM kfl_production_dbp_security.lbs_gruppe_user_zu_2 AS V01
WHERE lbs_gruppe_id <> 0;
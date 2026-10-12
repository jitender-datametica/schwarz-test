CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gruppe_user_matrix_loesch_2 (gruppe_id, user_id, loesch_fg)
AS SELECT gruppe_id,
 user_id,
 0 AS loesch_fg
FROM kfl_production_dbp_security.gruppe_user_zu_2 AS V01
WHERE gruppe_id <> 0;
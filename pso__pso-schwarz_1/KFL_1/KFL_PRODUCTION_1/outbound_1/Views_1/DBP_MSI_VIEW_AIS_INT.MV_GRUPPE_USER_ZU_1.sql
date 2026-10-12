CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gruppe_user_zu_1 (gruppe_id, user_id, dat_gueltig_bis,
td_update) AS SELECT gruppe_id,
 user_id,
 dat_gueltig_bis,
 DATE(td_update) AS td_update
FROM kfl_production_dbp_security.gruppe_user_zu_1 AS V01;
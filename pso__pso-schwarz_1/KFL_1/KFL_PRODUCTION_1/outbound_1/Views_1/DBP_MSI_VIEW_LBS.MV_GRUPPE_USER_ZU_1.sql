CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gruppe_user_zu_1 (gruppe_id, user_id, dat_gueltig_bis, td_update
) AS SELECT lbs_gruppe_id AS gruppe_id,
 user_id,
 dat_gueltig_bis,
 DATE(td_update) AS td_update
FROM kfl_production_dbp_security.lbs_gruppe_user_zu_1 AS V01;
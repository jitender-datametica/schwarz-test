CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_user_zek_zu_1 (user_id, zek_id, mandant_id) AS SELECT TRIM(user_id
  ) AS user_id,
 zek_id,
 mandant_id
FROM kfl_production_dbp_security.lbs_user_zek_zu_1 AS V01
GROUP BY V01.user_id,
 zek_id,
 mandant_id;
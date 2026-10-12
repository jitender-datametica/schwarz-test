CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_user_zek_zu (user_id, zek_id, mandant_id) AS SELECT TRIM(user_id
  ) AS user_id,
 zek_id,
 mandant_id
FROM kfl_production_dbp_security.user_zek_zu AS V01
GROUP BY V01.user_id,
 zek_id,
 mandant_id;
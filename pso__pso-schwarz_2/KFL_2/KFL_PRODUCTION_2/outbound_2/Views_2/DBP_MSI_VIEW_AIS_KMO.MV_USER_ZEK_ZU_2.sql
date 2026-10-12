CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_user_zek_zu_2 (user_id, zek_id, mandant_id) AS SELECT TRIM(user_id
  ) AS user_id,
 zek_id,
 mandant_id
FROM kfl_production_dbp_security.user_zek_zu_2 AS V01
WHERE mandant_id <> 1
GROUP BY V01.user_id,
 zek_id,
 mandant_id;
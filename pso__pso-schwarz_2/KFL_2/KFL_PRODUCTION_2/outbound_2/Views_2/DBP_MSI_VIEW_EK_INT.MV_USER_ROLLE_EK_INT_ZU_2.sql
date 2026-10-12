CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_user_rolle_ek_int_zu_2 (mandant_id, user_id, rolle_id,
rolle_bez, zek_id, wbl_id, gf_id) AS SELECT mandant_id,
 LOWER(user_id) AS user_id,
 rolle_id,
 rolle_bez,
 zek_id,
 wbl_id,
 gf_id
FROM kfl_production_dbp_security.user_rolle_ek_int_zu_2
UNION DISTINCT
SELECT DISTINCT mandant_id,
 'Superuser' AS user_id,
 rolle_id,
 rolle_bez,
 zek_id,
 wbl_id,
 gf_id
FROM kfl_production_dbp_security.user_rolle_ek_int_zu_2
WHERE rolle_id = 4;
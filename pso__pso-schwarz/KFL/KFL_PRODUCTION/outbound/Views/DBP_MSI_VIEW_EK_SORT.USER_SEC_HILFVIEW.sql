CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.user_sec_hilfview AS SELECT DISTINCT mandant_id,
 zek_id,
 user_id
FROM kfl_production_dbp_security.user_zek_zu
WHERE user_id = 'ikul2811';
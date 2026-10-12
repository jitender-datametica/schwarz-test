CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_l_sec_mandant_usersequenz_zu_2 (mandant_id, usersequenz) AS SELECT
 mandant_id,
 LOWER(usersequenz) AS usersequenz
FROM kfl_production_dbp_security.ios_mandant_usersequenz_zu_2;
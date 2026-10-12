CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_user_ek_anzeige_zu (user_id, ek_anzeige_fg) AS
SELECT user_id,
 ek_anzeige_fg
FROM kfl_production_dbp_security.user_ek_anzeige_zu;
CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_beleg_alter_spr_zu
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 beleg_alter_id,
 spr_id,
 beleg_alter_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_beleg_alter_spr_zu
WHERE spr_id = 22
 AND mandant_id = 1;
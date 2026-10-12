CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_gruppe_rpw_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 gruppe_id,
 abteilung_id,
 spr_id,
 gruppe_rpw_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_gruppe_rpw_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;
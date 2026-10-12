CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_lager_bewgrund_spr_zu
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 grund_id,
 spr_id,
 MAX(grund_bez) AS grund_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_lager_bewgrund_spr_zu
WHERE spr_id = 22
 AND mandant_id = 1
GROUP BY mandant_id,
 grund_id,
 spr_id,
 system_id;
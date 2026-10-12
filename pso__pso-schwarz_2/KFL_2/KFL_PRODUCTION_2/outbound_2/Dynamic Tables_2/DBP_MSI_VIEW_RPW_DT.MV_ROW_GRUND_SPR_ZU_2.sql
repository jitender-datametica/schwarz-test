CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_row_grund_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT mandant_id,
 row_grund_id,
 spr_id,
 row_grund_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_row_grund_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22
GROUP BY mandant_id,
 spr_id,
 row_grund_id,
 row_grund_bez
UNION ALL
SELECT 1 AS mandant_id,
 '0' AS row_grund_id,
 22 AS spr_id,
 'Sachkontenbuchung ohne ROW' AS row_grund_bez,
 7 AS system_id;

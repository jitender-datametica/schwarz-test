CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_buch_grund_ext
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT buch_grund_ext_id,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_buch_grund_ext
WHERE mandant_id = 1
UNION DISTINCT
SELECT '0' AS buch_grund_ext_id,
 1 AS mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_buch_grund_ext;
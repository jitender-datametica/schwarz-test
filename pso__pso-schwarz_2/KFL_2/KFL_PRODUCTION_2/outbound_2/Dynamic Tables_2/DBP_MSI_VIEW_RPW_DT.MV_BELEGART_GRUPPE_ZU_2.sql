CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_belegart_gruppe_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 belegart_id,
 belegart_gruppe_id,
  CASE
  WHEN belegart_gruppe_id IN (3, 4)
  THEN '1'
  ELSE '0'
  END AS belegreferenz_id
FROM kfl_production_dbp_view.v_belegart_gruppe_zu_2
WHERE mandant_id = 1;
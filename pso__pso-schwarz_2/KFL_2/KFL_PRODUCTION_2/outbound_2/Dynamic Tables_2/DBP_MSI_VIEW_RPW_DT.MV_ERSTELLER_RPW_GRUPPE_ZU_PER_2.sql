CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_ersteller_rpw_gruppe_zu_per_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT mandant_id,
 ersteller_id AS rpw_ersteller_id,
 gruppe_id,
 abteilung_id,
 dat_von,
 dat_bis,
 7 AS system_id
FROM kfl_production_dbp_view.v_ersteller_rpw_gruppe_zu_per_2
WHERE mandant_id = 1
GROUP BY mandant_id,
 ersteller_id,
 gruppe_id,
 abteilung_id,
 dat_von,
 dat_bis
QUALIFY (SUM(mandant_id) OVER (PARTITION BY mandant_id, ersteller_id ORDER BY ersteller_id NULLS LAST, dat_bis
      NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 1;
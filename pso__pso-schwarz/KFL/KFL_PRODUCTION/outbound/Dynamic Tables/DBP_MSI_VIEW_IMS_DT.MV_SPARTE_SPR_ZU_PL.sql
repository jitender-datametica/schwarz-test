CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_sparte_spr_zu_pl
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  de.sparte_id AS sparte_id,
  COALESCE(ls.sparte_bez, de.sparte_bez) AS sparte_bez
FROM kfl_production_dbp_view.v_sparte_spr_zu AS de
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_sparte_spr_zu
  WHERE
    spr_id = 90
) AS ls
  ON de.sparte_id = ls.sparte_id
WHERE
  de.spr_id = 22 AND de.sparte_id <> 8;

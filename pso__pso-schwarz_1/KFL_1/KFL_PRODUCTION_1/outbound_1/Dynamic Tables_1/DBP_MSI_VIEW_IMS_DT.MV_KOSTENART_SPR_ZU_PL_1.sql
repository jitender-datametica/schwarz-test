CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_kostenart_spr_zu_pl_1
OPTIONS (
  enable_refresh=TRUE,
  refresh_interval_minutes=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  COLLATE(LTRIM(COLLATE(de.kostenart_id, ''), '0'), 'und:ci') AS kostenart_id,
  de.krk_id AS krk_id,
  COALESCE(ls.kostenart_bez, de.kostenart_bez) AS kostenart_bez
FROM kfl_production_dbp_view.v_kostenart_spr_zu_1 AS de
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_kostenart_spr_zu_1
  WHERE
    spr_id = 90 AND krk_id = 'XX01' AND mandant_id = 1
) AS ls
  ON de.kostenart_id = ls.kostenart_id
WHERE
  de.spr_id = 22 AND de.krk_id = 'XX01' AND de.mandant_id = 1;

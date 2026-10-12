CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_massnahmenart_spr_zu_hr
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.massnahme_id AS massnahme_id,
  COALESCE(v03.massnahmenart_bez, v02.massnahmenart_bez) AS massnahmenart_bez
FROM kfl_production_dbp_view.v_l_massnahme AS v01
LEFT JOIN kfl_production_dbp_view.v_massnahmenart_spr_zu AS v02
  ON v01.massnahmenart_id = v02.massnahmenart_id
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_massnahmenart_spr_zu
  WHERE
    spr_id = 65
) AS v03
  ON v02.massnahmenart_id = v03.massnahmenart_id
WHERE
  v02.spr_id = 22;

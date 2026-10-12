CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_techn_platz_spr_zu_sk
OPTIONS (
  enable_refresh=TRUE,
  refresh_interval_minutes=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.techn_platz_id AS techn_platz_id,
  COALESCE(ls.tech_platz_bez, de.tech_platz_bez, '') AS techn_platz_bez
FROM kfl_production_dbp_view.v_techn_platz_per AS v01
LEFT JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per AS de
  ON v01.techn_platz_id = de.techn_platz_id
  AND de.dat_bis = CAST('9999-12-31' AS DATE)
  AND de.spr_id = 22
LEFT JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per AS ls
  ON v01.techn_platz_id = ls.techn_platz_id
  AND ls.dat_bis = CAST('9999-12-31' AS DATE)
  AND ls.spr_id = 108
WHERE
  v01.dat_bis = CAST('9999-12-31' AS DATE);

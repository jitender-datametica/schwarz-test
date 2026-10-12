CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_ginfo_baujahr
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT DISTINCT
  baujahr AS baujahr,
  SUBSTR(CAST(baujahr AS STRING), 1, 4) AS baujahr_bez
FROM kfl_production_dbp_view.v_techn_platz_ebene_2_per
UNION DISTINCT
SELECT
  9999 AS baujahr,
  '' AS baujahr_bez
FROM kfl_production_dbp_view.v_jahr_kj;

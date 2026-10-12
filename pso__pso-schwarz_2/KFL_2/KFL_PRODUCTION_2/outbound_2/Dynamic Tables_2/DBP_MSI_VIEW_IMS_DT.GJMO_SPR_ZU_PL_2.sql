CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.gjmo_spr_zu_pl_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.gjmo AS gjmo,
  TRIM(v02.mo_bez) || ' GJ ' || SUBSTR(CAST(v01.gj AS STRING), 1, 4) AS gjmo_bez
FROM kfl_production_dbp_view.v_monat_2 AS v01
INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_2 AS v02
  ON v01.mo_kj = v02.mo_id
WHERE
  v02.spr_id = 90;

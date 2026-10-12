CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_woche_kj_kl_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  kjwo_kl AS kjwo_kl,
  kjwo_kl_dat_von AS kjwo_kl_dat_von,
  kjwo_kl_dat_bis AS kjwo_kl_dat_bis,
  akt_kjwo_kl AS akt_kjwo_kl,
  akt_kjwo_kl_komplett AS akt_kjwo_kl_komplett,
  akt_kj AS akt_kj,
  akt_kj_komplett AS akt_kj_komplett,
  kjwo AS kjwo,
  CAST(CAST(FLOOR(kjwo_kl / 100) AS INT64) AS BIGNUMERIC) AS kj,
  akt_wo AS akt_wo
FROM kfl_production_dbp_view.v_woche_kj_kl_1 AS v01;

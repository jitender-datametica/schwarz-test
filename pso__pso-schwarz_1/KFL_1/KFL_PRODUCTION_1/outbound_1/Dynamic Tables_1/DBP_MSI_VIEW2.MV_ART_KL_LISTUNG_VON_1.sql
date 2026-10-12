CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_kl_listung_von_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  art_id AS art_id,
  mandant_id AS mandant_id,
  1 AS kl_id,
  MIN(dat_von) AS dat_von,
  MIN(dat_erst_listung) AS dat_erst_listung
FROM kfl_production_dbp_view.v_art_vw_listung_von_1
WHERE
  mandant_id = 1
GROUP BY
  art_id,
  mandant_id,
  3;

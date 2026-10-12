CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_list_wup_zu_min_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  art_id AS art_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  MIN(dat_von) AS dat_listung
FROM kfl_production_dbp_view.v_art_list_wup_zu_per_2 AS v01
WHERE
  mandant_id <> 1 AND nb_id = 0 AND dat_bis = CAST('9999-12-31' AS DATE)
GROUP BY
  mandant_id,
  art_id,
  wup_id,
  nb_id;

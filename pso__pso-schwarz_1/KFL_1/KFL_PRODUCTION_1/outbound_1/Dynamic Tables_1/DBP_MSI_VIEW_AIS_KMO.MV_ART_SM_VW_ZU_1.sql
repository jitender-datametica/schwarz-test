CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_sm_vw_zu_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.art_id,
  v01.vw_id,
  CAST(TRIM(v02.sap_sm_id) AS STRING) AS sm_id,
  v01.ksm_id,
  v01.mandant_id
FROM kfl_production_dbp_view.v_art_sm_vw_zu_per_1 AS v01
INNER JOIN kfl_production_dbp_view.v_sm_1 AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.sm_id = v02.sm_id
INNER JOIN (
  SELECT
    art_id,
    vw_id,
    mandant_id,
    MAX(dat_von) AS dat_von
  FROM kfl_production_dbp_view.v_art_sm_vw_zu_per_1 AS v03
  WHERE
    mandant_id <> 1 AND vw_id = 10
  GROUP BY
    art_id,
    vw_id,
    mandant_id
) AS t1_1
  ON v01.art_id = t1.art_id
  AND v01.vw_id = t1.vw_id
  AND v01.mandant_id = t1.mandant_id
  AND v01.dat_von = t1.dat_von;
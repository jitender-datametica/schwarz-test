CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_sternchen_logik_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  CASE
    WHEN v01.sm_id = -9
    THEN CAST(TRIM(v01.ksm_id) AS STRING)
    WHEN CAST(v01.ksm_id AS FLOAT64) = -9
    THEN CAST(TRIM(SUBSTR(CAST(v01.sm_id AS STRING), 1, 39)) AS STRING)
    ELSE NULL
  END AS sm_id,
  v01.ksm_id AS ksm_id,
  v01.list_durchg_fg AS list_durchg_fg,
  CASE WHEN v02.sternchen_id = '' THEN NULL ELSE v02.sternchen_id END AS listung_fct,
  v01.anzahl_markt_soll AS anzahl_markt
FROM kfl_production_dbp_view.v_sternchen_logik_1 AS v01
INNER JOIN kfl_production_dbp_view.v_l_sternchen_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.list_durchg_fg = v02.list_durchg_fg
  AND v01.bezugsweg1_fg = v02.bezugsweg1_fg
  AND v01.bezugsweg4_fg = v02.bezugsweg4_fg
  AND v01.kdis0_fg = v02.kdis0_fg
  AND v01.kdis1_fg = v02.kdis1_fg
WHERE
  v01.mandant_id <> 1;
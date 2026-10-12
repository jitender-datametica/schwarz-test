CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_sternchen_logik_sk
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id,
  v01.art_id,
  MAX(v01.list_durchg_fg) AS list_durchg_fg,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.sm_id = CAST(-1 AS BIGNUMERIC) THEN v02.sternchen_id ELSE '  ' END AS STRING),
      1,
      2
    )
  ) AS sx_id,
  MAX(
    SUBSTR(CAST(CASE WHEN v01.sm_id = 1 THEN v02.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s1_id,
  MAX(
    SUBSTR(CAST(CASE WHEN v01.sm_id = 2 THEN v02.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s2_id,
  MAX(
    SUBSTR(CAST(CASE WHEN v01.sm_id = 3 THEN v02.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s3_id,
  MAX(
    SUBSTR(CAST(CASE WHEN v01.sm_id = 4 THEN v02.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s4_id,
  MAX(
    SUBSTR(CAST(CASE WHEN v01.sm_id = 5 THEN v02.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s5_id,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.ksm_id = 'K1' THEN v02.sternchen_id ELSE '  ' END AS STRING),
      1,
      2
    )
  ) AS ks1_id,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.ksm_id = 'K2' THEN v02.sternchen_id ELSE '  ' END AS STRING),
      1,
      2
    )
  ) AS ks2_id,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.ksm_id = 'K3' THEN v02.sternchen_id ELSE '  ' END AS STRING),
      1,
      2
    )
  ) AS ks3_id,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.ksm_id = 'K4' THEN v02.sternchen_id ELSE '  ' END AS STRING),
      1,
      2
    )
  ) AS ks4_id,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.ksm_id = 'K5' THEN v02.sternchen_id ELSE '  ' END AS STRING),
      1,
      2
    )
  ) AS ks5_id,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.ksm_id = 'K6' THEN v02.sternchen_id ELSE '  ' END AS STRING),
      1,
      2
    )
  ) AS ks6_id,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.ksm_id = 'K7' THEN v02.sternchen_id ELSE '  ' END AS STRING),
      1,
      2
    )
  ) AS ks7_id
FROM kfl_production_dbp_view.v_sternchen_logik AS v01
INNER JOIN kfl_production_dbp_view.v_l_sternchen AS v02
  ON v01.list_durchg_fg = v02.list_durchg_fg
  AND v01.bezugsweg1_fg = v02.bezugsweg1_fg
  AND v01.bezugsweg4_fg = v02.bezugsweg4_fg
  AND v01.kdis0_fg = v02.kdis0_fg
  AND v01.kdis1_fg = v02.kdis1_fg
  AND v01.mandant_id = v02.mandant_id
WHERE
  v01.mandant_id <> 1
GROUP BY
  v01.mandant_id,
  v01.art_id;
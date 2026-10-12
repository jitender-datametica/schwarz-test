CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_sternchen_logik_sk
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  lsl.art_id AS art_id,
  lsl.mandant_id AS mandant_id,
  MAX(
    SUBSTR(
      CAST(CASE WHEN lsl.sm_id = CAST(-1 AS BIGNUMERIC) THEN ls.sternchen_id ELSE '  ' END AS STRING),
      1,
      2
    )
  ) || '/' || MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 0 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) || '/' || MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 1 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) || '/' || MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 2 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) || '/' || MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 3 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) || '/' || MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 4 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) || '/' || MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 5 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) || '/' || MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 6 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) || '/' || MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 7 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) || '/' || MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 8 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) || '/' || MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 9 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS sternchen_logik_sk,
  MAX(
    SUBSTR(
      CAST(CASE WHEN lsl.sm_id = CAST(-1 AS BIGNUMERIC) THEN ls.sternchen_id ELSE '  ' END AS STRING),
      1,
      2
    )
  ) AS sx_id,
  MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 0 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s0_id,
  MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 1 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s1_id,
  MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 2 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s2_id,
  MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 3 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s3_id,
  MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 4 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s4_id,
  MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 5 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s5_id,
  MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 6 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s6_id,
  MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 7 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s7_id,
  MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 8 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s8_id,
  MAX(
    SUBSTR(CAST(CASE WHEN lsl.sm_id = 9 THEN ls.sternchen_id ELSE '  ' END AS STRING), 1, 2)
  ) AS s9_id
FROM kfl_production_dbp_view.v_sternchen_logik AS lsl
INNER JOIN kfl_production_dbp_view.v_l_sternchen AS ls
  ON lsl.list_durchg_fg = ls.list_durchg_fg
  AND lsl.bezugsweg1_fg = ls.bezugsweg1_fg
  AND lsl.bezugsweg4_fg = ls.bezugsweg4_fg
  AND lsl.kdis0_fg = ls.kdis0_fg
  AND lsl.kdis1_fg = ls.kdis1_fg
  AND lsl.mandant_id = ls.mandant_id
WHERE
  lsl.mandant_id = 1
GROUP BY
  lsl.art_id,
  lsl.mandant_id;

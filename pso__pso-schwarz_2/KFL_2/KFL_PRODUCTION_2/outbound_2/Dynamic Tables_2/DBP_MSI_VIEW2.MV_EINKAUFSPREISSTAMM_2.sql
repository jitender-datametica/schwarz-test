CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_einkaufspreisstamm_2 (
  mandant_id BIGNUMERIC,
  art_id BIGNUMERIC,
  bezugsweg_id BIGNUMERIC,
  ek_kal_basis NUMERIC(18, 4),
  ek_mep NUMERIC(18, 4),
  logistikkostenzuschlag NUMERIC(18, 4),
  sternchen_logik_sk STRING(16777216),
  sx_id STRING(2),
  s1_id STRING(2),
  s2_id STRING(2),
  s3_id STRING(2),
  s4_id STRING(2),
  s5_id STRING(2)
) AS
SELECT
  dt1.mandant_id AS mandant_id,
  dt1.art_id AS art_id,
  dt1.bezugsweg_id AS bezugsweg_id,
  dt1.ek_kal_basis AS ek_kal_basis,
  dt1.ek_mep AS ek_mep,
  dt1.logistikkostenzuschlag AS logistikkostenzuschlag,
  dt2.sternchen_logik_sk AS sternchen_logik_sk,
  dt2.sx_id AS sx_id,
  dt2.s1_id AS s1_id,
  dt2.s2_id AS s2_id,
  dt2.s3_id AS s3_id,
  dt2.s4_id AS s4_id,
  dt2.s5_id AS s5_id
FROM kfl_production_dbp_msi_view2.mv_einkaufspreisstamm_kbsal_2 AS dt1
INNER JOIN (
  SELECT
    lsl.art_id,
    lsl.mandant_id,
    lsl.bezugsweg1_fg + lsl.bezugsweg4_fg * 4 AS bezugsweg_id,
    MAX(
      SUBSTR(
        CAST(CASE WHEN lsl.sm_id = CAST(-1 AS BIGNUMERIC) THEN ls.sternchen_id ELSE '  ' END AS STRING),
        1,
        2
      )
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
    ) AS sternchen_logik_sk,
    MAX(
      SUBSTR(
        CAST(CASE WHEN lsl.sm_id = CAST(-1 AS BIGNUMERIC) THEN ls.sternchen_id ELSE '  ' END AS STRING),
        1,
        2
      )
    ) AS sx_id,
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
    ) AS s5_id
  FROM kfl_production_dbp_view.v_sternchen_logik_2 AS lsl
  INNER JOIN kfl_production_dbp_view.v_l_sternchen_2 AS ls
    ON lsl.list_durchg_fg = ls.list_durchg_fg
    AND lsl.bezugsweg1_fg = ls.bezugsweg1_fg
    AND lsl.bezugsweg4_fg = ls.bezugsweg4_fg
    AND lsl.kdis0_fg = ls.kdis0_fg
    AND lsl.kdis1_fg = ls.kdis1_fg
    AND lsl.mandant_id = ls.mandant_id
  WHERE
    lsl.mandant_id = 1 AND lsl.dat_bis = CAST('9999-12-31' AS DATE)
  GROUP BY
    lsl.art_id,
    lsl.mandant_id,
    bezugsweg_id
) AS dt2
  ON dt1.mandant_id = dt2.mandant_id
  AND dt1.art_id = dt2.art_id
  AND dt1.bezugsweg_id = dt2.bezugsweg_id;

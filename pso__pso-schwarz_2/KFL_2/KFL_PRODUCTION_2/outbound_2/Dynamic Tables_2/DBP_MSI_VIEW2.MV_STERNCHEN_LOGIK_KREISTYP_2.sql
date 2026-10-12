CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_sternchen_logik_kreistyp_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.art_id AS art_id,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.kreistyp_gruppe_id = 'O' THEN v02.sternchen_id ELSE ' ' END AS STRING),
      1,
      2
    )
  ) AS typ_ost_basis,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.kreistyp_gruppe_id = 'Q' THEN v02.sternchen_id ELSE ' ' END AS STRING),
      1,
      2
    )
  ) AS typ_ost_gross,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.kreistyp_gruppe_id = 'G' THEN v02.sternchen_id ELSE ' ' END AS STRING),
      1,
      2
    )
  ) AS typ_sued_ost,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.kreistyp_gruppe_id = 'M' THEN v02.sternchen_id ELSE ' ' END AS STRING),
      1,
      2
    )
  ) AS typ_sued_west,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.kreistyp_gruppe_id = 'W' THEN v02.sternchen_id ELSE ' ' END AS STRING),
      1,
      2
    )
  ) AS typ_west,
  MAX(
    SUBSTR(
      CAST(CASE WHEN v01.kreistyp_gruppe_id = 'N' THEN v02.sternchen_id ELSE ' ' END AS STRING),
      1,
      2
    )
  ) AS typ_nord,
  v01.mandant_id AS mandant_id
FROM kfl_production_dbp_view.v_sternchen_logik_kreis_2 AS v01
INNER JOIN kfl_production_dbp_view.v_l_sternchen_2 AS v02
  ON v01.list_durchg_fg = v02.list_durchg_fg
  AND v01.bezugsweg1_fg = v02.bezugsweg1_fg
  AND v01.bezugsweg4_fg = v02.bezugsweg4_fg
  AND v01.kdis0_fg = v02.kdis0_fg
  AND v01.kdis1_fg = v02.kdis1_fg
  AND v01.mandant_id = v02.mandant_id
WHERE
  v01.mandant_id = 1
GROUP BY
  v01.art_id,
  v01.mandant_id;

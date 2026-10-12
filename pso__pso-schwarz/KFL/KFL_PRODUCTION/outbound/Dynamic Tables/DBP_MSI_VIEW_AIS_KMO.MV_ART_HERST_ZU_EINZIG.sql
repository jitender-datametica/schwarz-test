CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.mv_art_herst_zu_einzig AS
WITH art_gp_zu_per_aufloesung AS (
  SELECT
    mandant_id,
    art_id,
    herst_id
  FROM kfl_production_dbp_view.v_art_gp_zu_per
  WHERE
    mandant_id > 1
  QUALIFY
    (
      ROW_NUMBER() OVER (
        PARTITION BY CAST(mandant_id AS STRING), CAST(art_id AS STRING)
        ORDER BY herst_id IS NULL, herst_id, dat_bis IS NULL, dat_bis
      )
    ) = 1
)
(
  SELECT DISTINCT
    v01.mandant_id AS mandant_id,
    v01.art_id AS art_id,
    CASE WHEN v01.herst_id = v02.gp_id THEN CAST(-2 AS BIGNUMERIC) ELSE v01.herst_id END AS herst_id,
    v02.gp_id AS gp_id,
    v02.gp_id AS akt_gp_id
  FROM art_gp_zu_per_aufloesung AS v01
  LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS v02
    ON v01.art_id = v02.art_id AND v01.mandant_id = v02.mandant_id
  WHERE
    v01.mandant_id > 1
);

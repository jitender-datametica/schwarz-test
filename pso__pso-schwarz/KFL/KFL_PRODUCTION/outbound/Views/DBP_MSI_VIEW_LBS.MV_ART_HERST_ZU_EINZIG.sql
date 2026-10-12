CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_art_herst_zu_einzig AS WITH ART_GP_ZU_PER_AUFLOESUNG AS (SELECT
   mandant_id,
   art_id,
   herst_id
  FROM kfl_production_dbp_view.v_art_gp_zu_per
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(art_id AS STRING) ORDER BY herst_id IS NULL
        , herst_id, dat_bis IS NULL, dat_bis)) = 1) (SELECT DISTINCT v01.mandant_id,
   v01.art_id,
    CASE
    WHEN v01.herst_id = V02.gp_id
    THEN CAST(- 2 AS BIGNUMERIC)
    ELSE v01.herst_id
    END AS herst_id,
   V02.gp_id,
   V02.gp_id AS akt_gp_id
  FROM ART_GP_ZU_PER_AUFLOESUNG AS v01
   LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS V02 ON v01.art_id = V02.art_id AND v01.mandant_id = V02.mandant_id
     );
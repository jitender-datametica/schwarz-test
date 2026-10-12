CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_art_wup_zu_per (
  art_id BIGNUMERIC(38, 0),
  bezugsweg_id BIGNUMERIC(38, 0),
  dat_bis DATE,
  dat_von DATE,
  listung_id BIGNUMERIC(38, 0),
  mandant_id BIGNUMERIC(38, 0),
  nb_id BIGNUMERIC(38, 0),
  vk_brutto NUMERIC(9, 3),
  wup_id BIGNUMERIC(38, 0),
  kdis_kz BIGNUMERIC(38, 0),
  kdis_aenderung_dat DATE
) AS
SELECT
  art_id AS art_id,
  bezugsweg_id AS bezugsweg_id,
  dat_bis AS dat_bis,
  dat_von AS dat_von,
  listung_id AS listung_id,
  mandant_id AS mandant_id,
  nb_id AS nb_id,
  vk_brutto AS vk_brutto,
  wup_id AS wup_id,
  kdis AS kdis_kz,
  CURRENT_DATE AS kdis_aenderung_dat
FROM kfl_production_dbp_view.v_art_wup_zu_per AS v01
WHERE
  mandant_id = 1 AND dat_bis = CAST('9999-12-31' AS DATE) AND nb_id <> 99;

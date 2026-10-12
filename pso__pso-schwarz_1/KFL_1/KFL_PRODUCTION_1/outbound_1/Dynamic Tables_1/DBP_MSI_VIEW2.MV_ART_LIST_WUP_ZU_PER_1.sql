CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_art_list_wup_zu_per_1 (
  art_id BIGNUMERIC(38, 0),
  wup_id BIGNUMERIC(38, 0),
  nb_id BIGNUMERIC(38, 0),
  mandant_id BIGNUMERIC(38, 0),
  dat_von DATE,
  dat_bis DATE
) AS
SELECT
  art_id AS art_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  mandant_id AS mandant_id,
  MIN(dat_von) AS dat_von,
  MAX(dat_bis) AS dat_bis
FROM kfl_production_dbp_view.v_art_list_wup_zu_per_1
WHERE
  mandant_id = 1 AND nb_id = 0 AND CURRENT_DATE BETWEEN dat_von AND dat_bis
GROUP BY
  art_id,
  wup_id,
  nb_id,
  mandant_id;

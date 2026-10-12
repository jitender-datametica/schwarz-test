CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_wg_wup_pm_zu_per (
  wup_id BIGNUMERIC(38, 0),
  nb_id BIGNUMERIC(38, 0),
  arthiertyp_id BIGNUMERIC(38, 0),
  wg_id BIGNUMERIC(38, 0),
  pm_id BIGNUMERIC(38, 0),
  dat_von DATE,
  dat_bis DATE,
  mandant_id BIGNUMERIC(38, 0)
) AS
SELECT
  wup_id AS wup_id,
  nb_id AS nb_id,
  arthiertyp_id AS arthiertyp_id,
  wg_id AS wg_id,
  pm_id AS pm_id,
  dat_von AS dat_von,
  dat_bis AS dat_bis,
  mandant_id AS mandant_id
FROM kfl_production_dbp_view.v_pm_wup_wg_zu_per
WHERE
  mandant_id = 1 AND arthiertyp_id = 2 AND dat_bis > CURRENT_DATE AND nb_id <> 99;

CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_int.mv_bereich_zu_per (
  ber_id BIGNUMERIC(38, 0),
  mandant_id BIGNUMERIC(38, 0),
  arthiertyp_id BIGNUMERIC(38, 0)
) AS
SELECT
  wg_hierarchie_mutter_id AS ber_id,
  mandant_id AS mandant_id,
  arthiertyp_id AS arthiertyp_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per AS v01
WHERE
  arthiertyp_id = 10
  AND wg_hierarchie_ebene_id = 2
  AND CURRENT_DATE BETWEEN dat_von AND dat_bis;

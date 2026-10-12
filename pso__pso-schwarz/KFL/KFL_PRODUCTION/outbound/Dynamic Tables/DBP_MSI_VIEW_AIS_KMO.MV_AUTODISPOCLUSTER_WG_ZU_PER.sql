CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.mv_autodispocluster_wg_zu_per (
  mandant_id BIGNUMERIC(38, 0),
  wg_id BIGNUMERIC(38, 0),
  autodispo_id BIGNUMERIC(38, 0)
) AS
SELECT
  mandant_id AS mandant_id,
  wg_hierarchie_id AS wg_id,
  wg_hierarchie_mutter_id AS autodispo_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per
WHERE
  arthiertyp_id = 9
  AND mandant_id <> 1
  AND wg_hierarchie_ebene_id = 0
  AND CURRENT_DATE BETWEEN dat_von AND dat_bis;

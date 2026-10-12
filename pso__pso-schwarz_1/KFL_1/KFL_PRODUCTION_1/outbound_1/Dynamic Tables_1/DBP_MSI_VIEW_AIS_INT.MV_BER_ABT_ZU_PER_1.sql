CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_int.mv_ber_abt_zu_per_1 (
  abt_id BIGNUMERIC(38, 0),
  ber_id BIGNUMERIC(38, 0),
  mandant_id BIGNUMERIC(38, 0),
  dat_von DATE,
  dat_bis DATE,
  arthiertyp_id BIGNUMERIC(38, 0)
) AS
SELECT
  v01.wg_hierarchie_id AS abt_id,
  v01.wg_hierarchie_mutter_id AS ber_id,
  v01.mandant_id AS mandant_id,
  v01.dat_von AS dat_von,
  v01.dat_bis AS dat_bis,
  v01.arthiertyp_id AS arthiertyp_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS v01
INNER JOIN kfl_production_dbp_view.v_abt_1 AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.wg_hierarchie_id = v02.abt_id
WHERE
  v01.arthiertyp_id = 10
  AND v01.wg_hierarchie_ebene_id = 2
  AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;

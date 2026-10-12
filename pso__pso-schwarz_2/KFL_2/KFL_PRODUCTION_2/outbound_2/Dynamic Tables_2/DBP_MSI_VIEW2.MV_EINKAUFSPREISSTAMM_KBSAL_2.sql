CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_einkaufspreisstamm_kbsal_2 AS
/* View MV_EINKAUFSPREISSTAMM_KBSAL_2 wird referenziert durch View MV_EINKAUFSPREISSTAMM_2! Ist nicht im Frontend verbaut */ /* SPEC0245154 / sschuecke 03.04.2024
bisheriger CROSS JOIN wird ersetzt um direkten View CROSS JOIN, um eventuelle Änderung der Logik in der anderen View berücksichtigen zu können */
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  v01.bezugsweg_id AS bezugsweg_id,
  MAX(v01.ek_kal_basis) AS ek_kal_basis,
  MAX(v01.ek_mep) AS ek_mep,
  MAX(v01.logistikkostenzuschlag) AS logistikkostenzuschlag
FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_2 AS v01
INNER JOIN kfl_production_dbp_msi_view2.mv_art_gp_nm_zu_aktuell_2 AS v02
  ON v01.art_id = v02.art_id
  AND v01.gp_id = v02.akt_gp_id
  AND v01.mandant_id = v02.mandant_id
WHERE
  v01.dat_bis = CAST('9999-12-31' AS DATE) AND v01.mandant_id = 1
GROUP BY
  v01.mandant_id,
  v01.art_id,
  v01.bezugsweg_id;

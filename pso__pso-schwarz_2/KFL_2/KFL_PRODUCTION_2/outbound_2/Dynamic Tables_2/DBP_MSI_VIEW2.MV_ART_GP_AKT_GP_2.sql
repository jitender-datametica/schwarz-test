CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_art_gp_akt_gp_2 AS
SELECT
  v01.akt_gp_id AS akt_gp_id,
  v02.gp_id AS gp_id,
  v02.art_id AS art_id,
  v02.mandant_id AS mandant_id,
  v03.gp_name AS akt_gp_name
FROM kfl_production_dbp_msi_view2.mv_art_gp_aktuell_2 AS v01
INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per_2 AS v02
  ON v01.art_id = v02.art_id
INNER JOIN kfl_production_dbp_view.v_gp_2 AS v03
  ON v01.akt_gp_id = v03.gp_id
WHERE
  v02.mandant_id = 1
GROUP BY
  v01.akt_gp_id,
  v02.gp_id,
  v02.art_id,
  v02.mandant_id,
  v03.gp_name;

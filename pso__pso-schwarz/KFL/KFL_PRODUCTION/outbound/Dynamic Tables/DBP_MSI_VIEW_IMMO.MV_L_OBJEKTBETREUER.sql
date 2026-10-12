CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_l_objektbetreuer (
  objektbetreuer_id STRING(10),
  name1 STRING(80),
  name2 STRING(80)
) AS
SELECT
  v0.partner_id AS objektbetreuer_id,
  MAX(v0.vorname) AS name1,
  MAX(v0.nachname) AS name2
FROM kfl_production_dbp_view.v_immo_l_partner AS v0
INNER JOIN kfl_production_dbp_view.v_immo_we_partner_rolle_zu_per AS v1
  ON v0.partner_id = v1.partner_id
WHERE
  CURRENT_DATE <= v1.dat_bis AND v1.rolle_kz = 'ZI0120'
GROUP BY
  objektbetreuer_id
UNION ALL
SELECT DISTINCT
  'n.v.' AS objektleiter_id,
  'ohne Zuordnung' AS name1,
  '' AS name2
FROM kfl_production_dbp_view.v_mandant;

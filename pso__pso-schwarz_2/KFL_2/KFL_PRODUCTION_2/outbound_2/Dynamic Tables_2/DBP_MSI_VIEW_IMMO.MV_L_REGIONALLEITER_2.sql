CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_l_regionalleiter_2 AS
SELECT
  v0.partner_id AS regionalleiter_id,
  MAX(v0.vorname) AS name1,
  MAX(v0.nachname) AS name2
FROM kfl_production_dbp_view.v_immo_l_partner_2 AS v0
INNER JOIN kfl_production_dbp_view.v_immo_we_partner_rolle_zu_per_2 AS v1
  ON v0.partner_id = v1.partner_id
WHERE
  CURRENT_DATE <= v1.dat_bis AND v1.rolle_kz = 'ZI0105'
GROUP BY
  regionalleiter_id
UNION ALL
SELECT DISTINCT
  'n.v.' AS regionalleiter_id,
  'ohne Zuordnung' AS name1,
  '' AS name2
FROM kfl_production_dbp_view.v_mandant_2;

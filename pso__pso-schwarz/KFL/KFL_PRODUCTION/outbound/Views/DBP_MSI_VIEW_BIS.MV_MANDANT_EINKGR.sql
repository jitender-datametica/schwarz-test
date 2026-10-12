CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_mandant_einkgr (mandant_id, mandant_bez, mandant_kbez, wrg_id
) AS (SELECT 99 AS mandant_id,
  'International' AS mandant_bez,
  'INT' AS mandant_kbez,
  'EUR' AS wrg_id
 UNION DISTINCT
 SELECT 100 AS mandant_id,
  'Gesamt' AS mandant_bez,
  'GES' AS mandant_kbez,
  'EUR' AS wrg_id)
UNION DISTINCT
SELECT V01.mandant_id,
 V01.mandant_bez,
 V01.mandant_kbez,
  CASE
  WHEN V04.wrg_typ_id = 1
  THEN V01.default_wrg
  ELSE 'EUR'
  END AS wrg_id
FROM kfl_production_dbp_view.v_mandant AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V04 ON TRUE;
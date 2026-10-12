CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_mandant_2 AS SELECT 99 AS mandant_id,
 'International' AS mandant_bez,
 'INT' AS mandant_kbez,
 'EUR' AS wrg_id,
 1 AS bis_sort_id
UNION DISTINCT
SELECT V01.mandant_id,
 V01.mandant_bez,
 V01.mandant_kbez,
  CASE
  WHEN V04.wrg_typ_id = 1
  THEN V01.default_wrg
  ELSE 'EUR'
  END AS wrg_id,
 V01.bis_sort_id
FROM kfl_production_dbp_msi_view_bis.tbl_mv_mandant_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V04 ON TRUE;
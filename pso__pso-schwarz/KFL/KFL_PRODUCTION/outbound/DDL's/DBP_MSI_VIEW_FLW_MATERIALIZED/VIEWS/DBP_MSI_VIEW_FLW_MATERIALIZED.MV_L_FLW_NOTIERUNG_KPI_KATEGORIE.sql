CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_notierung_kpi_kategorie (kpi_kategorie_id,
kpi_kategorie_bez) AS SELECT ROW_NUMBER() OVER (ORDER BY 'DUMMY' IS NULL, 'DUMMY') AS kpi_kategorie_id,
  CASE
  WHEN (ROW_NUMBER() OVER (ORDER BY 'DUMMY' IS NULL, 'DUMMY')) = 1
  THEN 'Notierung'
  WHEN (ROW_NUMBER() OVER (ORDER BY 'DUMMY' IS NULL, 'DUMMY')) = 2
  THEN 'Notierung - Plan'
  ELSE 'Preis'
  END AS kpi_kategorie_bez
FROM UNNEST(GENERATE_ARRAY(0, 2)) AS SEQ;
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_notierung_kpi_kategorie_1 (kpi_kategorie_id,
kpi_kategorie_bez) AS SELECT ROW_NUMBER() OVER (ORDER BY 'DUMMY_1' IS NULL, 'DUMMY_1') AS kpi_kategorie_id,
  CASE
  WHEN (ROW_NUMBER() OVER (ORDER BY 'DUMMY_1' IS NULL, 'DUMMY_1')) = 1
  THEN 'Notierung'
  WHEN (ROW_NUMBER() OVER (ORDER BY 'DUMMY_1' IS NULL, 'DUMMY_1')) = 2
  THEN 'Notierung - Plan'
  ELSE 'Preis'
  END AS kpi_kategorie_bez
FROM UNNEST(GENERATE_ARRAY(0, 2)) AS SEQ;
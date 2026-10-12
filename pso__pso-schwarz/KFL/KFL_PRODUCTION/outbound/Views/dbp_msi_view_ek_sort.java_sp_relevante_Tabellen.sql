CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_sp_relevante_Tabellen
AS
SELECT
  c.table_schema,
  c.table_name,
  c.column_name,
  c.column_default,
  c.is_nullable,
  cfp.description AS Comment
FROM 
  `onix-po.region-us`.INFORMATION_SCHEMA.COLUMNS c
LEFT JOIN 
  `onix-po.region-us`.INFORMATION_SCHEMA.COLUMN_FIELD_PATHS cfp
  ON c.table_catalog = cfp.table_catalog
  AND c.table_schema = cfp.table_schema
  AND c.table_name = cfp.table_name
  AND c.column_name = cfp.column_name
WHERE 
  c.table_name IN (
    'PRODUKTWISSEN', 'HERSTELLERWISSEN', 'LIEFERANTENWISSEN', 'TUPEL_TAGS', 
    'ART_KL_PREISLAGE_ZU_PER_NEU', 'ART_NIELSEN_PREISLAGE_ZU_PER', 'TAG', 
    'TUPEL_MAT', 'WUP', 'ART_MATCHING_NIELSEN_PER', 'BF_SORT_SAL_EXPORT', 
    'NOT_LISTED_BASIS', 'NOT_LISTED_BASIS_KMO', 'ERWARTETE_ENTWICKLUNG', 
    'KL_LISTUNG', 'KL_LISTUNG_KMO', 'NL_LISTUNG', 'NL_LISTUNG_KMO', 
    'SORTIMENT_ART', 'SORTIMENT_ART_KMO'
  )
  AND c.table_schema IN ('DBP_MSI_DATA', 'DBP_DATA', 'DBP_ETL');

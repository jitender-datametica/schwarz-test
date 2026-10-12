CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_sp_relevante_Tabellen_2
AS
SELECT
  c.table_schema,
  c.table_name,
  c.column_name,
  c.column_default,
  c.is_nullable,
  cfp.description AS Comment
FROM 
  `onix-po.region_2-us`.INFORMATION_SCHEMA.COLUMNS c
LEFT JOIN 
  `onix-po.region_2-us`.INFORMATION_SCHEMA.COLUMN_FIELD_PATHS cfp
  ON c.table_catalog = cfp.table_catalog
  AND c.table_schema = cfp.table_schema
  AND c.table_name = cfp.table_name
  AND c.column_name = cfp.column_name
WHERE 
  c.table_name IN (
    'PRODUKTWISSEN_2', 'HERSTELLERWISSEN_2', 'LIEFERANTENWISSEN_2', 'TUPEL_TAGS_2', 
    'ART_KL_PREISLAGE_ZU_PER_NEU_2', 'ART_NIELSEN_PREISLAGE_ZU_PER_2', 'TAG_2', 
    'TUPEL_MAT_2', 'WUP_2', 'ART_MATCHING_NIELSEN_PER_2', 'BF_SORT_SAL_EXPORT_2', 
    'NOT_LISTED_BASIS_2', 'NOT_LISTED_BASIS_KMO_2', 'ERWARTETE_ENTWICKLUNG_2', 
    'KL_LISTUNG_2', 'KL_LISTUNG_KMO_2', 'NL_LISTUNG_2', 'NL_LISTUNG_KMO_2', 
    'SORTIMENT_ART_2', 'SORTIMENT_ART_KMO_2'
  )
  AND c.table_schema IN ('DBP_MSI_DATA', 'DBP_DATA_2', 'DBP_ETL_2');

CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_SP_RELEVANTE_TABELLEN_1
(
  TABLE_SCHEMA,
  TABLE_NAME,
  COLUMN_NAME,
  COLUMN_DEFAULT,
  IS_NULLABLE,
  COMMENT
) 
AS
SELECT
  c.table_schema,
  c.table_name,
  c.column_name,
  c.column_default,
  c.is_nullable,
  cfp.description AS comment
FROM 
  `project_name.region_1-us`.INFORMATION_SCHEMA.COLUMNS c
LEFT JOIN 
  `project_name.region_1-us`.INFORMATION_SCHEMA.COLUMN_FIELD_PATHS cfp
  ON c.table_catalog = cfp.table_catalog
  AND c.table_schema = cfp.table_schema
  AND c.table_name = cfp.table_name
  AND c.column_name = cfp.column_name
WHERE 
  c.table_name IN (
    'PRODUKTWISSEN_1', 'HERSTELLERWISSEN_1', 'LIEFERANTENWISSEN_1', 'TUPEL_TAGS_1', 
    'ART_KL_PREISLAGE_ZU_PER_NEU_1', 'ART_NIELSEN_PREISLAGE_ZU_PER_1', 'TAG_1', 
    'TUPEL_MAT_1', 'WUP_1', 'ART_MATCHING_NIELSEN_PER_1', 'BF_SORT_SAL_EXPORT_1', 
    'NOT_LISTED_BASIS_1', 'NOT_LISTED_BASIS_KMO_1', 'ERWARTETE_ENTWICKLUNG_1', 
    'KL_LISTUNG_1', 'KL_LISTUNG_KMO_1', 'NL_LISTUNG_1', 'NL_LISTUNG_KMO_1', 
    'SORTIMENT_ART_1', 'SORTIMENT_ART_KMO_1'
  )
  AND c.table_schema IN ('DBP_MSI_DATA', 'DBP_DATA_1', 'DBP_ETL_1');

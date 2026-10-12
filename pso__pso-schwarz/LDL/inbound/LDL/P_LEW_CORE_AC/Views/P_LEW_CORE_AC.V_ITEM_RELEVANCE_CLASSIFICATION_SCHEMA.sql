CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ITEM_RELEVANCE_CLASSIFICATION_SCHEMA (
   item_relevance_class_schema_cd           COMMENT 'Code of the item relevance classification schema.'
  ,item_relevance_class_schema_name         COMMENT 'Name of the item relevance classification schema.'
  ,item_relevance_class_schema_descr        COMMENT 'Description of the item relevance classification schema.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains classification schemas for the detection of the relevance of items in different situations.
Examples of schema codes are OBE for Offene Bestellungen or STA for Gesellschaftsstatus.'
AS SELECT
   item_relevance_class_schema_cd
  ,item_relevance_class_schema_name
  ,item_relevance_class_schema_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_ITEM_RELEVANCE_CLASSIFICATION_SCHEMA
;
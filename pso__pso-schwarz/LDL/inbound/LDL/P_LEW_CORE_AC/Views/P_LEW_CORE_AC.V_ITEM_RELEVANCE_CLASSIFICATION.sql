CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ITEM_RELEVANCE_CLASSIFICATION (
   client_id                                COMMENT 'CLIENT ID of the item.'
  ,item_sid                                 COMMENT 'Item for which a certain relevance classification schema is valid.'
  ,item_relevance_class_schema_cd           COMMENT 'Code of the item relevance classification schema.'
  ,dwh_valid_from                           COMMENT 'Beginning of the validity interval of the record.'
  ,dwh_valid_to                             COMMENT 'End of the validity interval of the record.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains the relation of items and classification schemas for the detection of the relevance of items in different situations.
Only valid relation records are stored.'
AS SELECT
   client_id
  ,item_sid
  ,item_relevance_class_schema_cd
  ,dwh_valid_from
  ,dwh_valid_to
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_ITEM_RELEVANCE_CLASSIFICATION
;
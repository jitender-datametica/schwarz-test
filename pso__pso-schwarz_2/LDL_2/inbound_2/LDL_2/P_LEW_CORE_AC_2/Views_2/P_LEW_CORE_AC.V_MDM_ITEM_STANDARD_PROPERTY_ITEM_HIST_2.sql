CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST_2 (
   mdm_item_sid                             COMMENT 'foreign key NFPO item_2 instance
CBX: LDL_ITEM_CERTIFICATION.ITEM_ID'
  ,mdm_item_standard_property_cd            COMMENT 'Code of the standardized item_2 properties.
CBX: for TX class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX
for HG class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG'
  ,mdm_item_standard_property_class_cd      COMMENT 'Class of the standardized item_2 properties: So far "TX" for textile item_2 properties and "HG" for hard goods item_2 properties.
CBX: "TX" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX
"HG" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG'
  ,deleted_fg                               COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'
  ,dwh_valid_from                           COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
  ,dwh_valid_to                             COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
  ,client_id                                COMMENT 'Technical column required by the used ETL framework. Static 7 for all rows.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'The table contains information about standardized additional properties of NFPO items.
CBX: LDL_ITEM_CERTIFICATION'
AS SELECT
   mdm_item_sid
  ,mdm_item_standard_property_cd
  ,mdm_item_standard_property_class_cd
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,client_id
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST_2
;
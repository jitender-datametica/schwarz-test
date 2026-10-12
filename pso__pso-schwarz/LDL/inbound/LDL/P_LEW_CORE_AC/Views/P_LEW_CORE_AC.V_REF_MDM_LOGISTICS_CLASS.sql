CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_LOGISTICS_CLASS (
   mdm_logistics_class_cd                   COMMENT 'Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST.CODE (code list "LIDL_DELIVERYTYPE")'
  ,mdm_logistics_class_name                 COMMENT 'Name to classify the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST.NAME (code list "LIDL_DELIVERYTYPE")'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'NFPO classification of the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST (code list "LIDL_DELIVERYTYPE")'
AS SELECT
   mdm_logistics_class_cd
  ,mdm_logistics_class_name
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS
;
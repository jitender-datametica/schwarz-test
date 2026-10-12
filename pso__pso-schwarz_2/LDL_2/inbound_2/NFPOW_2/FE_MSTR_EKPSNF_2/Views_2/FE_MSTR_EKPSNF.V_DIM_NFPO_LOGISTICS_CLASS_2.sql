CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_LOGISTICS_CLASS_2 (
   nfpo_logistics_class_cd                  COMMENT 'Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST.CODE (code list "LIDL_DELIVERYTYPE")
LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS.MDM_LOGISTICS_CLASS_CD
CORE_REL: T_NFPO_LOGISTICS_CLASS.NFPO_LOGISTICS_CLASS_CD'
  ,nfpo_logistics_class_name                COMMENT 'Name to classify the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST.NAME (code list "LIDL_DELIVERYTYPE")
LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS.MDM_LOGISTICS_CLASS_NAME
CORE_REL: T_NFPO_LOGISTICS_CLASS.NFPO_LOGISTICS_CLASS_NAME'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'NFPO classification of the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST_2 (code list "LIDL_DELIVERYTYPE")
LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS_2
CORE_REL: T_NFPO_LOGISTICS_CLASS_2'
AS SELECT
   nfpo_logistics_class_cd
  ,nfpo_logistics_class_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_LOGISTICS_CLASS_2
;
CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_WARRANTY_TYPE_2 (
   nfpo_warranty_type_cd                    COMMENT 'NFPO warranty type code.
CBX: CNT_CODELIST.CODE (code list "LIDL_WARRANTY_ART")
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE.GUARANTEE_TYPE_CD
CORE_REL: T_NFPO_WARRANTY_TYPE.NFPO_WARRANTY_TYPE_CD'
  ,nfpo_warranty_type_name                  COMMENT 'NFPO warranty type description.
CBX: CNT_CODELIST.NAME (code list "LIDL_WARRANTY_ART")
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE.GUARANTEE_TYPE_DESCR
CORE_REL: T_NFPO_WARRANTY_TYPE.NFPO_WARRANTY_TYPE_NAME'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'NFPO guarantee types of items.
CBX: CNT_CODELIST_2 (code list "LIDL_WARRANTY_ART")
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE_2
CORE_REL: T_NFPO_WARRANTY_TYPE_2'
AS SELECT
   nfpo_warranty_type_cd
  ,nfpo_warranty_type_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_WARRANTY_TYPE_2
;
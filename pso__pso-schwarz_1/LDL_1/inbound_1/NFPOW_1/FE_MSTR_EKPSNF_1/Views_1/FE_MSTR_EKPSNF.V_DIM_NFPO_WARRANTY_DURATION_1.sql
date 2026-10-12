CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_WARRANTY_DURATION_1 (
   nfpo_warranty_dur_cd                     COMMENT 'NFPO warranty duration code.
CBX: CNT_CODELIST.CODE (code list "LIDL_WARRANTY")
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE.GUARANTEE_CD
CORE_REL: T_NFPO_WARRANTY_DURATION.NFPO_WARRANTY_DUR_CD'
  ,nfpo_warranty_dur_name                   COMMENT 'NFPO warranty duration name.
CBX: CNT_CODELIST.NAME (code list "LIDL_WARRANTY")
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE.GUARANTEE_DESCR
CORE_REL: T_NFPO_WARRANTY_DURATION.NFPO_WARRANTY_DUR_NAME'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'NFPO guarantee length types of items.
CBX: CNT_CODELIST_1, code list "LIDL_WARRANTY"
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_1
CORE_REL: T_NFPO_WARRANTY_DURATION_1'
AS SELECT
   nfpo_warranty_dur_cd
  ,nfpo_warranty_dur_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_WARRANTY_DURATION_1
;
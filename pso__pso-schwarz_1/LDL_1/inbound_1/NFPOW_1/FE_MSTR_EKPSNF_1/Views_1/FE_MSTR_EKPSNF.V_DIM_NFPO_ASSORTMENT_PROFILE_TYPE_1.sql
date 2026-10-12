CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_ASSORTMENT_PROFILE_TYPE_1 (
   nfpo_assort_profile_type_cd              COMMENT 'Code to indicate the importance profile of the item_1 in the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")
LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE.ASSORT_PROFILE_TYPE_CD
CORE_REL: T_NFPO_ASSORTMENT_PROFILE_TYPE.NFPO_ASSORT_PROFILE_TYPE_CD'
  ,nfpo_assort_profile_type_name            COMMENT 'Name of the profile type of the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.NAME (code list "LIDL_FMS_ASSORTMENT")
LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE.ASSORT_PROFILE_TYPE_NAME
CORE_REL: T_NFPO_ASSORTMENT_PROFILE_TYPE.NFPO_ASSORT_PROFILE_TYPE_NAME'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'Classification of the assortment by the importance of the in the assortment (Pflicht, Profilierung, Ergänzung).
CBX: CNT_CODELIST.CODE (code list "LIDL_FMS_ASSORTMENT")
LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE_1
CORE_REL: T_NFPO_ASSORTMENT_PROFILE_TYPE_1'
AS SELECT
   nfpo_assort_profile_type_cd
  ,nfpo_assort_profile_type_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_ASSORTMENT_PROFILE_TYPE_1
;
CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_CASE_COMPOSITION_2 (
   nfpo_case_composition_cd                 COMMENT 'Code of options to put items in the case. Indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
CBX: CNT_CODELIST.CODE (code list "LIDL_NUMBEROFSET")
LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.MDM_CASE_COMPOSITION_CD
CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_CASE_COMPOSITION_CD'
  ,nfpo_case_composition_txt                COMMENT 'Text of options to put items in the case. Indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.MDM_CASE_COMPOSITION_TXT
CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_CASE_COMPOSITION_TXT'
  ,nfpo_subcase_size_qty                    COMMENT 'Predefined number of items in the text of options to put items in the case when the case will be filled by subcases which contain a predefined number of items.
CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.SUBCASE_SIZE_QTY
CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_SUBCASE_SIZE_QTY'
  ,nfpo_case_composition_name               COMMENT 'Text of options to put items in the case without the predefined number of items in possible sub cases. Indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.MDM_CASE_COMPOSITION_NAME
CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_CASE_COMPOSITION_NAME'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'List of options to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
CBX: CNT_CODELIST_2, code list "LIDL_NUMBEROFSET"
LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION_2
CORE_REL: T_NFPO_CASE_COMPOSITION_2'
AS SELECT
   nfpo_case_composition_cd
  ,nfpo_case_composition_txt
  ,nfpo_subcase_size_qty
  ,nfpo_case_composition_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_CASE_COMPOSITION_2
;
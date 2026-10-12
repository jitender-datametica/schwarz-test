CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_case_composition (nfpo_case_composition_cd
OPTIONS(description='''Code of options to put items in the case. Indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
CBX: CNT_CODELIST.CODE (code list "LIDL_NUMBEROFSET")
LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.MDM_CASE_COMPOSITION_CD
CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_CASE_COMPOSITION_CD'''),
nfpo_case_composition_txt
OPTIONS(description='''Text of options to put items in the case. Indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.MDM_CASE_COMPOSITION_TXT
CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_CASE_COMPOSITION_TXT'''),
nfpo_subcase_size_qty
OPTIONS(description='''Predefined number of items in the text of options to put items in the case when the case will be filled by subcases which contain a predefined number of items.
CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.SUBCASE_SIZE_QTY
CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_SUBCASE_SIZE_QTY'''),
nfpo_case_composition_name
OPTIONS(description='''Text of options to put items in the case without the predefined number of items in possible sub cases. Indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.MDM_CASE_COMPOSITION_NAME
CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_CASE_COMPOSITION_NAME'''),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = '''List of options to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
CBX: CNT_CODELIST, code list "LIDL_NUMBEROFSET"
LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION
CORE_REL: T_NFPO_CASE_COMPOSITION''')
AS SELECT *
FROM nfpow_core.t_dim_nfpo_case_composition;
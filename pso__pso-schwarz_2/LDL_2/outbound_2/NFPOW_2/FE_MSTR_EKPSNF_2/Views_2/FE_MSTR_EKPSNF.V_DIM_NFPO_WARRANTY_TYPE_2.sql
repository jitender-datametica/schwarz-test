CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_warranty_type_2 (nfpo_warranty_type_cd
OPTIONS(description='''NFPO warranty type code.
CBX: CNT_CODELIST.CODE (code list "LIDL_WARRANTY_ART")
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE.GUARANTEE_TYPE_CD
CORE_REL: T_NFPO_WARRANTY_TYPE.NFPO_WARRANTY_TYPE_CD'''),
nfpo_warranty_type_name
OPTIONS(description='''NFPO warranty type description.
CBX: CNT_CODELIST.NAME (code list "LIDL_WARRANTY_ART")
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE.GUARANTEE_TYPE_DESCR
CORE_REL: T_NFPO_WARRANTY_TYPE.NFPO_WARRANTY_TYPE_NAME'''),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = '''NFPO guarantee types of items.
CBX: CNT_CODELIST_2 (code list "LIDL_WARRANTY_ART")
LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE_2
CORE_REL: T_NFPO_WARRANTY_TYPE_2''')
AS SELECT *
FROM nfpow_core.t_dim_nfpo_warranty_type_2;
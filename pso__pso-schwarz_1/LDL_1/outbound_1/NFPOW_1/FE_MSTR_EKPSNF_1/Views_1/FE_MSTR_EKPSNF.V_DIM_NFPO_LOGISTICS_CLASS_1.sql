CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_logistics_class_1 (nfpo_logistics_class_cd
OPTIONS(description='''Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST.CODE (code list "LIDL_DELIVERYTYPE")
LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS.MDM_LOGISTICS_CLASS_CD
CORE_REL: T_NFPO_LOGISTICS_CLASS.NFPO_LOGISTICS_CLASS_CD'''),
nfpo_logistics_class_name
OPTIONS(description='''Name to classify the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST.NAME (code list "LIDL_DELIVERYTYPE")
LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS.MDM_LOGISTICS_CLASS_NAME
CORE_REL: T_NFPO_LOGISTICS_CLASS.NFPO_LOGISTICS_CLASS_NAME'''),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = '''NFPO classification of the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST_1 (code list "LIDL_DELIVERYTYPE")
LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS_1
CORE_REL: T_NFPO_LOGISTICS_CLASS_1''')
AS SELECT *
FROM nfpow_core.t_dim_nfpo_logistics_class_1;
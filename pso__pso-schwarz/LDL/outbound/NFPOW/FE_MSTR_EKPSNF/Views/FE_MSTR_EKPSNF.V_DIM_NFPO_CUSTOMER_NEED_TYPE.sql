CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_customer_need_type (nfpo_cust_need_type_cd
OPTIONS(description='''Code to classify the assortment by general customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")
LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE.MDM_CUST_NEED_TYPE_CD
CORE_REL: T_NFPO_CUSTOMER_NEED_TYPE.NFPO_CUST_NEED_TYPE_CD'''),
nfpo_cust_need_type_name
OPTIONS(description='''Name of the general customer need.
CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")
LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE.MDM_CUST_NEED_TYPE_NAME
CORE_REL: T_NFPO_CUSTOMER_NEED_TYPE.NFPO_CUST_NEED_TYPE_NAME'''),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = '''Classification of the assortment by general customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")
LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE
CORE_REL: T_NFPO_CUSTOMER_NEED_TYPE''')
AS SELECT *
FROM nfpow_core.t_dim_nfpo_customer_need_type;
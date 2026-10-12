CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_sales_packaging_type (nfpo_sales_packaging_type_cd
OPTIONS(description='''Code of the sales packaging types.
CBX: CNT_CODELIST.CODE (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")
LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE.MDM_SALES_PACKAGING_TYPE_CD
CORE_REL: T_NFPO_SALES_PACKAGING_TYPE.NFPO_SALES_PACKAGING_TYPE_CD'''),
nfpo_sales_packaging_type_name
OPTIONS(description='''Name of the sales packaging types.
CBX: CNT_CODELIST.NAME (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")
LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE.MDM_SALES_PACKAGING_TYPE_NAME
CORE_REL: T_NFPO_SALES_PACKAGING_TYPE.NFPO_SALES_PACKAGING_TYPE_NAME'''),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = '''NFPO list of sales packaging types.
CBX: CNT_CODELIST (code list "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")
LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE
CORE_REL: T_NFPO_SALES_PACKAGING_TYPE''')
AS SELECT *
FROM nfpow_core.t_dim_nfpo_sales_packaging_type;
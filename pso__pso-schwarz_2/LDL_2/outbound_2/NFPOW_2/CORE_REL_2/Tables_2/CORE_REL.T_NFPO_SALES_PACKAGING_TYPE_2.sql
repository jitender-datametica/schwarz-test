/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_sales_packaging_type_2
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_sales_packaging_type_2 (
nfpo_sales_packaging_type_cd STRING(100) NOT NULL
OPTIONS(description='Code of the sales_2 packaging types.            CBX: CNT_CODELIST.CODE (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")            LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE.MDM_SALES_PACKAGING_TYPE_CD'),
nfpo_sales_packaging_type_name STRING(200)
OPTIONS(description='Name of the sales_2 packaging types.            CBX: CNT_CODELIST.NAME (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")            LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE.MDM_SALES_PACKAGING_TYPE_NAME'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_sales_packaging_type_cd) NOT ENFORCED
)
OPTIONS(description='NFPO list of sales_2 packaging types.             CBX: CNT_CODELIST_2 (code list "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")             LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE_2');
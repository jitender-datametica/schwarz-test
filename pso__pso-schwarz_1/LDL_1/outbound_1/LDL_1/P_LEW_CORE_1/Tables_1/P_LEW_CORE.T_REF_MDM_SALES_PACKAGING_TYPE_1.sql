/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_sales_packaging_type_1
   generated from Powerdesigner on Dienstag, 25. November 2025 15:31:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_sales_packaging_type_1 (
mdm_sales_packaging_type_cd STRING(100) NOT NULL
OPTIONS(description='Code of the sales_1 packaging types.            CBX: CNT_CODELIST.CODE (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")'),
mdm_sales_packaging_type_name STRING(200)
OPTIONS(description='Name of the sales_1 packaging types.            CBX: CNT_CODELIST.NAME (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_sales_packaging_type_cd) NOT ENFORCED
)
OPTIONS(description='NFPO list of sales_1 packaging types.             CBX: CNT_CODELIST_1 (code list "LDL_RETAIL_PACKAGING" and "LIDL_RETAILPACK_KL")');
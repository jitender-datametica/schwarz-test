/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_customer_need_type_2
   generated from Powerdesigner on Donnerstag, 12. September 2024 19:21:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_customer_need_type_2 (
mdm_cust_need_type_cd STRING(100) NOT NULL
OPTIONS(description='Code to classify the assortment by general customer needs.            CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")'),
mdm_cust_need_type_name STRING(100)
OPTIONS(description='Name of the general customer need.            CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_cust_need_type_cd) NOT ENFORCED
)
OPTIONS(description='Classification of the assortment by general customer needs.             CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")');
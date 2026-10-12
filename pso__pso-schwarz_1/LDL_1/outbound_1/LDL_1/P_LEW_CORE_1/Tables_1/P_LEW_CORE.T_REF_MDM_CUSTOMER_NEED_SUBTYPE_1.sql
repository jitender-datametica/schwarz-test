/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_customer_need_subtype_1
   generated from Powerdesigner on Mittwoch, 5. März 2025 10:18:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_customer_need_subtype_1 (
mdm_cust_need_subtype_cd STRING(100) NOT NULL
OPTIONS(description='Code to classify the assortment by detailed customer needs.            CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")'),
mdm_cust_need_type_cd STRING(100)
OPTIONS(description='Current code to classify the detailed customer need by general customer needs.            CBX: CMT_CODELIST_BOOK.cust_codelist1 (code list "LIDL_CATEGORY_NEEDS")'),
mdm_cust_need_subtype_name STRING(100)
OPTIONS(description='Name of the detailed customer need.            CBX: CNT_CODELIST.NAME (code list "LIDL_CATEGORY_NEEDS")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_cust_need_subtype_cd) NOT ENFORCED
)
OPTIONS(description='Classification of the assortment by detailed customer needs. The detailed customer needs are grouped into general customer needs.             CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")');
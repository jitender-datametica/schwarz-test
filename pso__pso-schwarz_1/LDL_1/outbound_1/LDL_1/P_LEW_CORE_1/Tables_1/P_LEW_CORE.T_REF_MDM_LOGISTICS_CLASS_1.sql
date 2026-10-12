/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_logistics_class_1
   generated from Powerdesigner on Dienstag, 25. November 2025 15:29:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_logistics_class_1 (
mdm_logistics_class_cd STRING(100) NOT NULL
OPTIONS(description='Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.            CBX: CNT_CODELIST.CODE (code list "LIDL_DELIVERYTYPE")'),
mdm_logistics_class_name STRING(100)
OPTIONS(description='Name to classify the way the items will be transported from the central warehouse of OWIM into the countries.            CBX: CNT_CODELIST.NAME (code list "LIDL_DELIVERYTYPE")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_logistics_class_cd) NOT ENFORCED
)
OPTIONS(description='NFPO classification of the way the items will be transported from the central warehouse of OWIM into the countries.             CBX: CNT_CODELIST_1 (code list "LIDL_DELIVERYTYPE")');
CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_supplier (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
mdm_sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key NFPO supplier            CBX: CNT_VENDOR.REF_NO'),
src_vendor_doc_ref STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='NFPO supplier identifier            CBX: CNT_VENDOR.REF_NO'),
sup_nr BIGNUMERIC(38,0) OPTIONS(description='EKS supplier number            CBX: CNT_VENDOR.REFERENCE'),
sup_name STRING(100) OPTIONS(description='name of the NFPO supplier            CBX: CNT_VENDOR.BUSINESS_NAME'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_sup_sid) NOT ENFORCED
) OPTIONS(description='NFPO related vendor definition             CBX: CNT_VENDOR, CTM_VENDOR');
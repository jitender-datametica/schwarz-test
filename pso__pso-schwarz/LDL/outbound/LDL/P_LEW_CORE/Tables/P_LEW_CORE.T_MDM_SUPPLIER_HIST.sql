CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_supplier_hist (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
mdm_sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key NFPO supplier            CBX: CNT_VENDOR.REF_NO'),
cbx_vendor_version_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical version of the NFPO supplier in the source system            CBX: CNT_VENDOR.VERSION'),
sup_ship_terms_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='NFPO supplier related shipping term codes            CBX: CTMVENDOR.CUST_CODELIST2'),
ean_ownership_cd STRING(100)
OPTIONS(description='NFPO GTIN assignement responisbility code            CBX: CTM_VENDOR.CUST_CODELIST1'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to '),
dwh_valid_from DATE NOT NULL
OPTIONS(description='begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='end of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_sup_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='NFPO related vendor definition             CBX: CNT_VENDOR, CTM_VENDOR             ');
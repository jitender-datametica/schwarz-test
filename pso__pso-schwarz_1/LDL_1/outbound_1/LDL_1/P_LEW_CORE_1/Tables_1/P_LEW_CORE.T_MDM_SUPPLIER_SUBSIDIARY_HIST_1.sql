CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_supplier_subsidiary_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO supplier_1
            CBX: CNT_VENDOR.REF_NO'''),
addr_sid BIGNUMERIC(38,0)
OPTIONS(description='''Surrogate Key ADDRESS_1
            CBX: CNT_VENDOR_ADDRESS.CITY, POSTAL_CODE, COUNTRY_1, ADDRESS1'''),
sup_subsidiary_seq_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''NFPO internal sequence of the subsidiary
            CBX:CNT_VENDOR_ADDRESS.INTERNAL_SEQ_NO'''),
subsidiary_name STRING(100)
OPTIONS(description='''name of the subsidiary of the supplier_1
            CBX:CNT_VENDOR_ADDRESS,BUSINESS_NAME'''),
default_fg BIGNUMERIC(38,0)
OPTIONS(description='''indicates whether this subsidiary is the default one. the address_1 of the default subsidiary will be regarded as the address_1 of the supplier.
            CBX:CNT_VENDOR_ADDRESS.IS_DEFAULT'''),
active_fg BIGNUMERIC(38,0)
OPTIONS(description='''indicates whether a certain subsidiary has been disabled
            CBX:CNT_VENDOR_ADDRESS.DISABLED'''),
vat_nr STRING(100)
OPTIONS(description='''local vat number of the subsidiary of the supplier_1
            CBX: CNT_VENDOR_ADDRESS.LDL_VAT_NO'''),
eks_sup_nr STRING(100)
OPTIONS(description='''identifier of this subsidiary in EKS
            CBX:CNT_VENDOR_ADDRESS.LDL_EKS_NO'''),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to '),
dwh_valid_from DATE NOT NULL
OPTIONS(description='begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='end of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_sup_sid, sup_subsidiary_seq_nr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='''NFPO related vendor subsidiary definition
             CBX: CNT_VENDOR_ADDRESS''');
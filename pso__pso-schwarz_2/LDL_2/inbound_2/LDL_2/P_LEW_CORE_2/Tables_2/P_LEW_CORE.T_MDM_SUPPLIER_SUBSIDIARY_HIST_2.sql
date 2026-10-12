CREATE TABLE P_LEW_CORE.T_MDM_SUPPLIER_SUBSIDIARY_HIST_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_sup_sid                         NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO supplier_2
            CBX: CNT_VENDOR.REF_NO',
   addr_sid                            NUMBER(38,0)    COMMENT 'Surrogate Key ADDRESS_2
            CBX: CNT_VENDOR_ADDRESS.CITY, POSTAL_CODE, COUNTRY_2, ADDRESS1',
   sup_subsidiary_seq_nr               NUMBER(38,0)    NOT NULL COMMENT 'NFPO internal sequence of the subsidiary
            CBX:CNT_VENDOR_ADDRESS.INTERNAL_SEQ_NO',
   subsidiary_name                     VARCHAR(100)    COMMENT 'name of the subsidiary of the supplier_2
            CBX:CNT_VENDOR_ADDRESS,BUSINESS_NAME',
   default_fg                          NUMBER(38,0)    COMMENT 'indicates whether this subsidiary is the default one. the address_2 of the default subsidiary will be regarded as the address_2 of the supplier.
            CBX:CNT_VENDOR_ADDRESS.IS_DEFAULT',
   active_fg                           NUMBER(38,0)    COMMENT 'indicates whether a certain subsidiary has been disabled
            CBX:CNT_VENDOR_ADDRESS.DISABLED',
   vat_nr                              VARCHAR(100)    COMMENT 'local vat number of the subsidiary of the supplier_2
            CBX: CNT_VENDOR_ADDRESS.LDL_VAT_NO',
   eks_sup_nr                          VARCHAR(100)    COMMENT 'identifier of this subsidiary in EKS
            CBX:CNT_VENDOR_ADDRESS.LDL_EKS_NO',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_SUPPLIER_SUBSIDIARY_HIST PRIMARY KEY (mdm_sup_sid, sup_subsidiary_seq_nr, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'NFPO related vendor subsidiary definition
             CBX: CNT_VENDOR_ADDRESS';
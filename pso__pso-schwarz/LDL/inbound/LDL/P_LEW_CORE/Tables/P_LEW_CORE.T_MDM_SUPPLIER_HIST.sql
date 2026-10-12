CREATE TABLE P_LEW_CORE.T_MDM_SUPPLIER_HIST (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_sup_sid                         NUMBER(38,0)    NOT NULL COMMENT 'surrogate key NFPO supplier
            CBX: CNT_VENDOR.REF_NO',
   cbx_vendor_version_nr               NUMBER(38,0)    NOT NULL COMMENT 'technical version of the NFPO supplier in the source system
            CBX: CNT_VENDOR.VERSION',
   sup_ship_terms_cd                   VARCHAR(20)     COLLATE 'en-ci' COMMENT 'NFPO supplier related shipping term codes
            CBX: CTMVENDOR.CUST_CODELIST2',
   ean_ownership_cd                    VARCHAR(100)    COMMENT 'NFPO GTIN assignement responisbility code
            CBX: CTM_VENDOR.CUST_CODELIST1',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_SUPPLIER_HIST PRIMARY KEY (mdm_sup_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'NFPO related vendor definition
             CBX: CNT_VENDOR, CTM_VENDOR
             ';
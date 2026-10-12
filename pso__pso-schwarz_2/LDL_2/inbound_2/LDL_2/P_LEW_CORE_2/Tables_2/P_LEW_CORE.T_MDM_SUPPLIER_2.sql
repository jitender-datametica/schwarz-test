CREATE TABLE P_LEW_CORE.T_MDM_SUPPLIER_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_sup_sid                         NUMBER(38,0)    NOT NULL COMMENT 'surrogate key NFPO supplier_2
            CBX: CNT_VENDOR.REF_NO',
   src_vendor_doc_ref                  VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'NFPO supplier_2 identifier
            CBX: CNT_VENDOR.REF_NO',
   sup_nr                              NUMBER(38,0)    COMMENT 'EKS supplier_2 number
            CBX: CNT_VENDOR.REFERENCE',
   sup_name                            VARCHAR(100)    COMMENT 'name of the NFPO supplier_2
            CBX: CNT_VENDOR.BUSINESS_NAME',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_SUPPLIER PRIMARY KEY (mdm_sup_sid) NOT ENFORCED 
)  COMMENT = 'NFPO related vendor definition
             CBX: CNT_VENDOR_2, CTM_VENDOR_2';
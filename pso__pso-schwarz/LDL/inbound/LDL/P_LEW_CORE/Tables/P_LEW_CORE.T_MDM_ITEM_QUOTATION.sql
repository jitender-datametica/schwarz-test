/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_quotation
   generated from Powerdesigner on Dienstag, 25. November 2025 15:39:04
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MDM_ITEM_QUOTATION (
   mdm_item_quotation_sid              NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key of the item quotation.
            CBX: CNT_VQ.REF_NO',
   src_item_quotation_nr               VARCHAR(100)     NOT NULL COMMENT 'Identifier of the item quotation in the source system.
            CBX: CNT_VQ.REF_NO',
   mdm_item_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key NFPO item instance.
            CBX: CNT_VQ.ITEM_REF',
   mdm_sup_sid                         NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key NFPO supplier.
            CBX: CNT_VQ.VENDOR_REF',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MDM_ITEM_QUOTATION PRIMARY KEY (mdm_item_quotation_sid) NOT ENFORCED 
)  COMMENT = 'This table contains information about quotations for items provided by suppliers.
             CBX: CNT_VQ';

/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_quotation
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_QUOTATION DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_quotation_sid             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key of the item quotation.
            CBX: CNT_VQ.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION.MDM_ITEM_QUOTATION_SID',
   nfpo_item_quotation_nr              VARCHAR(100)     NOT NULL COMMENT 'Identifier of the item quotation in the source system.
            CBX: CNT_VQ.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION.SRC_ITEM_QUOTATION_NR',
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ITEM INSTANCE.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION.MDM_ITEM_SID',
   nfpo_sup_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key NFPO SUPPLIER.
            CBX: CNT_VQ.VENDOR_REF
            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION.MDM_SUP_SID',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_QUOTATION PRIMARY KEY (nfpo_item_quotation_sid) NOT ENFORCED 
)  COMMENT = 'This table contains information about quotations for items provided by suppliers.
             CBX: CNT_VQ
             LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION';


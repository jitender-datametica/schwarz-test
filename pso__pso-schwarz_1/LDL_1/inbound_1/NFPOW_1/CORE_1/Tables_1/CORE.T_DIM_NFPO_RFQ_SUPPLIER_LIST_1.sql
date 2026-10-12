/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_rfq_supplier_list_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:53:35
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_RFQ_SUPPLIER_LIST_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_rfq_sup_list_txt               VARCHAR(4000)    NOT NULL COMMENT 'Surrogate Key NFPO SUPPLIER.
            CBX: CNT_ITEM_SLN.REF_REF (field_id = ''ldlRFQVendors'')
            LDL: P_LEW_CORE.T_MDM_ITEM_RFQ_SUPPLIER_HIST.MDM_RFQ_SUP_SID',
   nfpo_rfq_sup_name_list_txt          VARCHAR(10000)   NOT NULL COMMENT 'Surrogate Key NFPO SUPPLIER.
            CBX: CNT_ITEM_SLN.REF_REF (field_id = ''ldlRFQVendors'')
            LDL: P_LEW_CORE.T_MDM_ITEM_RFQ_SUPPLIER_HIST.MDM_RFQ_SUP_SID',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_RFQ_SUPPLIER_HIST.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_RFQ_SUPPLIER_HIST.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_RFQ_SUPPLIER_LIST PRIMARY KEY (nfpo_rfq_sup_list_txt) NOT ENFORCED 
)  COMMENT = 'Information about suppliers requested for quotes for NFPO items.';

/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_rfq_supplier_list_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:53:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_rfq_supplier_list_1 (
nfpo_rfq_sup_list_txt STRING(4000) NOT NULL
OPTIONS(description='''Surrogate Key NFPO SUPPLIER.
            CBX: CNT_ITEM_SLN.REF_REF (field_id = \'ldlRFQVendors\')
            LDL: P_LEW_CORE.T_MDM_ITEM_RFQ_SUPPLIER_HIST.MDM_RFQ_SUP_SID'''),
nfpo_rfq_sup_name_list_txt STRING(10000) NOT NULL
OPTIONS(description='''Surrogate Key NFPO SUPPLIER.
            CBX: CNT_ITEM_SLN.REF_REF (field_id = \'ldlRFQVendors\')
            LDL: P_LEW_CORE.T_MDM_ITEM_RFQ_SUPPLIER_HIST.MDM_RFQ_SUP_SID'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_RFQ_SUPPLIER_HIST.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_RFQ_SUPPLIER_HIST.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_rfq_sup_list_txt) NOT ENFORCED
) OPTIONS(description='Information about suppliers requested for quotes for NFPO items.');
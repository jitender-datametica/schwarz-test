/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_quotation_2
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_quotation_2 (
nfpo_item_quotation_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key of the item_2 quotation.            CBX: CNT_VQ.REF_NO            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION.MDM_ITEM_QUOTATION_SID'),
nfpo_item_quotation_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the item_2 quotation in the source system.            CBX: CNT_VQ.REF_NO            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION.SRC_ITEM_QUOTATION_NR'),
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO ITEM_2 INSTANCE.            CBX: CNT_ITEM.REF_NO            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION.MDM_ITEM_SID'),
nfpo_sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key NFPO SUPPLIER.            CBX: CNT_VQ.VENDOR_REF            LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION.MDM_SUP_SID'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_quotation_sid) NOT ENFORCED
)
OPTIONS(description='This table contains information about quotations for items provided by suppliers.             CBX: CNT_VQ             LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_2');
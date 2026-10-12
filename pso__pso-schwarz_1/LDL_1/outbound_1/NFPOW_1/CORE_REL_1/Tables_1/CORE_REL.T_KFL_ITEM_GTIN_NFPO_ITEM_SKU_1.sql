/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_gtin_nfpo_item_sku_1
   generated from Powerdesigner on Montag, 30. September 2024 17:18:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_item_gtin_nfpo_item_sku_1 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.art.mandant_id'),
kfl_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL item_1 (Artikel_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.art.art_id'),
kfl_gtin_nr STRING(100) NOT NULL
OPTIONS(description='Assigned GTIN of the NFPO stock keeping unit_1 for Kaufland.            CBX: CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV_1, LDL_ITEM_ARTICLE_EAN.LDL_EAN_KL            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.KFL_BARCODE'),
nfpo_item_sku_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Foreign Key NFPO STOCK KEEPING UNIT.            CBX: CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV_1, LDL_ITEM_ARTICLE_EAN.CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.MDM_ITEM_SKU_SID'),
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key of the related NFPO ITEM_1 INSTANCE'),
nfpo_item_sel_nr STRING(100) OPTIONS(description='NFPO source system internal identifier of the related article'),
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='related Lidl International Item_1 number'),
ldl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key of the related Lidl ERP client in the Lidl DWH'),
nfpo_parent_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key of the parent of the related NFPO ITEM_1 INSTANCE'),
ldl_parent_item_ian_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lidl International Item_1 Number of the parent of the related NFPO ITEM_1 INSTANCE'),
pseudo_ldl_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='constructed identifier of the Kaufland item_1 in the Lidl item_1 context'),
nfpo_default_item_sku_fg BOOL
OPTIONS(description='indicator whether this is the record which should be used to have an unique target item_1 record in NFPO (and LDL) in the case that more then one possible target record exist (for example for catalog items)'),
nfpo_item_kfl_item_assigned_txn_period_begin_dt DATE NOT NULL,
nfpo_item_kfl_item_assigned_txn_period_end_dt DATE NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction'),
PRIMARY KEY (kfl_client_id, kfl_item_nr, kfl_gtin_nr, nfpo_item_sku_sid) NOT ENFORCED
)
OPTIONS(description='This table relates Kaufland item_1 + GTIN combinations to stock keeping units in CBX using the GTINs assigned to Kaufland items in the Kaufland DWH and the GTINs assigned to stock keeping units in CBX.');
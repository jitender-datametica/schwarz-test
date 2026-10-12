/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_nfpo_item_1
   generated from Powerdesigner on Friday, 28 June 2024 13:47:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_item_nfpo_item_1 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.art.mandant_id'),
kfl_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL item_1 (Artikel_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.art.art_id'),
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
nfpo_default_item_fg BOOL
OPTIONS(description='indicator whether this is the record which should be used to have an unique target item_1 record in NFPO (and LDL) in the case that more then one possible target record exist (for example for catalog items)'),
nfpo_item_kfl_item_assigned_txn_period_begin_dt DATE NOT NULL,
nfpo_item_kfl_item_assigned_txn_period_end_dt DATE NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction'),
PRIMARY KEY (kfl_client_id, kfl_item_nr, nfpo_item_sid) NOT ENFORCED
)
OPTIONS(description='This table relates Kaufland items to items in CBX and Lidl using the GTINs assigned to Kaufland items in the Kaufland DWH and the GTINs assigned to stock keeping units in CBX.');
/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_item_organization_packing_list_position
   generated from Powerdesigner on Donnerstag, 6. November 2025 15:51:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_nfpo_item_organization_packing_list_position (
nfpo_item_pack_list_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO PACKING LIST.            CBX: CNT_ITEM,            LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO,             LDL_ITEM_PACKING_METHOD.LDL_CODE            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_PACK_LIST_SID'),
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key INTERNAL ORGANIZATION.            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID'),
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Foreign Key NFPO ITEM INSTANCE.            CBX: CNT_ITEM.REF_NO            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_ITEM_SID'),
nfpo_gtin_nr STRING(100) NOT NULL
OPTIONS(description='Assigned GTIN of one or more NFPO stock keeping units. A dummy value is used to represent unknown variants of known items.            CBX: CNT_ITEM, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_SIZE, LDL_ITEM_LSV, LDL_ITEM_ARTICLE_EAN.LDL_EAN, LDL_EAN_KL            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.BARCODE, KFL_BARCODE            CORE_REL: T_NFPO_ITEM_SKU_GTIN_HIST.LDL_GTIN_NR, KFL_GTIN_NR'),
nfpo_item_pack_list_pos_prio BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sequence number of the position in the pack list.            CBX: LDL_ITEM_PACK_ASSORT_SIZE.INTERNAL_SEQ_NO            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_POS_HIST.PACK_LIST_POS_PRIORITY'),
nfpo_item_pack_list_pos_qty BIGNUMERIC(38,5)
OPTIONS(description='Calculated packed quantity of the item variant represented by the position in the pack list.            CBX: LDL_ITEM_PACKING_METHOD,            LDL_ITEM_PACK_ASSORT_SIZE, LDL_ITEM_PACKING_METHOD.LDL_TOTAL_PACK_RATIO, LDL_ITEM_PACK_ASSORT_SIZE.LDL_QUANTITY            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_POS_HIST.PACK_LIST_POS_PACK_QTY'),
nfpo_item_pack_list_pos_pct BIGNUMERIC(38,5)
OPTIONS(description='Percentage of the sales variant in the complete packing list.'),
nfpo_total_order_qty BIGNUMERIC(38,5)
OPTIONS(description='Total quantity of pieces of the item sales variant ordered by the organization using this packing list.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_pack_list_sid, nfpo_org_sid, nfpo_item_sid, nfpo_gtin_nr) NOT ENFORCED
)
OPTIONS(description='This table holds information about the quantity of item sales variants in the pack lists of items used by organizations.             CBX: LDL_ITEM_PACKING_METHOD             LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_POS_HIST             CORE_REL: T_NFPO_ITEM_PACKING_LIST_POS_HIST');
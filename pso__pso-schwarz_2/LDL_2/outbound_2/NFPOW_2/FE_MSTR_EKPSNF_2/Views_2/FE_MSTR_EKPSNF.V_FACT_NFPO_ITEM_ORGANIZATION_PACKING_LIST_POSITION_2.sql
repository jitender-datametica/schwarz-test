CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_fact_nfpo_item_organization_packing_list_position_2 (nfpo_item_pack_list_sid
OPTIONS(description='''Surrogate Key NFPO PACKING LIST.
CBX: CNT_ITEM_2,
LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
LDL_ITEM_PACKING_METHOD.LDL_CODE
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_PACK_LIST_SID'''),
nfpo_org_sid
OPTIONS(description='''Surrogate Key INTERNAL ORGANIZATION.
LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID'''),
nfpo_item_sid
OPTIONS(description='''Foreign Key NFPO ITEM_2 INSTANCE.
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_ITEM_SID'''),
nfpo_gtin_nr
OPTIONS(description='''Assigned GTIN of one or more NFPO stock keeping units. A dummy_2 value is used to represent unknown variants of known items.
CBX: CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV_2, LDL_ITEM_ARTICLE_EAN.LDL_EAN, LDL_EAN_KL
LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.BARCODE, KFL_BARCODE
CORE_REL: T_NFPO_ITEM_SKU_GTIN_HIST.LDL_GTIN_NR, KFL_GTIN_NR'''),
nfpo_item_pack_list_pos_prio
OPTIONS(description='''Sequence number of the position in the pack list.
CBX: LDL_ITEM_PACK_ASSORT_SIZE.INTERNAL_SEQ_NO
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_POS_HIST.PACK_LIST_POS_PRIORITY'''),
nfpo_item_pack_list_pos_qty
OPTIONS(description='''Calculated packed quantity of the item_2 variant represented by the position in the pack list.
CBX: LDL_ITEM_PACKING_METHOD_2,
LDL_ITEM_PACK_ASSORT_SIZE, LDL_ITEM_PACKING_METHOD.LDL_TOTAL_PACK_RATIO, LDL_ITEM_PACK_ASSORT_SIZE.LDL_QUANTITY
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_POS_HIST.PACK_LIST_POS_PACK_QTY'''),
nfpo_item_pack_list_pos_pct OPTIONS(description='Percentage of the sales_2 variant in the complete packing list.'),
nfpo_total_order_qty
OPTIONS(description='Total quantity of pieces of the item_2 sales_2 variant ordered by the organization using this packing list.'),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = '''This table holds information about the quantity of item_2 sales_2 variants in the pack lists of items used by organizations.
CBX: LDL_ITEM_PACKING_METHOD_2
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_POS_HIST_2
CORE_REL: T_NFPO_ITEM_PACKING_LIST_POS_HIST_2''')
AS SELECT *
FROM nfpow_core.t_fact_nfpo_item_organization_packing_list_position_2;
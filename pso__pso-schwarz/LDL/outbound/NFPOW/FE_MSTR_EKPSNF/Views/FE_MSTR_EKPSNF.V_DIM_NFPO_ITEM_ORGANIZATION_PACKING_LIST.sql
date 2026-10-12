CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_item_organization_packing_list (nfpo_item_pack_list_sid
OPTIONS(description='''Surrogate Key NFPO PACKING LIST.
CBX: CNT_ITEM,
LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
LDL_ITEM_PACKING_METHOD.LDL_CODE
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_PACK_LIST_SID'''),
nfpo_org_sid
OPTIONS(description='''Surrogate Key INTERNAL ORGANIZATION.
LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID'''),
nfpo_item_sid
OPTIONS(description='''Foreign Key NFPO ITEM INSTANCE.
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_ITEM_SID'''),
nfpo_item_pack_list_name
OPTIONS(description='''Name of the NFPO packing list.
CBX: LDL_ITEM_PACKING_METHOD.LDL_NAME
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_HIST.PACK_LIST_NAME'''),
nfpo_item_pack_list_carton_qty
OPTIONS(description='''NFPO packing list sub case quantity.
CBX: LDL_ITEM_PACKING_METHOD.LDL_TOTAL_PACK_RATIO
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_HIST.PACK_LIST_CARTON_QTY'''),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = '''Information about packing lists for the sort boxes of NFPO items by organization.
CBX: LDL_ITEM_PACKING_METHOD
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST, P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_CLIENT_HIST
CORE_REL: T_NFPO_ITEM_PACKING_LIST, T_NFPO_ITEM_PACKING_LIST_HIST, T_NFPO_ITEM_PACKING_LIST_ORGANIZATION_HIST''')
AS SELECT *
FROM nfpow_core.t_dim_nfpo_item_organization_packing_list;
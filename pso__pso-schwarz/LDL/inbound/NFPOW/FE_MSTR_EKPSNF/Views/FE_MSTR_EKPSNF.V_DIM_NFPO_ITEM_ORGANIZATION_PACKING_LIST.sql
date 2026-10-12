CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_ITEM_ORGANIZATION_PACKING_LIST (
   nfpo_item_pack_list_sid                  COMMENT 'Surrogate Key NFPO PACKING LIST.
CBX: CNT_ITEM,
LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
LDL_ITEM_PACKING_METHOD.LDL_CODE
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_PACK_LIST_SID'
  ,nfpo_org_sid                             COMMENT 'Surrogate Key INTERNAL ORGANIZATION.
LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID'
  ,nfpo_item_sid                            COMMENT 'Foreign Key NFPO ITEM INSTANCE.
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_ITEM_SID'
  ,nfpo_item_pack_list_name                 COMMENT 'Name of the NFPO packing list.
CBX: LDL_ITEM_PACKING_METHOD.LDL_NAME
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_HIST.PACK_LIST_NAME'
  ,nfpo_item_pack_list_carton_qty           COMMENT 'NFPO packing list sub case quantity.
CBX: LDL_ITEM_PACKING_METHOD.LDL_TOTAL_PACK_RATIO
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_HIST.PACK_LIST_CARTON_QTY'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'Information about packing lists for the sort boxes of NFPO items by organization.
CBX: LDL_ITEM_PACKING_METHOD
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST, P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_CLIENT_HIST
CORE_REL: T_NFPO_ITEM_PACKING_LIST, T_NFPO_ITEM_PACKING_LIST_HIST, T_NFPO_ITEM_PACKING_LIST_ORGANIZATION_HIST'
AS SELECT
   nfpo_item_pack_list_sid
  ,nfpo_org_sid
  ,nfpo_item_sid
  ,nfpo_item_pack_list_name
  ,nfpo_item_pack_list_carton_qty
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_ITEM_ORGANIZATION_PACKING_LIST
;
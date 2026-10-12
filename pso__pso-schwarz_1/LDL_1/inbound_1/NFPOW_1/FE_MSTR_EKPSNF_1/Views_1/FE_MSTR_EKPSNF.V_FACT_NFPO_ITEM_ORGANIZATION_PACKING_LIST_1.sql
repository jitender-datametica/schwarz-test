CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_FACT_NFPO_ITEM_ORGANIZATION_PACKING_LIST_1 (
   nfpo_item_pack_list_sid                  COMMENT 'Surrogate Key NFPO PACKING LIST.
CBX: CNT_ITEM_1,
LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
LDL_ITEM_PACKING_METHOD.LDL_CODE
LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_PACK_LIST_SID'
  ,nfpo_org_sid                             COMMENT 'Surrogate Key INTERNAL ORGANIZATION.
LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID'
  ,nfpo_total_item_org_order_case_qty       COMMENT 'Total order case quantity.
CBX: LDL_ITEM_QUANTITY.LDL_CTRY_TOTAL_NUM_OF_CTN
LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.CLIENT_ORDER_TOTAL_CASE_QTY'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'This table contains facts about the pack lists of items used by organizations.
CORE_REL: T_NFPO_ITEM_PACKING_LIST_1, T_NFPO_ITEM_PACKING_LIST_ORGANIZATION_HIST_1, T_NFPO_ITEM_ORGANIZATION_ORDER_HIST_1'
AS SELECT
   nfpo_item_pack_list_sid
  ,nfpo_org_sid
  ,nfpo_total_item_org_order_case_qty
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_FACT_NFPO_ITEM_ORGANIZATION_PACKING_LIST_1
;
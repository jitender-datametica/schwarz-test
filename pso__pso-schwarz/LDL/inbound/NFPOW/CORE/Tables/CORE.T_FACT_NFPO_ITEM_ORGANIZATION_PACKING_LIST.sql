/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_item_organization_packing_list
   generated from Powerdesigner on Donnerstag, 6. November 2025 15:47:16
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_NFPO_ITEM_ORGANIZATION_PACKING_LIST DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_pack_list_sid             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO PACKING LIST.
            CBX: CNT_ITEM,
            LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
            LDL_ITEM_PACKING_METHOD.LDL_CODE
            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_PACK_LIST_SID',
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key INTERNAL ORGANIZATION.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID',
   nfpo_total_item_org_order_case_qty  NUMBER(38,5)     COMMENT 'Total order case quantity.
            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_TOTAL_NUM_OF_CTN
            LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.CLIENT_ORDER_TOTAL_CASE_QTY',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_NFPO_ITEM_ORGANIZATION_PACKING_LIST PRIMARY KEY (nfpo_item_pack_list_sid, nfpo_org_sid) NOT ENFORCED 
)  COMMENT = 'This table contains facts about the pack lists of items used by organizations.
             CORE_REL: T_NFPO_ITEM_PACKING_LIST, T_NFPO_ITEM_PACKING_LIST_ORGANIZATION_HIST, T_NFPO_ITEM_ORGANIZATION_ORDER_HIST';

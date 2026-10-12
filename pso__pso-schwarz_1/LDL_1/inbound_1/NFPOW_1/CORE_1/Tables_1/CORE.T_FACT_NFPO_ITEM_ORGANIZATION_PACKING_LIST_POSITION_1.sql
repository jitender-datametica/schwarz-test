/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_item_organization_packing_list_position_1
   generated from Powerdesigner on Donnerstag, 6. November 2025 15:51:18
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_NFPO_ITEM_ORGANIZATION_PACKING_LIST_POSITION_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_pack_list_sid             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO PACKING LIST.
            CBX: CNT_ITEM_1,
            LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
            LDL_ITEM_PACKING_METHOD.LDL_CODE
            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_PACK_LIST_SID',
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key INTERNAL ORGANIZATION.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID',
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key NFPO ITEM_1 INSTANCE.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_ITEM_SID',
   nfpo_gtin_nr                        VARCHAR(100)     NOT NULL COMMENT 'Assigned GTIN of one or more NFPO stock keeping units. A dummy_1 value is used to represent unknown variants of known items.
            CBX: CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV_1, LDL_ITEM_ARTICLE_EAN.LDL_EAN, LDL_EAN_KL
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.BARCODE, KFL_BARCODE
            CORE_REL: T_NFPO_ITEM_SKU_GTIN_HIST.LDL_GTIN_NR, KFL_GTIN_NR',
   nfpo_item_pack_list_pos_prio        NUMBER(38,0)     NOT NULL COMMENT 'Sequence number of the position in the pack list.
            CBX: LDL_ITEM_PACK_ASSORT_SIZE.INTERNAL_SEQ_NO
            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_POS_HIST.PACK_LIST_POS_PRIORITY',
   nfpo_item_pack_list_pos_qty         NUMBER(38,5)     COMMENT 'Calculated packed quantity of the item_1 variant represented by the position in the pack list.
            CBX: LDL_ITEM_PACKING_METHOD_1,
            LDL_ITEM_PACK_ASSORT_SIZE, LDL_ITEM_PACKING_METHOD.LDL_TOTAL_PACK_RATIO, LDL_ITEM_PACK_ASSORT_SIZE.LDL_QUANTITY
            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_POS_HIST.PACK_LIST_POS_PACK_QTY',
   nfpo_item_pack_list_pos_pct         NUMBER(38,5)     COMMENT 'Percentage of the sales_1 variant in the complete packing list.',
   nfpo_total_order_qty                NUMBER(38,5)     COMMENT 'Total quantity of pieces of the item_1 sales_1 variant ordered by the organization using this packing list.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_NFPO_ITEM_ORGANIZATION_PACKING_LIST_POSITION PRIMARY KEY (nfpo_item_pack_list_sid, nfpo_org_sid, nfpo_item_sid, nfpo_gtin_nr) NOT ENFORCED 
)  COMMENT = 'This table holds information about the quantity of item_1 sales_1 variants in the pack lists of items used by organizations.
             CBX: LDL_ITEM_PACKING_METHOD_1
             LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_POS_HIST_1
             CORE_REL: T_NFPO_ITEM_PACKING_LIST_POS_HIST_1';

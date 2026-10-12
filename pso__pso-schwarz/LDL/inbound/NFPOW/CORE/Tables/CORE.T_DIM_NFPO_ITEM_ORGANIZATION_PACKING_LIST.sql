/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_organization_packing_list
   generated from Powerdesigner on Donnerstag, 6. November 2025 15:44:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ITEM_ORGANIZATION_PACKING_LIST DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_pack_list_sid             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO PACKING LIST.
            CBX: CNT_ITEM,
            LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
            LDL_ITEM_PACKING_METHOD.LDL_CODE
            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_PACK_LIST_SID',
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key INTERNAL ORGANIZATION.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID',
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key NFPO ITEM INSTANCE.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST.MDM_ITEM_SID',
   nfpo_item_pack_list_name            VARCHAR(100)     COMMENT 'Name of the NFPO packing list.
            CBX: LDL_ITEM_PACKING_METHOD.LDL_NAME
            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_HIST.PACK_LIST_NAME',
   nfpo_item_pack_list_carton_qty      NUMBER(38,5)     COMMENT 'NFPO packing list sub case quantity.
            CBX: LDL_ITEM_PACKING_METHOD.LDL_TOTAL_PACK_RATIO
            LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_HIST.PACK_LIST_CARTON_QTY',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ITEM_ORGANIZATION_PACKING_LIST PRIMARY KEY (nfpo_item_pack_list_sid, nfpo_org_sid) NOT ENFORCED 
)  COMMENT = 'Information about packing lists for the sort boxes of NFPO items by organization.
             CBX: LDL_ITEM_PACKING_METHOD
             LDL: P_LEW_CORE.T_MDM_ITEM_PACKING_LIST, P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_CLIENT_HIST
             CORE_REL: T_NFPO_ITEM_PACKING_LIST, T_NFPO_ITEM_PACKING_LIST_HIST, T_NFPO_ITEM_PACKING_LIST_ORGANIZATION_HIST';

/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_ldl_item_2
   generated from Powerdesigner on Donnerstag, 17. August 2023 15:45:59
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_LDL_ITEM_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key NFPO ITEM_2 INSTANCE.
            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.MDM_ITEM_SID',
   ldl_item_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key of the ERP system based item_2 variant (overarching unique, not just within a certain client).
            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.ITEM_SID',
   ldl_item_role_cd                    VARCHAR(100)     NOT NULL COMMENT 'Role of the ERP system based item_2 variant in the relation to the CBX based item.
            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.CLIENT_ITEM_ROLE_CD',
   ldl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key of the ERP client of the item_2 related to the NFPO item_2 instance.
            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.CLIENT_ID',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_LDL_ITEM PRIMARY KEY (ldl_item_sid, nfpo_item_sid) NOT ENFORCED 
)  COMMENT = 'Relation between NFPO items and local ERP system based items.
             Populated by algorithm using t_item_2 and t_mdm_item_2 and the IAN of the NFPO item.
             LDL: P_LEW_CORE.T_ITEM_MDM_LINK_2';

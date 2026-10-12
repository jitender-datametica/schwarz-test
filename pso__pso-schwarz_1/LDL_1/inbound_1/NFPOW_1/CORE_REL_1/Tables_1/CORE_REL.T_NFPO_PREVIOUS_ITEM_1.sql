/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_previous_item_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:09:41
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_PREVIOUS_ITEM_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID',
   nfpo_prev_item_lvl_nr               NUMBER(38,0)     NOT NULL,
   nfpo_prev_item_sid                  NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_PREVIOUS_ITEM PRIMARY KEY (nfpo_item_sid, nfpo_prev_item_lvl_nr) NOT ENFORCED 
)  COMMENT = 'NFPO previous (predecessor) items, all levels available.';

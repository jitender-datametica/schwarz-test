/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_status_2
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ITEM_STATUS_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_status_cd                 VARCHAR(100)     NOT NULL COMMENT 'Technical status_2 of the NFPO item_2 in the source system (active, inactive, cancelled).
            CBX: CNT_ITEM.DOC_STATUS
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_DOC_STATUS',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ITEM_STATUS PRIMARY KEY (nfpo_item_status_cd) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';


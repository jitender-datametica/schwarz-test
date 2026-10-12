/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_property_list_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ITEM_PROPERTY_LIST_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_property_list_txt         VARCHAR(1000)    NOT NULL COMMENT 'Property of the item.
            CBX: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY
            LDL: P_LEW_CORE.T_MDM_ITEM_PROPERTY_ITEM_HIST.MDM_ITEM_PROPERTY_TXT',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_PROPERTY_ITEM_HIST.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_PROPERTY_ITEM_HIST.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ITEM_PROPERTY_LIST PRIMARY KEY (nfpo_item_property_list_txt) NOT ENFORCED 
)  COMMENT = 'Additional properties of NFPO items.
             CBX: LDL_ITEM_CERTIFICATION
             LDL: P_LEW_CORE.T_MDM_ITEM_PROPERTY_ITEM_HIST_1';


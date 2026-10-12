/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_unit_unit_of_measurement_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ITEM_UNIT_UNIT_OF_MEASUREMENT_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_unit_uom_nr               VARCHAR(100)     NOT NULL,
   nfpo_item_unit_uom_cd               VARCHAR(100)     COMMENT 'Indicator in the item_1 planning process: code of the item_1 content unit_1 of measurement. Interpretation depends on the overall composition of the item.
            CBX: CNT_ITEM.LDL_CONTAINER_UNIT
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_UNIT_UOM_CD',
   nfpo_item_unit_uom_name             VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ITEM_UNIT_UNIT_OF_MEASUREMENT PRIMARY KEY (nfpo_item_unit_uom_nr) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';


/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_composition_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_ITEM_COMPOSITION_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_composition_cd            VARCHAR(100)     NOT NULL COMMENT 'Code of the indicator in the item_1 planning process: indicates whether an item_1 has relevant variants or consists of certain sub parts. Interpretation depends on the overall composition of the item_1 (assort or assemble: (x)fach sortiert oder (x)teilig).
            CBX: CNT_CODELIST.CODE (code list ''LIDL_ASSORTMENT'')
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_COMPOSITION.MDM_ITEM_COMPOSITION_CD',
   nfpo_item_composition_txt           VARCHAR(1000)    NOT NULL COMMENT 'Text of the indicator in the item_1 planning process: indicates whether an item_1 has relevant variants or consists of certain sub parts. Interpretation depends on the overall composition of the item_1 (assort or assemble: (x)fach sortiert oder (x)teilig).
            CBX: CNT_CODELIST.NAME (code list ''LIDL_ASSORTMENT'')
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_COMPOSITION.MDM_ITEM_COMPOSITION_TXT',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_COMPOSITION.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_COMPOSITION.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_ITEM_COMPOSITION PRIMARY KEY (nfpo_item_composition_cd) NOT ENFORCED 
)  COMMENT = 'List of item_1 composition codes, indicates whether an item_1 has relevant variants or consists of certain sub parts. Interpretation depends on the overall composition of the item. Assort or assemble: (x)fach sortiert oder (x)teilig.';


/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_composition_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:39:30
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_ITEM_COMPOSITION_1 (
   mdm_item_composition_cd             VARCHAR(100)     NOT NULL COMMENT 'code of the indicator in the item_1 planning process: indicates whether an item_1 has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig
            CBX:  CNT_CODELIST.CODE  (code list ''LIDL_ASSORTMENT'')',
   mdm_item_composition_txt            VARCHAR(100)     NOT NULL COMMENT 'text of the indicator in the item_1 planning process: indicates whether an item_1 has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig
            CBX:  CNT_CODELIST.NAME (code list ''LIDL_ASSORTMENT'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_ITEM_COMPOSITION PRIMARY KEY (mdm_item_composition_cd) NOT ENFORCED 
)  COMMENT = 'list of item_1 composition codes, indicates whether an item_1 has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort or assemble: (x)fach sortiert oder (x)teilig
             CBX: CNT_CODELIST_1 (code list "LIDL_ASSORTMENT")';

/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_composition
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:39:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_item_composition (
mdm_item_composition_cd STRING(100) NOT NULL
OPTIONS(description='''code of the indicator in the item planning process: indicates whether an item has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig
            CBX:  CNT_CODELIST.CODE  (code list \'LIDL_ASSORTMENT\')'''),
mdm_item_composition_txt STRING(100) NOT NULL
OPTIONS(description='''text of the indicator in the item planning process: indicates whether an item has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig
            CBX:  CNT_CODELIST.NAME (code list \'LIDL_ASSORTMENT\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_composition_cd) NOT ENFORCED
)
OPTIONS(description='''list of item composition codes, indicates whether an item has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort or assemble: (x)fach sortiert oder (x)teilig
             CBX: CNT_CODELIST (code list "LIDL_ASSORTMENT")''');
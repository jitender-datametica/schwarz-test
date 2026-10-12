/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_composition
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_item_composition (
nfpo_item_composition_cd STRING(100) NOT NULL
OPTIONS(description='''Code of the indicator in the item planning process: indicates whether an item has relevant variants or consists of certain sub parts. Interpretation depends on the overall composition of the item (assort or assemble: (x)fach sortiert oder (x)teilig).
            CBX: CNT_CODELIST.CODE (code list \'LIDL_ASSORTMENT\')
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_COMPOSITION.MDM_ITEM_COMPOSITION_CD'''),
nfpo_item_composition_txt STRING(1000) NOT NULL
OPTIONS(description='''Text of the indicator in the item planning process: indicates whether an item has relevant variants or consists of certain sub parts. Interpretation depends on the overall composition of the item (assort or assemble: (x)fach sortiert oder (x)teilig).
            CBX: CNT_CODELIST.NAME (code list \'LIDL_ASSORTMENT\')
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_COMPOSITION.MDM_ITEM_COMPOSITION_TXT'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_COMPOSITION.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_COMPOSITION.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_composition_cd) NOT ENFORCED
)
OPTIONS(description='List of item composition codes, indicates whether an item has relevant variants or consists of certain sub parts. Interpretation depends on the overall composition of the item. Assort or assemble: (x)fach sortiert oder (x)teilig.');
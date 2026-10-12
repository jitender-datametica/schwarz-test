/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_unit_unit_of_measurement
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_item_unit_unit_of_measurement (
nfpo_item_unit_uom_nr STRING(100) NOT NULL,
nfpo_item_unit_uom_cd STRING(100)
OPTIONS(description='Indicator in the item planning process: code of the item content unit of measurement. Interpretation depends on the overall composition of the item.            CBX: CNT_ITEM.LDL_CONTAINER_UNIT            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_UNIT_UOM_CD'),
nfpo_item_unit_uom_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_unit_uom_nr) NOT ENFORCED
) OPTIONS(description='Comment 2Do');
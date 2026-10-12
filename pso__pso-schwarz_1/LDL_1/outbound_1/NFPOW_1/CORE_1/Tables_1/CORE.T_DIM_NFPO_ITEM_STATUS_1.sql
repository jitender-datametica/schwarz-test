/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_status_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_item_status_1 (
nfpo_item_status_cd STRING(100) NOT NULL
OPTIONS(description='Technical status_1 of the NFPO item_1 in the source system (active, inactive, cancelled).            CBX: CNT_ITEM.DOC_STATUS            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_DOC_STATUS'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_status_cd) NOT ENFORCED
) OPTIONS(description='Comment 2Do');
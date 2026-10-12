/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_previous_item_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:09:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_previous_item_1 (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO ITEM_1 INSTANCE.            CBX: CNT_ITEM.REF_NO            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID'),
nfpo_prev_item_lvl_nr BIGNUMERIC(38,0) NOT NULL,
nfpo_prev_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO ITEM_1 INSTANCE.            CBX: CNT_ITEM.REF_NO            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_sid, nfpo_prev_item_lvl_nr) NOT ENFORCED
) OPTIONS(description='NFPO previous (predecessor) items, all levels available.');
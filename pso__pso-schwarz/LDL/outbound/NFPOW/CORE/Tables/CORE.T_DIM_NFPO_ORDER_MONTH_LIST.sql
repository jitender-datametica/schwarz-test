/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_order_month_list
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_order_month_list (
nfpo_order_month_list_txt STRING(1000) NOT NULL,
nfpo_order_month_name_list_txt STRING(1000),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_MARKET.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_MARKET.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_order_month_list_txt) NOT ENFORCED
) OPTIONS(description='Comment 2Do');
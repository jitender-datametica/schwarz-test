/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_order_sales_status_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:20:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_item_order_sales_status_1 (
nfpo_item_order_sales_status_id BIGNUMERIC(38,0) NOT NULL,
nfpo_item_order_sales_status_descr STRING(250),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_order_sales_status_id) NOT ENFORCED
)
OPTIONS(description='Comment 2Do             States:             1 - not ordered, not in sales_1             2 - ordered, not in sales_1             3 - ordered, in sales_1             4 - not ordered, in sales_1');
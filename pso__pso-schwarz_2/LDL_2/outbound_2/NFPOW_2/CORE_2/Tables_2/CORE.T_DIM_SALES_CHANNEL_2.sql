/* --------------------------------------------------------------------------------
   DDL for table: t_dim_sales_channel_2
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_sales_channel_2 (
sales_channel_cd STRING(100) NOT NULL OPTIONS(description='Code for the sales_2 channel.'),
sales_channel_name STRING(100) NOT NULL
OPTIONS(description='Name of the sales_2 channel, like retail store or online shop.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (sales_channel_cd) NOT ENFORCED
)
OPTIONS(description='This table contains the different sales_2 channels like retail and online shop.             NFPOW: CORE_REL.T_SALES_CHANNEL_2');
/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_DISTRIBUTION_CHANNEL_TYPE_1
   GENERATED FROM POWERDESIGNER ON Montag, 17. Juli 2023 08:56:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_distribution_channel_type_1 (
dist_channel_type_cd STRING(5) NOT NULL
OPTIONS(description='A  type of distribution channel ( Wshop for LD Webshop , IC for Intercompany)'),
dist_channel_type_descr STRING(250)
OPTIONS(description='A  description for the distribution channel  type ( Webshop , Intercompany)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (dist_channel_type_cd) NOT ENFORCED
)
OPTIONS(description='The dimension that describes distribution channels types  -  Wshop for LD Webshop , IC for Intercompany');
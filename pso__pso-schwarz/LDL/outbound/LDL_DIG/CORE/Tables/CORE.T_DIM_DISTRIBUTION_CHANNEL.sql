/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_DISTRIBUTION_CHANNEL
   GENERATED FROM POWERDESIGNER ON Dienstag, 25. Juli 2023 14:37:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_distribution_channel (
dist_channel_cd STRING(5) NOT NULL
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
dist_channel_type_cd STRING(5)
OPTIONS(description='A  type of distribution channel ( Webshop for LD Webshop , IC for Intercompany)'),
dist_country_cd STRING(5)
OPTIONS(description='The unique code for a country according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. Filed only for channels related to Lidl Webshops'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (dist_channel_cd) NOT ENFORCED
)
OPTIONS(description='The dimension that dedcribes distribution channels used for goods sales - through Lidl Digital Webshops , Kaufland intercompany sales , or through third pardy platforms ( to be added in the future ).             Source : manual input');
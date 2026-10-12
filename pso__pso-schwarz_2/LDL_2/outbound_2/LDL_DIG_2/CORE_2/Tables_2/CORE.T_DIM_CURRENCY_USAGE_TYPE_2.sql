/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CURRENCY_USAGE_TYPE_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 12. September 2023 09:42:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_currency_usage_type_2 (
curr_usage_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the currency usage ( Local Currency vs_2 Global Currency ).'),
curr_usage_type_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the currency usage.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (curr_usage_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension describing the way currency is used in reports. Global currency use case - all countries / web shops are reported on in the same ONE currency, which is the HQ-Currency. The global currency is EUR,.             Local is the individual currency of a web shop, but cannot be summed up with other currencies of course.');
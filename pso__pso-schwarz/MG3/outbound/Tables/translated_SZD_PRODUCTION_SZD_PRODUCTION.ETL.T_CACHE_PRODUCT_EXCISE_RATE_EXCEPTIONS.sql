CREATE OR REPLACE TABLE szd_production_etl.t_cache_product_excise_rate_exceptions (
country_of_origin STRING(50),
commodity_cd STRING(50),
additional_cd STRING(200),
product_nr STRING(50),
excise_rate NUMERIC(29,5),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source')
)
OPTIONS(description='Major Entity - The customs product is a special product definition used in the Foreign Trade solution to cover both GTS and WWT products. - Source - GS-Upload, GTS/WWT, Excel Report from CDS, Broker (per Mail)');
CREATE OR REPLACE TABLE szd_production_etl.t_cache_abv_2 (
article_number STRING(100),
alcohol_percentage STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
excise_code STRING(100),
artikelnummer STRING(100),
bottle_size STRING(50)
)
OPTIONS(description='Major Entity - The customs product is a special product definition used in the Foreign Trade solution to cover both GTS and WWT products. - Source - GS-Upload, GTS/WWT, Excel Report from CDS, Broker (per Mail)');
CREATE OR REPLACE TABLE szd_production_core_rel.t_consignor_stream (
consignor_stream_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the of the consignor stream.'),
consignor_stream_name STRING(100) NOT NULL OPTIONS(description='The name of the consignor stream.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (consignor_stream_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Defines the consignor streams like LExI, OWIM and Lidl Stiftung. Consignors a attached to a stream. - Source - Manual');
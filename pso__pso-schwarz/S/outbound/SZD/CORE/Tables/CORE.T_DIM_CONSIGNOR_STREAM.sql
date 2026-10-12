/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CONSIGNOR_STREAM
   generated from Powerdesigner on Freitag, 19. Mai 2023 09:20:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_consignor_stream (
consignor_stream_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the type of the consignor stream.'),
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
OPTIONS(description='Minor Dimension - Contains the consignor streams, f.e. OWIM, LEXI or Lidl Stiftung. - Source - Manual');
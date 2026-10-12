/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CONSIGNOR_1
   generated from Powerdesigner on Freitag, 19. Mai 2023 09:19:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_consignor_1 (
party_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the consignor.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
consignor_stream_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the type of the consignor stream.'),
consignor_stream_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name of the consignor stream'),
importer_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the importer.'),
importer_nr STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - The business identifier of the importer.'),
importer_name STRING(100) NOT NULL OPTIONS(description='Denormalized Attribute - The name of the importer.'),
consignor_name STRING(100) NOT NULL OPTIONS(description='Natural Key/Business Key - The name of the consignor.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - The consignor wants to import the goods and forwards the relevant data to the broker for the customs declaration or does the customs declaration itself. - Source Manual, Broker Report, CDS Item_1 Report');
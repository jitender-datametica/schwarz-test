/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_HAULER_1
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_hauler_1 (
party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hauler (carrier )'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
hauler_name STRING(100) NOT NULL OPTIONS(description='Natural Key/Business Key - name of the hauler (carrier )'),
source_hauler_name_address_city_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - the name of the hauler directly from source. Source: VMT'),
hauler_cd STRING(50) OPTIONS(description='Short code for a carrier name (Evergreen = EGLV for example)'),
status_cd STRING(50) NOT NULL OPTIONS(description='The status_1 code for the company'),
hauler_nr STRING(50) OPTIONS(description='Descriptive Attribute - Optional business identifier of the hauler.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - Hauler (carrier) - responsible and executing party to move containers overseas. - Source - VMT');
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_DECLARANT_1
   generated from Powerdesigner on Freitag, 19. Mai 2023 09:21:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_declarant_1 (
party_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the declarant.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
declarant_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the type of declarant.'),
declarant_type_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name of the type of the declarant.'),
declarant_nr STRING(250) NOT NULL
OPTIONS(description='Natural Key/Business Key - The business number identifying the declarant.'),
declarant_name STRING(100) NOT NULL OPTIONS(description='The name of the declarant.'),
declarant_auth_status_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the authorization status.'),
declarant_auth_status_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name of the authorization status.'),
declarant_authorized_fg BOOL NOT NULL
OPTIONS(description='Denormalized Attribute - A flag indicating whether this declarant is authorized to make declarations.'),
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
OPTIONS(description='Major Dimension - The declarant prepares the customs declaration based on the data he has received from the importer. The declarant will then forward the customs declaration to the appropriate customs authority. A declarant can currently be both a broker and the importer itself. - Source - Manual / Excel-Report from CDS, Broker (per Mail)');
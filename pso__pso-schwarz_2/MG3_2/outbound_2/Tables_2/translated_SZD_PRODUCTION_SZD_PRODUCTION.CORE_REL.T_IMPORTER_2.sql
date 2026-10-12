CREATE OR REPLACE TABLE szd_production_core_rel.t_importer_2 (
party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the importer.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
importer_number STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key - A unique alphanumeric number that identifies the importer.'),
importer_name STRING(100) NOT NULL OPTIONS(description='This is the importer\'s displayable name.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - The importer orders goods abroad and must declare them when importing them into his own country. The importer can also make the declarance on the customs authority, if he owns the proper license. - Source - Manual');
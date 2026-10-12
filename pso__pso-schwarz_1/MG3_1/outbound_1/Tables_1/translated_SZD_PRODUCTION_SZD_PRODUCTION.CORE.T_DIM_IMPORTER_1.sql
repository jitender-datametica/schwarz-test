CREATE OR REPLACE TABLE szd_production_core.t_dim_importer_1 (
party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the importer.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
importer_nr STRING(250) NOT NULL OPTIONS(description='Natural Key/Business Key - The business number of the importer.'),
importer_name STRING(100) NOT NULL OPTIONS(description='The name of the importert.'),
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
OPTIONS(description='Major Dimension - Contains the parties that can act as an importer. Importers initiates declarations by sending a list of goods to be imported to a broker or makes the declarations by themselfs. - Source - Manual');
CREATE OR REPLACE TABLE szd_production_core_rel.t_broker_2 (
party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the broker.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
broker_number STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key - A unique alphanumeric number that identifies the broker.'),
broker_name STRING(100) NOT NULL OPTIONS(description='This is the broker\'s displayable name.'),
broker_postcode STRING(50)
OPTIONS(description='The postcode of the broker as currently held in CHIEF/CDS Standing Data'),
broker_authorized_fg BOOL NOT NULL
OPTIONS(description='A flag indicating this broker is authorized to make declarations to the customs authority.'),
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
OPTIONS(description='Major Entity - The broker prepares the customs declaration on behalf of the importer and submits it to the respective customs authority. - Source - Manual / Excel-Report from CDS, Broker (per Mail)');
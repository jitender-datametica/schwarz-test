CREATE TABLE IF NOT EXISTS szd_core.t_dim_recipient_1 (
party_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the recipient.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
recipient_nr STRING(50) NOT NULL OPTIONS(description='Natural/Business Key - The business identifier of the recipient.'),
recipient_name STRING(100) NOT NULL OPTIONS(description='Descriptive Attribute - The name of the recipient.'),
country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_1 location_1 of the recipient.'),
country_iso_cd STRING(50) NOT NULL
OPTIONS(description='Descriptive Attribute - The ISO country_1 code of the country_1 of the recipient.'),
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
OPTIONS(description='Major Dimension - The receipient is the party that receives the ordered goods that was ordered by a client. - Source - LExIS');
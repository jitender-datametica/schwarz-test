/* --------------------------------------------------------------------------------
   DDL for table: T_PARTY_KEY_1
   generated from Powerdesigner on Donnerstag, 30. November 2023 09:39:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_meta.t_party_key_1 (
party_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the party.'),
party_key_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the party.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
party_nat_key_nr STRING(250) NOT NULL
OPTIONS(description='The natural key which identifies the party.In case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (party_key_type_cd, dwh_valid_from_tmsp, party_nat_key_nr) NOT ENFORCED
)
OPTIONS(description='Metadata - Keytable - Party - Contains the mapping between surrogate keys and natural keys for business objects from the subject area "Party".');
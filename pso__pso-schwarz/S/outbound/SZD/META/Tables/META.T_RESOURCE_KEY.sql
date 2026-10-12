/* --------------------------------------------------------------------------------
   DDL for table: T_RESOURCE_KEY
   generated from Powerdesigner on Montag, 06. Mai 2024 09:12:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_meta.t_resource_key (
resource_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the party.'),
resource_key_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the party.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
resource_nat_key_nr STRING(250) NOT NULL
OPTIONS(description='The natural key which identifies the party.In case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (resource_key_type_cd, dwh_valid_from_tmsp, resource_nat_key_nr) NOT ENFORCED
)
OPTIONS(description='Metadata - Keytable - Resource- Contains the mapping between surrogate keys and natural keys for business objects from the subject area "Resource".');
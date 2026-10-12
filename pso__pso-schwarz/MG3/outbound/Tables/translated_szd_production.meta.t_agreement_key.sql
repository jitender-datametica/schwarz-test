CREATE OR REPLACE TABLE szd_production_meta.t_agreement_key (
agreement_sid INTEGER NOT NULL OPTIONS(description='the unique identifier (surrogate key) for the agreement.'),
agreement_key_type_cd STRING(50) NOT NULL
OPTIONS(description='the code for the type of natural key which identifies the agreement.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
agreement_nat_key_nr STRING(250) NOT NULL
OPTIONS(description='the natural key which identifies the agreement.in case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was created or last updated.'),
PRIMARY KEY (agreement_key_type_cd, dwh_valid_from_tmsp, agreement_nat_key_nr) NOT ENFORCED
)
OPTIONS(description='metadata - keytable - agreement - contains the mapping between surrogate keys and natural keys for business objects from the subject area "agreement".');
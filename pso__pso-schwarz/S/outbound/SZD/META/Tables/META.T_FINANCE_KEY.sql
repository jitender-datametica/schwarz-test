/* --------------------------------------------------------------------------------
   DDL for table: T_FINANCE_KEY
   generated from Powerdesigner on Freitag, 9. Februar 2024 10:08:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_meta.t_finance_key (
finance_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the finance object.'),
finance_key_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the finance object.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
finance_nat_key_nr STRING(250) NOT NULL
OPTIONS(description='The natural key which identifies the finance object. In case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (finance_key_type_cd, dwh_valid_from_tmsp, finance_nat_key_nr) NOT ENFORCED
)
OPTIONS(description='Metadata - Keytable - Finance - Contains the mapping between surrogate keys and natural keys for business objects from the subject area "Finance".');
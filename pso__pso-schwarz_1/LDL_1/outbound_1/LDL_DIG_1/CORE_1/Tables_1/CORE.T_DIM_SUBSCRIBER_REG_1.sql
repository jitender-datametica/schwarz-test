CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_subscriber_reg_1 (
country_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for a country_1 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
subscr_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the customer'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
subscr_nr STRING(50) OPTIONS(description='A customer number from original system'),
phone_nr STRING(100) OPTIONS(description='The phone number of the customer'),
subscr_salutation STRING(100) OPTIONS(description='The salutation of the customer'),
subscr_first_name STRING(100) OPTIONS(description='The first name of the customer'),
subscr_last_name STRING(100) OPTIONS(description='The last name of the customer'),
subscr_birth_dt DATE OPTIONS(description='The birth date of the customer'),
subscr_permission_lvl BIGNUMERIC
OPTIONS(description='Permission Level - the version of terms and conditions signed by user'),
lan_cd STRING(5) OPTIONS(description='The code for the language'),
locale_name STRING(100) OPTIONS(description='The locale used by users (de_de, cz_z, de_en , etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (country_cd, subscr_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A person who is signed up for Lidl Newsletter ( does not include people who subscribed for individual products ). One person can subscribe to newsletter in multiple countries.');
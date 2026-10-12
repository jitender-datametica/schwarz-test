CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_gender (
gender_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the gender.'),
gender_name STRING(100) NOT NULL
OPTIONS(description='The name for the gender. (Name in group language, i.e. in German)'),
gender_name_de STRING(100) OPTIONS(description='The name for the gender. (Name in German)'),
gender_name_en STRING(100) OPTIONS(description='The name for the gender. (Name in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (gender_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the gender of a person. (i.e. male / female / ...)');
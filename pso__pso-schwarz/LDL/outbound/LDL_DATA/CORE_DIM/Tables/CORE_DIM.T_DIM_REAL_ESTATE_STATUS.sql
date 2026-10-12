CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_real_estate_status (
real_estate_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status for real estate objects. (This is the business lifecycle, so it might differ from the status code shown in the source system.)'),
real_estate_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status for real estate objects. (Description in group language, i.e. in German)'),
real_estate_status_descr_de STRING(250)
OPTIONS(description='A textual description for the lifecycle status for real estate objects. (Description in German)'),
real_estate_status_descr_en STRING(250)
OPTIONS(description='A textual description for the lifecycle status for real estate objects. (Description in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (real_estate_status_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the lifecycle status for real estate objects.. E.g. an object may be under contract, open, closed or terminated. (This is the business lifecycle, so it might differ from the status code shown in the source system.)');
CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_real_estate_status_1 (
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
real_estate_status_categ_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of status_1 lifecycle for real estate objects.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
real_estate_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status_1 for real estate objects. The status_1 code is related to a given status_1 category.'),
real_estate_status_reason_cd STRING(20)
OPTIONS(description='The code identifying the reason why the status_1 of a real estate object has changed.'),
comment_txt STRING(1000)
OPTIONS(description='A free text comment further detailing the status_1 and/or the reason for the status_1 change.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (real_estate_sid, real_estate_status_categ_cd, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='This entity tracks the lifecycle status_1 of a real estate object.');
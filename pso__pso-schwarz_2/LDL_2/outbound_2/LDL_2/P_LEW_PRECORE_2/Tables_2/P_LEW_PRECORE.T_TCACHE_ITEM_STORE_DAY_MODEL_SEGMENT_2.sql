CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_tcache_item_store_day_model_segment_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The ID of the client (Lidl-Country_2).'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the model (reference to t_ref_model_2).'),
model_run_dt DATE NOT NULL OPTIONS(description='The date of the model run.'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the item_2 (reference to t_item_2).'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the store (reference to t_location_2).'),
prediction_dt DATE NOT NULL
OPTIONS(description='The date of the prediction. This date may be in the future of the model run.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='Human readable code of the model area (e.g. CX, AP or LDL+)'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='Unique code of the model group starting with the parental model area code, e.g. AP_bakeoff or CX_store_rating.'),
item_velocity_class STRING(100) NOT NULL,
processing_remark_id STRING(100) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the insertion of this row.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of this row.'),
PRIMARY KEY (model_sid, model_run_dt, item_sid, loc_sid, prediction_dt) NOT ENFORCED
) CLUSTER BY client_id, model_group_cd;
CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_store_day_model_segment_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The ID of the client (Lidl-Country_1).'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the model (reference to t_ref_model_1).'),
model_run_dt DATE NOT NULL OPTIONS(description='The date of the model run.'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the item_1 (reference to t_item_1).'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the store (reference to t_location_1).'),
prediction_dt DATE NOT NULL
OPTIONS(description='The date of the prediction. This date may be in the future of the model run.'),
segmentation_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SEGMENTATION'),
segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SEGMENT'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='Human readable code of the model area (e.g. CX, AP or LDL+)'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='Unique code of the model group starting with the parental model area code, e.g. AP_bakeoff or CX_store_rating.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the insertion of this row.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of this row.'),
PRIMARY KEY (model_sid, model_run_dt, item_sid, loc_sid, prediction_dt, segmentation_sid) NOT ENFORCED
) CLUSTER BY client_id, model_group_cd
OPTIONS(description='This table contains segments regarding to a specific score_type as an output of an AI model.');
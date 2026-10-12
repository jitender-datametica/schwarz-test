CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_store_day_model_param_sod_inference_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The ID of the client (Lidl-Country_2).'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
model_run_dt DATE NOT NULL OPTIONS(description='The date of the model run.'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION_2 (eindeutig ueber alle Laender/Mandanten hinweg)'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg)'),
prediction_dt DATE NOT NULL OPTIONS(description='The date of the prediction itself.'),
release_version STRING(100) OPTIONS(description='The release version of the application.'),
anomaly_threshold_meas BIGNUMERIC(38,5)
OPTIONS(description='Threshold to determine the anomaly flag from the anomaly score.'),
anomaly_bl_threshold_meas BIGNUMERIC(38,5)
OPTIONS(description='Threshold to determine the anomaly flag from the anomaly baseline score.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='Human readable code of the model area (e.g. CX, AP or LDL+)'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='Unique code of the model group starting with the parental model area code, e.g. AP_bakeoff or CX_store_rating.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the insertion of this row.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of this row.'),
PRIMARY KEY (model_sid, model_run_dt, loc_sid, item_sid, prediction_dt) NOT ENFORCED
) CLUSTER BY client_id, model_group_cd
OPTIONS(description='This table contains the parameter for a run of the "SOD Inference" model on the granularity of a item_2, a store and a day.');
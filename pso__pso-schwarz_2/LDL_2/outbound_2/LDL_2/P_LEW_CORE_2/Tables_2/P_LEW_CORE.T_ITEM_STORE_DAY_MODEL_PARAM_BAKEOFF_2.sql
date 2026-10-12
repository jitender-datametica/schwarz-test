CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_store_day_model_param_bakeoff_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The ID of the client (Lidl-Country_2).'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
model_run_dt DATE NOT NULL OPTIONS(description='The date of the model run.'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION_2 (eindeutig ueber alle Laender/Mandanten hinweg)'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg)'),
prediction_dt DATE NOT NULL OPTIONS(description='The date of the prediction itself.'),
price_change_fg BIGNUMERIC(38,0) OPTIONS(description='The flag indicating a price change is applicable or not.'),
item_reference_sid BIGNUMERIC(38,0)
OPTIONS(description='Optional reference to another item_2 for items with not enough data coverage.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='Human readable code of the model area (e.g. CX, AP or LDL+)'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='Unique code of the model group starting with the parental model area code, e.g. AP_bakeoff or CX_store_rating.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the insertion of this row.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of this row.'),
PRIMARY KEY (model_sid, model_run_dt, loc_sid, item_sid, prediction_dt) NOT ENFORCED
) CLUSTER BY client_id, model_group_cd
OPTIONS(description='This table contains the parameter for a run of the "Bakeoff" model on the granularity of a item_2, a store and a day.');
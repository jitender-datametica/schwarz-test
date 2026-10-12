CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_store_model_param_bakeoff_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The ID of the client (Lidl-Country_1).'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
model_run_dt DATE NOT NULL OPTIONS(description='The date of the model run.'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION_1 (eindeutig ueber alle Laender/Mandanten hinweg)'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg)'),
opt_goal_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate key of the optimization goal.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='Human readable code of the model area (e.g. CX, AP or LDL+)'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='Unique code of the model group starting with the parental model area code, e.g. AP_bakeoff or CX_store_rating.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the insertion of this row.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of this row.'),
PRIMARY KEY (model_sid, model_run_dt, loc_sid, item_sid) NOT ENFORCED
) CLUSTER BY client_id, model_group_cd
OPTIONS(description='This table contains the parameter for a run of the "Bakeoff" model on the granularity of a item_1 and a.');
CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_store_model_score (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The ID of the client (Lidl-Country).'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the model (reference to t_ref_model).'),
model_run_dt DATE NOT NULL OPTIONS(description='The date of the model run.'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the store (reference to t_location).'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the item (reference to t_item).'),
score_type_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key of the score type (reference to t_ref_score_type).'),
score_meas BIGNUMERIC(38,6)
OPTIONS(description='The measure value for a specific score type as an output of the model run.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='Human readable code of the model area (e.g. CX, AP or LDL+)'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='Unique code of the model group starting with the parental model area code, e.g. AP_bakeoff or CX_store_rating.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the insertion of this row.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of this row.'),
PRIMARY KEY (model_sid, model_run_dt, item_sid, loc_sid, score_type_sid) NOT ENFORCED
) CLUSTER BY client_id, model_group_cd
OPTIONS(description='This table contains the results of a model run regarding to a specific item and a specific store.');
CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_segment_hist (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The ID of the client (Lidl-Country). This column is always set to the ID 7, because it\'s a technical column used by the core loader.'),
segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SEGMENT'),
lower_bound_meas BIGNUMERIC(38,5)
OPTIONS(description='THe value of the lower bound of this segment. The lower bound is optional and only applicable for segmentations that support lower and upper bounds for segmentation.'),
upper_bound_meas BIGNUMERIC(38,5)
OPTIONS(description='THe value of the upper bound of this segment. The lower bound is optional and only applicable for segmentations that support lower and upper bounds for segmentation.'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='sprechender Code, CX, LDL+,AP'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='A flag indicating that this row is deleted or marked as deleted in the source system.'),
dwh_valid_from DATE NOT NULL OPTIONS(description='The begin date of the period of validity of this row.'),
dwh_valid_to DATE NOT NULL OPTIONS(description='The end date of the period of validity of this row.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the insertion of this row.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of this row.'),
PRIMARY KEY (segment_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='This table contains historized information about segments.');
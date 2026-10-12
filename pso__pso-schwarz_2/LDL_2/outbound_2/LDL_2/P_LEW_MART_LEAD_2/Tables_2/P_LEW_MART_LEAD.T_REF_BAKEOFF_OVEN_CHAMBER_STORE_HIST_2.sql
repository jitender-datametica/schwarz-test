CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_ref_bakeoff_oven_chamber_store_hist_2 (
bakeoff_oven_chamber_sid BIGNUMERIC,
bakeoff_oven_chamber_name STRING(100),
bakeoff_oven_chamber_serial_nr STRING(100),
bakeoff_oven_chamber_model_name STRING(100),
bakeoff_oven_chamber_construction_year BIGNUMERIC,
bakeoff_oven_chamber_eow_dt DATE,
bakeoff_oven_pos_nr BIGNUMERIC,
bakeoff_oven_chamber_pos_cd STRING(100),
client_id BIGNUMERIC,
store_loc_sid BIGNUMERIC,
loc_sid_store_move_to BIGNUMERIC,
active_fg BIGNUMERIC,
valid_from DATE,
valid_to DATE,
created_tmsp DATETIME,
updated_tmsp DATETIME
);
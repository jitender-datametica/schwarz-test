CREATE TABLE P_LEW_MART_LEAD.T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_1	
(
bakeoff_oven_chamber_sid NUMBER,
bakeoff_oven_chamber_name VARCHAR(100),
bakeoff_oven_chamber_serial_nr VARCHAR(100),
bakeoff_oven_chamber_model_name VARCHAR(100),
bakeoff_oven_chamber_construction_year NUMBER,
bakeoff_oven_chamber_eow_dt DATE,
bakeoff_oven_pos_nr NUMBER,
bakeoff_oven_chamber_pos_cd VARCHAR(100),
client_id NUMBER,
store_loc_sid NUMBER,
loc_sid_store_move_to NUMBER,
active_fg NUMBER,
valid_from DATE,
valid_to DATE,
created_tmsp TIMESTAMP_NTZ(9),
updated_tmsp TIMESTAMP_NTZ(9)
);
CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_fedstate_us_2 (
client_id INTEGER NOT NULL,
region_sid INTEGER NOT NULL,
fedstate_cd STRING(160) NOT NULL,
valid_from DATE NOT NULL,
valid_to DATE NOT NULL,
active_fg INTEGER NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (region_sid, fedstate_cd, valid_from) NOT ENFORCED
);
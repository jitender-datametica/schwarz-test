CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wh_pch_switch_1 (
client_id INTEGER NOT NULL,
wh_id INTEGER NOT NULL,
loc_sid_wh INTEGER NOT NULL,
pch_bnl_switch_fg INTEGER,
switch_date DATE,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);
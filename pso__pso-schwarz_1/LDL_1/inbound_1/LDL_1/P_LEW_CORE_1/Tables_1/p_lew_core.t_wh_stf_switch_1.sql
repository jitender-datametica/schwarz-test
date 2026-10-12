CREATE TABLE p_lew_core.t_wh_stf_switch_1 (
client_id INTEGER NOT NULL,
wh_id INTEGER NOT NULL,
loc_sid_wh INTEGER NOT NULL,
stf_sfo_switch_fg BYTEINT,
switch_date DATE,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
DWH_UPDATED TIMESTAMP(6) NOT NULL,
UNIQUE ( client_id ,loc_sid_wh)
);
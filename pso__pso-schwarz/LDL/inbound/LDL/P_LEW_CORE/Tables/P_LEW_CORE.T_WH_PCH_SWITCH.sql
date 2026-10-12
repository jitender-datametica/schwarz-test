create table  P_LEW_CORE.T_WH_PCH_SWITCH (
client_id INTEGER NOT NULL,
wh_id INTEGER NOT NULL,
loc_sid_wh INTEGER NOT NULL,
pch_bnl_switch_fg BYTEINT,
switch_date DATE,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP_NTZ(6) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL,
UNIQUE ( client_id ,loc_sid_wh)
)
/**** WARNING: PERFORMANCE REVIEW - CLUSTER BY ****/
/*CLUSTER BY(RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 , NO RANGE))*/;
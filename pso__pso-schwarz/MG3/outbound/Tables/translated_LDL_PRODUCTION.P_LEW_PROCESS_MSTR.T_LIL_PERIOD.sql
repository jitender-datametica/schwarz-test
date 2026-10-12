CREATE OR REPLACE TABLE ldl_production_p_lew_process_mstr.t_lil_period (
client_id INTEGER NOT NULL,
period_sid INTEGER NOT NULL,
period_id INTEGER NOT NULL,
period_lvl INTEGER NOT NULL,
liam_avbl_fg INTEGER,
lift_avbl_fg INTEGER,
active_fg INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
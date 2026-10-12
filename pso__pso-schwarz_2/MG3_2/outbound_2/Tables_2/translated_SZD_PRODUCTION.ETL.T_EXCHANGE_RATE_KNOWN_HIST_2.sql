CREATE OR REPLACE TABLE szd_production_etl.t_exchange_rate_known_hist_2 (
client_id INTEGER NOT NULL,
curr_sid_from INTEGER NOT NULL,
curr_sid_to INTEGER NOT NULL,
x_rate_type_sid INTEGER NOT NULL,
active_from_dt DATE NOT NULL,
active_to_dt DATE NOT NULL,
curr_cd_from STRING(160),
curr_cd_to STRING(160),
exchange_rate NUMERIC(18,5),
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
CREATE OR REPLACE TABLE szd_production_etl.t_exchange_rate_type (
client_id INTEGER NOT NULL,
x_rate_type_sid INTEGER NOT NULL,
src_kurst STRING(160),
curr_sid INTEGER,
x_rate_type_name STRING(800),
curr_cd STRING(160),
fixed_rate_fg INTEGER,
special_rate_fg INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
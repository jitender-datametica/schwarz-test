DROP TABLE IF EXISTS ldl_production_p_lew_core.t_lil_period_2;
CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_lil_period_2 (
client_id INTEGER NOT NULL,
period_sid INTEGER NOT NULL,
src_period_cd STRING(160) NOT NULL,
period_name STRING(800) NOT NULL,
period_type_id INTEGER NOT NULL,
period_type_name STRING(800),
period_year INTEGER NOT NULL,
period_sid_py INTEGER,
period_sid_pq INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;
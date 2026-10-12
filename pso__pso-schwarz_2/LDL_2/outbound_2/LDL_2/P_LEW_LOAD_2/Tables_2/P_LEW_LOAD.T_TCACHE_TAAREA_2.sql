CREATE OR REPLACE TABLE ldl_p_lew_load.t_tcache_taarea_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
lgnum STRING(100),
aarea STRING(100),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);
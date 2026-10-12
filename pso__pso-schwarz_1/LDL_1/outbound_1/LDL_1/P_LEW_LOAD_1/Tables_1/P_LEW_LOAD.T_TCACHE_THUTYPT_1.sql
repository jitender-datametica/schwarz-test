CREATE OR REPLACE TABLE ldl_p_lew_load.t_tcache_thutypt_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
mandt STRING(100),
spras STRING(100),
hutyp STRING(100),
hutyptext STRING(250),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);
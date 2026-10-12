DROP TABLE IF EXISTS szd_production_etl.t_currency_descr_1;
CREATE OR REPLACE TABLE szd_production_etl.t_currency_descr_1 (
client_id INTEGER NOT NULL,
curr_sid INTEGER NOT NULL,
lang_sid INTEGER NOT NULL,
curr_cd STRING(20),
lang_cd STRING(20),
curr_descr_short STRING(100) COLLATE 'und:ci',
curr_descr_long STRING(300) COLLATE 'und:ci',
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (curr_sid, lang_sid) NOT ENFORCED
) CLUSTER BY client_id;
DROP TABLE IF EXISTS szd_production_etl.t_country_political;
CREATE OR REPLACE TABLE szd_production_etl.t_country_political (
client_id INTEGER NOT NULL,
country_pol_sid INTEGER NOT NULL,
src_land1 STRING(20),
country_pol_name STRING(100) COLLATE 'und:ci',
curr_sid INTEGER,
lang_sid INTEGER,
curr_cd STRING(20),
lang_cd STRING(20),
iso_code2 STRING(20),
iso_code3 STRING(20),
member_eu_fg INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (country_pol_sid) NOT ENFORCED
) CLUSTER BY client_id;
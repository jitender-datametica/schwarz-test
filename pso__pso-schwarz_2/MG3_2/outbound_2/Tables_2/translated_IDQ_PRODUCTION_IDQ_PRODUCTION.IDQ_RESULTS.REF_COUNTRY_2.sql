CREATE OR REPLACE TABLE idq_production_idq_results.ref_country_2 (
id INTEGER NOT NULL,
country_2 STRING(200),
name_de STRING(1000),
name_en STRING(1000),
change_by STRING(1000),
last_change DATETIME,
from_date DATETIME,
to_date DATETIME,
capital_de STRING(1000),
capital_en STRING(1000),
hq_city_de STRING(1000),
hq_city_en STRING(1000),
country_middle_longitude STRING(1000),
country_middle_latitude STRING(1000),
hq_city_longitude STRING(1000),
hq_city_latitude STRING(1000),
PRIMARY KEY (id) NOT ENFORCED
);
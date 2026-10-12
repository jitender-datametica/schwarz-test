CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_month_of_year (
month_of_year INTEGER NOT NULL
OPTIONS(description='The month of the calendar year as a number using the convention January = 1 ... December = 12.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
month_of_bus_year INTEGER NOT NULL
OPTIONS(description='The month of the business year (starting in March for Lidl) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
month_of_year_name STRING(100) NOT NULL
OPTIONS(description='The full name for the month of the year. E.g.\""January\""'),
month_of_short_name STRING(100) NOT NULL
OPTIONS(description='The short name / abbreviation for month of the year. E.g.\""Jan\""'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (month_of_year, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity contains the names of the twelve months of the year. (January, February, ..., December)');
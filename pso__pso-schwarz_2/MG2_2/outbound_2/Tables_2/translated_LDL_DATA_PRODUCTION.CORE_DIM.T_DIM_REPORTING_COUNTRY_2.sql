CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_reporting_country_2 (
reporting_country_cd STRING(20) NOT NULL OPTIONS(description='The code which identifies the reporting country.'),
reporting_country_name STRING(100) NOT NULL
OPTIONS(description='The name the reporting country. (i.e. a country_2 definition which is different from a geographical country_2) The name in in group lanuage, i.e. in German. (Name in group language, i.e. in German)'),
reporting_country_name_de STRING(100)
OPTIONS(description='The name the reporting country. (i.e. a country_2 definition which is different from a geographical country_2) The name in in group lanuage, i.e. in German. (Name in German)'),
reporting_country_name_en STRING(100)
OPTIONS(description='The name the reporting country. (i.e. a country_2 definition which is different from a geographical country_2) The name in in group lanuage, i.e. in German. (Name in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (reporting_country_cd) NOT ENFORCED
) OPTIONS(description='A country_2, as required for reporting, i.e. not identical to a geographical country.');
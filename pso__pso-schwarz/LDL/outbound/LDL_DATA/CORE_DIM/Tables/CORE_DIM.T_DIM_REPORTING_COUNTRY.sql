/* --------------------------------------------------------------------------------
   DDL for table: t_dim_reporting_country
   generated from Powerdesigner on Mittwoch, 22. März 2023 07:22:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_reporting_country (
reporting_country_cd STRING(20) NOT NULL OPTIONS(description='The code which identifies the reporting country.'),
reporting_country_name STRING(100) NOT NULL
OPTIONS(description='The name the reporting country. (i.e. a country definition which is different from a geographical country) The name in in group lanuage, i.e. in German. (Name in group language, i.e. in German)'),
reporting_country_name_de STRING(100)
OPTIONS(description='The name the reporting country. (i.e. a country definition which is different from a geographical country) The name in in group lanuage, i.e. in German. (Name in German)'),
reporting_country_name_en STRING(100)
OPTIONS(description='The name the reporting country. (i.e. a country definition which is different from a geographical country) The name in in group lanuage, i.e. in German. (Name in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (reporting_country_cd) NOT ENFORCED
) OPTIONS(description='A country, as required for reporting, i.e. not identical to a geographical country.');
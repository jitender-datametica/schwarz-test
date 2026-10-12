CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_dim_reporting_country_1 (reporting_country_cd
OPTIONS(description='The code which identifies the reporting country.'), reporting_country_name
OPTIONS(description='The name the reporting country. (i.e. a country_1 definition which is different from a geographical country_1) The name in in group lanuage, i.e. in German. (Name in group language, i.e. in German)'),
reporting_country_name_de
OPTIONS(description='The name the reporting country. (i.e. a country_1 definition which is different from a geographical country_1) The name in in group lanuage, i.e. in German. (Name in German)'),
reporting_country_name_en
OPTIONS(description='The name the reporting country. (i.e. a country_1 definition which is different from a geographical country_1) The name in in group lanuage, i.e. in German. (Name in English)'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `A COUNTRY_1, AS REQUIRED FOR REPORTING, I.E. NOT IDENTICAL TO A GEOGRAPHICAL COUNTRY.`) AS SELECT
 reporting_country_cd,
 reporting_country_name,
 reporting_country_name_de,
 reporting_country_name_en,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_reporting_country_1 AS main;
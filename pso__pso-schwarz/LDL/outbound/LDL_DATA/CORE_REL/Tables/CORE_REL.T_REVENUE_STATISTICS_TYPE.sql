/* --------------------------------------------------------------------------------
   DDL for table: t_revenue_statistics_type
   generated from Powerdesigner on Mittwoch, 22. Februar 2023 17:15:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_revenue_statistics_type (
revenue_stat_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier for the subtype discriminator for revenue statisticss.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
revenue_stat_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the subtype discriminator for revenue statisticss.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (revenue_stat_type_id, lang_cd) NOT ENFORCED
) OPTIONS(description='This minor entity defines the subtye discriminators for revenue statisticss.');
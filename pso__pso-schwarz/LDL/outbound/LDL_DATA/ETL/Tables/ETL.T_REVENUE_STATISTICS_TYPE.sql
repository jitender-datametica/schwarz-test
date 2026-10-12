CREATE TABLE IF NOT EXISTS ldl_data_etl.t_revenue_statistics_type (
revenue_stat_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier for the subtype discriminator for revenue statisticss.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
revenue_stat_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the subtype discriminator for revenue statisticss.'),
PRIMARY KEY (revenue_stat_type_id, lang_cd) NOT ENFORCED
);
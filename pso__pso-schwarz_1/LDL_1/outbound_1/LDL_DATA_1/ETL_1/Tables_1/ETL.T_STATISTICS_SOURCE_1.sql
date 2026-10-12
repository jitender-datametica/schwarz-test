CREATE TABLE IF NOT EXISTS ldl_data_etl.t_statistics_source_1 (
stat_src_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the source or system which provided the statistics.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
stat_src_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the source or system which provided the statistics.'),
PRIMARY KEY (stat_src_cd, lang_cd) NOT ENFORCED
);
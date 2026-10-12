CREATE OR REPLACE TABLE szd_production_core_rel.t_language_2 (
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
lang_name STRING(100) NOT NULL OPTIONS(description='The name of the language in group language, i.e. in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (lang_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - This minor entity defines the language, e.g. German, English, French ... - Source - Manual');
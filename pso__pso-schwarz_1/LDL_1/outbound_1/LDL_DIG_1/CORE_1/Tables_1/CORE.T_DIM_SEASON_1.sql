CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_season_1 (
season_nr STRING(20) NOT NULL OPTIONS(description='Unique season ID (Primary Key) in the source system'),
season_start_mon_dt_nr BIGNUMERIC
OPTIONS(description='Date when season starts in format of month concatenated with date'),
season_end_mon_dt_nr BIGNUMERIC OPTIONS(description='Date when season ends in format of month concatenated with date'),
season_name STRING(100) OPTIONS(description='Name of the seasons in group language ( German )'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (season_nr) NOT ENFORCED
)
OPTIONS(description='A dimension that defines season relevant for LD selling goods ( f.e. winter, Halloween , New Year , etc), country_1 independent');
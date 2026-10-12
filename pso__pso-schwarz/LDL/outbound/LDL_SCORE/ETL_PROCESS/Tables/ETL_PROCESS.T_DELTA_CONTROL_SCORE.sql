CREATE TABLE IF NOT EXISTS ldl_score_etl_process.t_delta_control_score (
src_table STRING(100) NOT NULL OPTIONS(description='Source table'),
src_system STRING(30) NOT NULL OPTIONS(description='Source system'),
max_extraction_tmsp DATETIME NOT NULL OPTIONS(description='The maximum extraction timestamp of previous load'),
PRIMARY KEY (src_table, src_system) NOT ENFORCED
) OPTIONS(description='ETL table to keep the maximum timestamp of extraction and load.');
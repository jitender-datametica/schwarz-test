--==============================================================
-- Table: t_dim_flag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_flag
   generated from Powerdesigner on Dienstag, 2. April 2024 06:38:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_flag (
fg BOOL NOT NULL OPTIONS(description='The flag (true or false)'),
fg_name STRING(100) NOT NULL OPTIONS(description='The name for the flag (yes / no) in group language, i.e. German.'),
fg_name_de STRING(100) OPTIONS(description='The name for the flag (yes / no) in.German.'),
fg_name_en STRING(100) OPTIONS(description='The name for the flag (yes / no) in English.'),
fg_short_name STRING(100) NOT NULL
OPTIONS(description='The abbreviation for the flag (Y/N) in group language, i.e. German.'),
fg_short_name_de STRING(100) OPTIONS(description='The abbreviation for the flag (Y/N) in.German.'),
fg_short_name_en STRING(100) OPTIONS(description='The abbreviation for the flag (Y/N) in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (fg) NOT ENFORCED
)
OPTIONS(description='If the frontend requires a list of values for flags (i.e. true and false), this minor dimension can be used as a lookup.');
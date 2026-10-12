CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_web_app_1 (
web_app_type_name STRING(100) NOT NULL
OPTIONS(description='Name of the web app/client type (iOS App / Android App / Mobile Web / Desktop Web ...) '),
ga_src_name STRING(100) NOT NULL OPTIONS(description='The code for the the source of google analytics (WEB or APP)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (web_app_type_name, ga_src_name) NOT ENFORCED
)
OPTIONS(description='A dimensions that contains possible web applications / client types. (iOS App / Android App / Mobile Web / Desktop Web ...)');
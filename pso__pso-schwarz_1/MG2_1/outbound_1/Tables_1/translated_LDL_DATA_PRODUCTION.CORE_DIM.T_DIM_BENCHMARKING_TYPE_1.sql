CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_benchmarking_type_1 (
benchmarking_type_id INTEGER NOT NULL
OPTIONS(description='The benchmarking type identifies the type of benchmark defined by business departments to view dedicated metrics. It corresponds in general to the hierarchy_1 levels of e.g. the organizational unit_1 hierarchy_1, like - all countries for viewing all records (international view), by country_1, by company (VGES/BGES), by sales_1 manager, etc.'),
benchmarking_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of benchmark defined by business departments to view dedicated metrics. It corresponds in general to the hierarchy_1 levels of e.g. the organizational unit_1 hierarchy_1, like - all countries for viewing all records (international view), by country_1, by company (VGES/BGES), by sales_1 manager, etc. (Description in group language, i.e. in German)'),
benchmarking_type_descr_de STRING(250)
OPTIONS(description='A textual description for the type of benchmark defined by business departments to view dedicated metrics. It corresponds in general to the hierarchy_1 levels of e.g. the organizational unit_1 hierarchy_1, like - all countries for viewing all records (international view), by country_1, by company (VGES/BGES), by sales_1 manager, etc. (Description in German)'),
benchmarking_type_descr_en STRING(250)
OPTIONS(description='A textual description for the type of benchmark defined by business departments to view dedicated metrics. It corresponds in general to the hierarchy_1 levels of e.g. the organizational unit_1 hierarchy_1, like - all countries for viewing all records (international view), by country_1, by company (VGES/BGES), by sales_1 manager, etc. (Description in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (benchmarking_type_id) NOT ENFORCED
)
OPTIONS(description='The benchmarking type identifies the type of benchmark defined by business departments to view dedicated metrics. It corresponds in general to the hierarchy_1 levels of e.g. the organizational unit_1 hierarchy_1, like - all countries for viewing all records (international view), by country_1, by company (VGES/BGES), by sales_1 manager, etc.');
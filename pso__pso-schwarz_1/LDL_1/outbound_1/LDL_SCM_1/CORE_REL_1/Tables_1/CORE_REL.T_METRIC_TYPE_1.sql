CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_metric_type_1 (
metric_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the type of metric which is collected for internal companies.'),
metric_type_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the type of metric.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (metric_type_cd) NOT ENFORCED
) OPTIONS(description='This minor entity defines the kind of measure which is collected for internal companies.');
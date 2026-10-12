CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_weight_classification_1 (
weight_class_cd STRING(50) NOT NULL OPTIONS(description='A code for weight classification'),
weight_class_descr STRING(250) OPTIONS(description='A description for weightclassification'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (weight_class_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines  the cluster by which the product weight is classified .Groups the shipments by weight in 1 kilogram steps. The cluster starts with 0-1. And "above 50" is the max cluster.Unit_1: kilogram');
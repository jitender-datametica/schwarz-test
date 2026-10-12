CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_individual_logistics_agreement_type (
individual_logistics_agmt_type_cd STRING(20) NOT NULL
OPTIONS(description='The type of an individual logistic agreement'),
individual_logistics_agmt_type_descr STRING(100)
OPTIONS(description='The description of an individual logistic type code: can be land freight or sea freight'),
individual_logistics_agmt_type_descr_de STRING(100)
OPTIONS(description='German description of an individual logistic type code: can be land freight or sea freight'),
individual_logistics_agmt_type_descr_en STRING(100)
OPTIONS(description='English description of an individual logistic type code: can be land freight or sea freight'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (individual_logistics_agmt_type_cd) NOT ENFORCED
) OPTIONS(description='The type of an individual logistic agreement (land and sea freight types)');
--==============================================================
-- Table: t_dim_individual_logistics_agreement_type_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_individual_logistics_agreement_type_2
   generated from Powerdesigner on Dienstag, 2. April 2024 06:38:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_individual_logistics_agreement_type_2 (
individual_logistics_agmt_type_cd STRING(20) NOT NULL
OPTIONS(description='The type of an individual logistic agreement'),
individual_logistics_agmt_type_descr STRING(100)
OPTIONS(description='The description of an individual logistic type code: can be land_2 freight or sea freight'),
individual_logistics_agmt_type_descr_de STRING(100)
OPTIONS(description='German description of an individual logistic type code: can be land_2 freight or sea freight'),
individual_logistics_agmt_type_descr_en STRING(100)
OPTIONS(description='English description of an individual logistic type code: can be land_2 freight or sea freight'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (individual_logistics_agmt_type_cd) NOT ENFORCED
) OPTIONS(description='The type of an individual logistic agreement (land_2 and sea freight types)');
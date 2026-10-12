--==============================================================
-- Table: t_dim_individual_logistics_agreement_type_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_individual_logistics_agreement_type_2
   generated from Powerdesigner on Dienstag, 2. April 2024 06:38:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT_TYPE_2 (
   individual_logistics_agmt_type_cd       VARCHAR(20)     NOT NULL COMMENT 'The type of an individual logistic agreement',
   individual_logistics_agmt_type_descr    VARCHAR(100)    COMMENT 'The description of an individual logistic type code: can be land_2 freight or sea freight',
   individual_logistics_agmt_type_descr_de VARCHAR(100)    COMMENT 'German description of an individual logistic type code: can be land_2 freight or sea freight',
   individual_logistics_agmt_type_descr_en VARCHAR(100)    COMMENT 'English description of an individual logistic type code: can be land_2 freight or sea freight',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9)    NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9)    NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT_TYPE PRIMARY KEY (individual_logistics_agmt_type_cd) NOT ENFORCED 
)  COMMENT = 'The type of an individual logistic agreement (land_2 and sea freight types)';


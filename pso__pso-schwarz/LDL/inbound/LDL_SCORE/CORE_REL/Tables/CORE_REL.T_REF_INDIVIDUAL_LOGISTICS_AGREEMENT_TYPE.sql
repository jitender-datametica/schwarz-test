--==============================================================
-- Table: t_ref_individual_logistics_agreement_type
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_individual_logistics_agreement_type
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_INDIVIDUAL_LOGISTICS_AGREEMENT_TYPE (
   individual_logistics_agmt_type_cd        VARCHAR(20)    NOT NULL COMMENT 'The type of an individual logistic agreement',
   individual_logistics_agmt_type_descr     VARCHAR(100)   COMMENT 'The description of an individual logistic type code: can be land freight or sea freight',
   individual_logistics_agmt_type_descr_de  VARCHAR(100)   COMMENT 'German description of an individual logistic type code: can be land freight or sea freight',
   individual_logistics_agmt_type_descr_en  VARCHAR(100)   COMMENT 'English description of an individual logistic type code: can be land freight or sea freight',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9)    NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9)    NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_INDIVIDUAL_LOGISTICS_AGREEMENT_TYPE PRIMARY KEY (individual_logistics_agmt_type_cd) NOT ENFORCED 
)  COMMENT = 'The type of an individual logistic agreement (land and sea freight types)';


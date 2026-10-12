--==============================================================
-- Table: t_dim_individual_logistics_agreement_term_type
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_individual_logistics_agreement_term_type
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:20:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT_TERM_TYPE (
   individual_logistics_agmt_term_type_cd VARCHAR(20)     NOT NULL COMMENT 'The term type of an individual logistic agreement ',
   individual_logistics_agmt_term_type_descr VARCHAR(100)    COMMENT 'The description of an individual logistic term type code: can be Individual Logistics Project or Individual Logistics Contract.',
   individual_logistics_agmt_term_type_descr_de VARCHAR(100)    COMMENT 'German description of an individual logistic term type code: can be Individual Logistics Project or Individual Logistics Contract.',
   individual_logistics_agmt_term_type_descr_en VARCHAR(100)    COMMENT 'English description of an individual logistic term type code: can be Individual Logistics Project or Individual Logistics Contract.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT_TERM_TYPE PRIMARY KEY (individual_logistics_agmt_term_type_cd) NOT ENFORCED 
)  COMMENT = 'The term type of an individual logistic agreement (Individual Logistics Project or Individual Logistics Contract) distinguishes Agreement based on their duration. it distinguishes long term contract from short term projects.';

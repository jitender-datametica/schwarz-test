CREATE TABLE CORE_OCTOPUS.T_DIM_SURCHARGE_TYPE (
   surcharge_type_cd                   VARCHAR(20)     NOT NULL COMMENT 'This is a code, which defines the services for which, a fee is charged.',
   surcharge_categ_cd                  VARCHAR(20)     COMMENT 'This is a code, which defines the charge categories. Charge Category group a charge type.',
   surcharge_type_name                 VARCHAR(100)    NOT NULL COMMENT 'This is a name, for the services for which, a fee is charged.',
   surcharge_type_name_de              VARCHAR(100)    COMMENT 'This is a name, for the services for which, a fee is charged (in German).',
   surcharge_type_name_en              VARCHAR(100)    COMMENT 'This is a name, for the services for which, a fee is charged (in English)',
   surcharge_type_descr                VARCHAR(100)    COMMENT 'This is a description, for the services for which, a fee is charged. Can be empty.',
   surcharge_type_descr_de             VARCHAR(100)    COMMENT 'This is a description, for the services for which, a fee is charged. Can be empty (in German).',
   surcharge_type_descr_en             VARCHAR(100)    COMMENT 'This is a description, for the services for which, a fee is charged. Can be empty (in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_SURCHARGE_TYPE PRIMARY KEY (surcharge_type_cd) NOT ENFORCED 
)  COMMENT = 'This dimension defines the services for which, a surcharge fee is charged.';

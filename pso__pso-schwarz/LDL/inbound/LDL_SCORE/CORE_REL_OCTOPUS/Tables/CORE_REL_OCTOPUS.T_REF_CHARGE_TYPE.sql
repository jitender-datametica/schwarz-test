CREATE TABLE CORE_REL_OCTOPUS.T_REF_CHARGE_TYPE (
   charge_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'This is a code, which defines the services for which, a fee is charged.',
   charge_categ_cd                     VARCHAR(20)     COMMENT 'This is a code, which defines the charge categories. Charge Category group a charge type.',
   charge_type_name                    VARCHAR(100)    NOT NULL COMMENT 'This is a name, for the services for which, a fee is charged.',
   charge_type_name_de                 VARCHAR(100)    COMMENT 'This is a name, for the services for which, a fee is charged (in German).',
   charge_type_name_en                 VARCHAR(100)    COMMENT 'This is a name, for the services for which, a fee is charged (in English)',
   charge_type_descr                   VARCHAR(100)    COMMENT 'This is a description, for the services for which, a fee is charged. Can be empty.',
   charge_type_descr_de                VARCHAR(100)    COMMENT 'This is a description, for the services for which, a fee is charged. Can be empty (in German).',
   charge_type_descr_en                VARCHAR(100)    COMMENT 'This is a description, for the services for which, a fee is charged. Can be empty (in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_CHARGE_TYPE PRIMARY KEY (charge_type_cd) NOT ENFORCED 
)  COMMENT = 'This table defines the services for which, a fee is charged';
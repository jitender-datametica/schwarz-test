--==============================================================
-- Table: t_dim_transport_charge_type
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_transport_charge_type
   generated from Powerdesigner on Dienstag, 16. Juli 2024 14:01:16
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_TRANSPORT_CHARGE_TYPE (
   transport_charge_type_cd            VARCHAR(20)     NOT NULL COMMENT 'This is a code, which defines the services for which, a fee is charged.',
   transport_charge_type_name          VARCHAR(100)    NOT NULL COMMENT 'This is a name, for the services for which, a fee is charged.',
   transport_charge_type_name_de       VARCHAR(100)    COMMENT 'This is a name, for the services for which, a fee is charged (in German).',
   transport_charge_type_name_en       VARCHAR(100)    COMMENT 'This is a name, for the services for which, a fee is charged (in English)',
   transport_charge_type_descr         VARCHAR(100)    COMMENT 'This is a description, for the services for which, a fee is charged. Can be empty.',
   transport_charge_type_descr_de      VARCHAR(100)    COMMENT 'This is a description, for the services for which, a fee is charged. Can be empty (in German).',
   transport_charge_type_descr_en      VARCHAR(100)    COMMENT 'This is a description, for the services for which, a fee is charged. Can be empty (in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_TRANSPORT_CHARGE_TYPE PRIMARY KEY (transport_charge_type_cd) NOT ENFORCED 
)  COMMENT = 'This dimension defines the services for which, a Transport fee is charged';

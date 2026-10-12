/* --------------------------------------------------------------------------------
   DDL for table: t_planned_value_role_1
   generated from Powerdesigner on Mittwoch, 22. Februar 2023 16:20:36
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_PLANNED_VALUE_ROLE_1 (
   planned_val_role_cd                 VARCHAR(20)     NOT NULL COMMENT 'The code which identifies the role or context for which the value is planned.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   planned_val_role_descr              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the role or context for which the value is planned.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PLANNED_VALUE_ROLE PRIMARY KEY (planned_val_role_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'The planned value may play a certain role or be put into a certain context. E.g. revenue for an internal company may be planned both for its role as a sales_1 company and for its role as a delivery company. Different values may be planned for each role.';
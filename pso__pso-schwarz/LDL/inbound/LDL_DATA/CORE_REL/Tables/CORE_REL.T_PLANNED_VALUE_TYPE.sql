/* --------------------------------------------------------------------------------
   DDL for table: t_planned_value_type
   generated from Powerdesigner on Mittwoch, 22. Februar 2023 16:19:17
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_PLANNED_VALUE_TYPE (
   planned_val_type_sid                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the kind of value for which a plan is made. E.g. a forecast for revenue or customer count.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   planned_val_type_descr              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the kind of value for which a plan is made.',
   planned_val_type_id                 NUMBER(38, 0)   NOT NULL COMMENT 'The number which identifies the kind of value for which a plan is made in the planning tool. E.g. 157 for net revenue.',
   planning_process_cd 				   VARCHAR(20) 	   NOT NULL COMMENT 'The code identifying the planning process which defines this planned value type.',
   planned_val_role_cd                 VARCHAR(20)     COMMENT 'The code which identifies the role or context for which the value is planned.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PLANNED_VALUE_TYPE PRIMARY KEY (planned_val_type_sid, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the kind of value for which a plan is made. E.g. a forecast for revenue or customer count.';
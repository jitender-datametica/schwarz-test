/* --------------------------------------------------------------------------------
   DDL for table: t_user
   generated from Powerdesigner on Montag, 18. November 2024 09:22:28
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_USER (
   sys_name                            VARCHAR(100)    NOT NULL COMMENT 'The name of the IT system.',
   user_name                           VARCHAR(100)    NOT NULL COMMENT 'The name by which the user is identified on the system.',
   emp_sid                             NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the employee who owns this user.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_USER PRIMARY KEY (sys_name, user_name) NOT ENFORCED
 )  COMMENT= 'A user is an account on the data warehouse that allows to use the system. (Not every user is assigned to a single physical person.)';

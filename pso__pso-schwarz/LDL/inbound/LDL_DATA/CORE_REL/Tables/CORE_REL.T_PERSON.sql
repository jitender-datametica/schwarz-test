/* --------------------------------------------------------------------------------
   DDL for table: t_person
   generated from Powerdesigner on Dienstag, 17. Januar 2023 11:04:05
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_PERSON (
   person_sid                          NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the person.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   gender_cd                           VARCHAR(20)     NOT NULL COMMENT 'The code identifying the gender.',
   first_name                          VARCHAR(100)    COMMENT 'The first name (given name) of the person.',
   family_name                         VARCHAR(100)    COMMENT 'The family name / surname of the person.',
   birth_dt                            DATE            COMMENT 'The date when the person was born.',
   is_cust_fg                          BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the person is a customer.',
   is_emp_fg                           BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the person is a employee.',
   is_buyer_fg                         BOOLEAN         COMMENT 'An indicator showing, if the employee as the role of a buyer.',
   is_data_steward_fg                  BOOLEAN         COMMENT 'An indicator showing, if the employee is a data steward.',
   is_cashier_fg                       BOOLEAN         COMMENT 'An indicator showing, if the employee is a cashier.',
   emp_nr                              VARCHAR(20)     COMMENT 'The number which identifies the employee. In case the employee leaves and gets re-hired later on, he might get a different employee number.',
   buyer_nr                            VARCHAR(20)     COMMENT 'The number which identifies the buyer within the organization.',
   hire_dt                             DATE            COMMENT 'The date when the employee was hired. In case the employee leaves the organization and gets re-hired later on, this is the latest hire date.',
   term_dt                             DATE            COMMENT 'The date, when the employee left the organization. For active employees this date is empty.',
   mgr_emp_sid                         NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the manager of the employee.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PERSON PRIMARY KEY (person_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'People who are of interest to the Schwarz Group.';

/* --------------------------------------------------------------------------------
   DDL for table: t_planning_process_2
   generated from Powerdesigner on Mittwoch, 11. September 2024 11:03:41
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PLANNING_PROCESS_2 (
   planning_process_cd                 VARCHAR(20)     NOT NULL COMMENT 'The code identifying the planning process.',
   planning_process_descr              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the planning process.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PLANNING_PROCESS PRIMARY KEY (planning_process_cd) NOT ENFORCED
 )  COMMENT= 'A planning process is an administrative activity which defines a set of planned values. E.g. the short-term staff planning in stores or the annual planning for the next business year. The same type of value (e.g. net revenue) can be planned by several planning processes, however for the model these are different planned value types. I.e. each value is planned by exactly one planning process.';

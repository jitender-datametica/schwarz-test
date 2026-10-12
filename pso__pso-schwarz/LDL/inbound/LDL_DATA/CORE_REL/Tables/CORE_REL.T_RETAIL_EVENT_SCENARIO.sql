/* --------------------------------------------------------------------------------
   DDL for table: t_retail_event_scenario
   generated from Powerdesigner on Mittwoch, 22. Februar 2023 17:30:25
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_RETAIL_EVENT_SCENARIO (
   retail_event_scenario_id            NUMBER(38, 0)   NOT NULL COMMENT 'The numeric identifier for the scenario which is represented by the retail event.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   retail_event_scenario_name          VARCHAR(100)    NOT NULL COMMENT 'The name of the business scenario which is represented by the retail event.',
   retail_event_scenario_descr         VARCHAR(250)    NOT NULL COMMENT 'A textual description of the conditions which determine the business scenario.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_RETAIL_EVENT_SCENARIO PRIMARY KEY (retail_event_scenario_id, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the business scenario which the retail event represents, e.g. regular sales, cancelled sales, deposit return, etc. The scenario is calculated from a number of other attributes, so it is derived information.';
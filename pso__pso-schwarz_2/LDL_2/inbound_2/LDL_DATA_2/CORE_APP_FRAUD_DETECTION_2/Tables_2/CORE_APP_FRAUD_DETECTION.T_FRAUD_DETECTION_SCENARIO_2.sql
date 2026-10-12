/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_scenario_2
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:13:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO_2 (
   scenario_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of fraud detection scenario',
   scenario_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'Type of scenario, code which defines automatic and manuall type of scenario',
   scenario_name                       VARCHAR(100)    NOT NULL COMMENT 'The name of the identified scenario use case.',
   scenario_descr                      VARCHAR(250)    NOT NULL COMMENT 'Describes the scenario.',
   scenario_grp_id                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of fraud detection scenario group.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_SCENARIO PRIMARY KEY (scenario_id) NOT ENFORCED
 )  COMMENT= 'Keeps the fraud detection scenario and their relationship to groups.';

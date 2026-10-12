/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_suspicious_cash_register_event
   generated from Powerdesigner on Montag, 14. Oktober 2024 13:00:17
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SUSPICIOUS_CASH_REGISTER_EVENT (
   cash_register_event_sid             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.',
   scenario_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of fraud detection scenario',
   fraud_analysis_status_cd            VARCHAR(20)     NOT NULL COMMENT 'The are different status codes.First status code comes: SP-suspicious and then maybe later on NSP- not suspicious',
   comment_tnx                         VARCHAR(1000)   COMMENT 'Describes why the user was clasified the record ( true or  false)',
   bus_dt                              DATE            NOT NULL COMMENT 'The business date on which the retail event is counted.',
   store_sid                           NUMERIC(38,0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the related retail event happend.',
   cashier_nr                          VARCHAR(20)     NOT NULL COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
   marked_by_user_name                 VARCHAR(100)    COMMENT 'The MicroStrategy-User who marked the receipt',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_SUSPICIOUS_CASH_REGISTER_EVENT PRIMARY KEY (cash_register_event_sid, scenario_id) NOT ENFORCED
 )  COMMENT= 'From Business User marked receipts, which from his view of point are suspicious';
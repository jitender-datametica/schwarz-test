CREATE TABLE CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_RELATIONSHIP CLUSTER BY (COUNTRY_ORG_CD)(
   cash_register_event_sid             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.',
   cash_register_event_rel_type_cd     VARCHAR(20)     NOT NULL COMMENT 'The way one cash register event is related to another, return to sales receipt (Geldrügabe zu Originalbon) ',
   rel_cash_register_event_sid         NUMERIC(38,0)   NOT NULL COMMENT 'The child cash register event, which is part of the scenario like following receipt of show price or sale receipt of return',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the business country for which the related country organization is responsible, e.g. cash_register_event_sid. (The business country is not identical to a political country.)',
   bus_dt                              DATE            NOT NULL COMMENT 'The business date on which the retail event is counted.',
   rel_bus_dt                          DATE            NOT NULL COMMENT 'The business date on which the retail event is counted.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CASH_REGISTER_EVENT_RELATIONSHIP PRIMARY KEY (cash_register_event_sid, cash_register_event_rel_type_cd, rel_cash_register_event_sid) NOT ENFORCED
 )  COMMENT= 'The table lists the related cash register events of a main cash register event which is identified by a scenario e.g. return main scenario and its relevant sale receipt ';
CREATE TABLE CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_RELATIONSHIP_TYPE_1 (
   cash_register_event_rel_type_cd     VARCHAR(20)     NOT NULL COMMENT 'The way one cash register event is related to another, return to sales_1 receipt (Geldrügabe zu Originalbon) ',
   cash_register_event_rel_descr       VARCHAR(250)    NOT NULL COMMENT 'Describes the the way how one cash register event is related to another',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CASH_REGISTER_EVENT_RELATIONSHIP_TYPE PRIMARY KEY (cash_register_event_rel_type_cd) NOT ENFORCED
 )  COMMENT= 'Describes the relationship (between (two cash register events) type';
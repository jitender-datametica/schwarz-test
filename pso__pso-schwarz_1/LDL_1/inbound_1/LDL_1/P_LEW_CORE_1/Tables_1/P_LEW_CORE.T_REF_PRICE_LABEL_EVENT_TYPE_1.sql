CREATE TABLE P_LEW_CORE.T_REF_PRICE_LABEL_EVENT_TYPE_1 (
   price_label_event_type_cd           VARCHAR(100)     NOT NULL COMMENT 'The code for an event being transmitted by a price label (example: MATCHING, UNMATCHING).',
   price_label_event_type_descr        VARCHAR(250)     NOT NULL COMMENT 'The description for an event being transmitted by a price label (example: MATCHING, UNMATCHING).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_PRICE_LABEL_EVENT_TYPE PRIMARY KEY (price_label_event_type_cd) NOT ENFORCED 
)  COMMENT = 'The minor dimension containing types of events being transmitted by a price label. 
             Sources: Manual (ESL)';

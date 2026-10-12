CREATE TABLE P_LEW_CORE.T_REF_PRICE_LABEL_EVENT_DISPLAY_TYPE_1 (
   price_label_event_display_type_cd   VARCHAR(100)     NOT NULL COMMENT 'The code indicating what type of information is shown on the price label (ITEM_1 / CUSTOMER INFO / DEFECT).',
   price_label_event_display_type_descr VARCHAR(250)     NOT NULL COMMENT 'The description for an event display type code.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_PRICE_LABEL_EVENT_DISPLAY_TYPE PRIMARY KEY (price_label_event_display_type_cd) NOT ENFORCED 
)  COMMENT = 'What type of information is shown on the price label.
             Sources: Manual (ESL)';

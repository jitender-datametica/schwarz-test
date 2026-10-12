CREATE TABLE P_LEW_CORE.T_PRICE_LABEL_ITEM_ASSIGNMENT_2 (
   event_tmsp                          TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of an event.',
   price_label_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PRICE LABEL.',
   price_label_event_type_cd           VARCHAR(100)     NOT NULL COMMENT 'The code for an event being transmitted by a price label (example: MATCHING, UNMATCHING).',
   price_label_event_display_type_cd   VARCHAR(100)     NOT NULL COMMENT 'What type of information is shown on the price label.',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg).',
   next_event_tmsp                     TIMESTAMP_NTZ(9) COMMENT 'Timestamp of next event that happend with this label.',
   dwh_load_id                         VARCHAR(100)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_PRICE_LABEL_ITEM_ASSIGNMENT PRIMARY KEY (event_tmsp, price_label_sid, price_label_event_type_cd, price_label_event_display_type_cd, item_sid) NOT ENFORCED 
)  COMMENT = 'Contains the relationship between price label and item_2 / other information displayed on them (there can be multiple products displayed on 1 label).';

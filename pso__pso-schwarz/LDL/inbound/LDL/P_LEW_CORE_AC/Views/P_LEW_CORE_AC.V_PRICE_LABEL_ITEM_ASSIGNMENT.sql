CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_PRICE_LABEL_ITEM_ASSIGNMENT (
   event_tmsp                               COMMENT 'Timestamp of an event.'
  ,price_label_sid                          COMMENT 'Surrogate Key PRICE LABEL.'
  ,price_label_event_type_cd                COMMENT 'The code for an event being transmitted by a price label (example: MATCHING, UNMATCHING).'
  ,price_label_event_display_type_cd        COMMENT 'What type of information is shown on the price label.'
  ,item_sid                                 COMMENT 'Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg).'
  ,next_event_tmsp                          COMMENT 'Timestamp of next event that happend with this label.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The timestamp when the row was inserted.'
  ,dwh_updated                              COMMENT 'The timestamp when the row was updated the last time.'
)
COMMENT = 'Contains the relationship between price label and item / other information displayed on them (there can be multiple products displayed on 1 label).'
AS SELECT
   event_tmsp
  ,price_label_sid
  ,price_label_event_type_cd
  ,price_label_event_display_type_cd
  ,item_sid
  ,next_event_tmsp
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_PRICE_LABEL_ITEM_ASSIGNMENT
;
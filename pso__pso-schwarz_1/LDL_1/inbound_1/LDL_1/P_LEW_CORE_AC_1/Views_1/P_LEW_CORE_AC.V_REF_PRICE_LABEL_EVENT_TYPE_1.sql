CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_PRICE_LABEL_EVENT_TYPE_1 (
   price_label_event_type_cd                COMMENT 'The code for an event being transmitted by a price label (example: MATCHING, UNMATCHING).'
  ,price_label_event_type_descr             COMMENT 'The description for an event being transmitted by a price label (example: MATCHING, UNMATCHING).'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'The minor dimension containing types of events being transmitted by a price label. 
Sources: Manual (ESL)'
AS SELECT
   price_label_event_type_cd
  ,price_label_event_type_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_PRICE_LABEL_EVENT_TYPE_1
;
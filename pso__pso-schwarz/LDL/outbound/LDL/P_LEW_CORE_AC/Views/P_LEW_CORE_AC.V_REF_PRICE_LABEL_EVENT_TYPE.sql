CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_price_label_event_type (price_label_event_type_cd
OPTIONS(description='The code for an event being transmitted by a price label (example: MATCHING, UNMATCHING).'),
price_label_event_type_descr
OPTIONS(description='The description for an event being transmitted by a price label (example: MATCHING, UNMATCHING).'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THE MINOR DIMENSION CONTAINING TYPES OF EVENTS BEING TRANSMITTED BY A PRICE LABEL. SOURCES: MANUAL (ESL)`)
AS SELECT price_label_event_type_cd,
 price_label_event_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_price_label_event_type;
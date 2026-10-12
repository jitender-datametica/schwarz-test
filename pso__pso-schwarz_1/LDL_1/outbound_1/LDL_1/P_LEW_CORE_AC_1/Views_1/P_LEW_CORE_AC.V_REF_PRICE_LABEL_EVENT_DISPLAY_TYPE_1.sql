CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_price_label_event_display_type_1 (price_label_event_display_type_cd
OPTIONS(description='The code indicating what type of information is shown on the price label (ITEM_1 / CUSTOMER INFO / DEFECT).'),
price_label_event_display_type_descr OPTIONS(description='The description for an event display type code.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `WHAT TYPE OF INFORMATION IS SHOWN ON THE PRICE LABEL.SOURCES: MANUAL (ESL)`) AS SELECT
 price_label_event_display_type_cd,
 price_label_event_display_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_price_label_event_display_type_1;
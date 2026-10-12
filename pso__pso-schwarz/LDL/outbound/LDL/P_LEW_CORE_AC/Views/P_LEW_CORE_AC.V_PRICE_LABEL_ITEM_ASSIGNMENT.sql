CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_price_label_item_assignment (event_tmsp
OPTIONS(description='Timestamp of an event.'), price_label_sid OPTIONS(description='Surrogate Key PRICE LABEL.'),
price_label_event_type_cd
OPTIONS(description='The code for an event being transmitted by a price label (example: MATCHING, UNMATCHING).'),
price_label_event_display_type_cd OPTIONS(description='What type of information is shown on the price label.'), item_sid
OPTIONS(description='Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg).'), next_event_tmsp
OPTIONS(description='Timestamp of next event that happend with this label.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The timestamp when the row was inserted.'), dwh_updated
OPTIONS(description='The timestamp when the row was updated the last time.'))
OPTIONS(DESCRIPTION = `CONTAINS THE RELATIONSHIP BETWEEN PRICE LABEL AND ITEM / OTHER INFORMATION DISPLAYED ON THEM (THERE CAN BE MULTIPLE PRODUCTS DISPLAYED ON 1 LABEL).`)
AS SELECT event_tmsp,
 price_label_sid,
 price_label_event_type_cd,
 price_label_event_display_type_cd,
 item_sid,
 next_event_tmsp,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_price_label_item_assignment;
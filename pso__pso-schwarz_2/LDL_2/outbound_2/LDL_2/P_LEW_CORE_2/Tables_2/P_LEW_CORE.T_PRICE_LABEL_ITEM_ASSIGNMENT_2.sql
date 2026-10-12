CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_price_label_item_assignment_2 (
event_tmsp DATETIME NOT NULL OPTIONS(description='Timestamp of an event.'),
price_label_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PRICE LABEL.'),
price_label_event_type_cd STRING(100) NOT NULL
OPTIONS(description='The code for an event being transmitted by a price label (example: MATCHING, UNMATCHING).'),
price_label_event_display_type_cd STRING(100) NOT NULL
OPTIONS(description='What type of information is shown on the price label.'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg).'),
next_event_tmsp DATETIME OPTIONS(description='Timestamp of next event that happend with this label.'),
dwh_load_id STRING(100) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (event_tmsp, price_label_sid, price_label_event_type_cd, price_label_event_display_type_cd, item_sid)
NOT ENFORCED
)
OPTIONS(description='Contains the relationship between price label and item_2 / other information displayed on them (there can be multiple products displayed on 1 label).');
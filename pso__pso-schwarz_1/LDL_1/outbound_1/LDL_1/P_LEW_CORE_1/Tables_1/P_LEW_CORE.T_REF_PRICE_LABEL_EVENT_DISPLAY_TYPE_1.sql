CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_price_label_event_display_type_1 (
price_label_event_display_type_cd STRING(100) NOT NULL
OPTIONS(description='The code indicating what type of information is shown on the price label (ITEM_1 / CUSTOMER INFO / DEFECT).'),
price_label_event_display_type_descr STRING(250) NOT NULL
OPTIONS(description='The description for an event display type code.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (price_label_event_display_type_cd) NOT ENFORCED
) OPTIONS(description='What type of information is shown on the price label.             Sources: Manual (ESL)');
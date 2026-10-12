/* --------------------------------------------------------------------------------
   DDL for table: t_price_label_hist
   generated from Powerdesigner on Dienstag, 15. Juli 2025 14:31:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_price_label_hist (
price_label_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PRICE LABEL.'),
price_label_lifecycle_status_cd STRING(100)
OPTIONS(description='The code indicating the status of electronic price shields.'),
price_label_connect_status_cd STRING(100)
OPTIONS(description='The status defines if there is a connection to the label and changes can be transmitted.'),
damaged_fg BIGNUMERIC(38,0) OPTIONS(description='A flag indicating if an electronic price label shield is damaged.'),
price_label_damage_reason_id BIGNUMERIC(38,0)
OPTIONS(description='A unique code indicating the electronic price label shield damage reason.'),
last_register_tmsp DATETIME OPTIONS(description='A timestamp when the label has been registered in the system.'),
last_online_tmsp DATETIME
OPTIONS(description='A timestamp for the last time lable was successful in touch with the backend.'),
last_update_tmsp DATETIME
OPTIONS(description='A timestamp for the last time the price label has been updated (update of item, price, etc).'),
price_label_create_tmsp DATETIME
OPTIONS(description='A timestamp when the  label is created / registered in the store.'),
price_label_delete_tmsp DATETIME OPTIONS(description='A timestamp when the store marked the label as deleted / RMA.'),
last_display_refresh_tmsp DATETIME
OPTIONS(description='A timestamp when the display of a label has been refreshed for the last time (display has been reloaded, however the content may stay the same).'),
last_tech_display_refresh_tmsp DATETIME
OPTIONS(description='Time stamp for the last  update of the same picture on the label to regenerate the correct color range. E.g. if a label is not updated for a while the red color is not as red as at the beginning'),
last_item_link_tmsp DATETIME
OPTIONS(description='A timestamp for the last time when a new item has been assigned to a price label.'),
display_update_status_name STRING(100)
OPTIONS(description='The status that was returned after last price label display refresh.'),
price_label_client_id BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key CLIENT. Indicates from which country price label was sent to repair'),
loc_sid_store BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key LOCATION (eindeutig ueber alle Laender / Mandanten hinweg).'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Article is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
client_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CLIENT'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (price_label_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='Contains historised data about price label shields - physical objects that are meant to display the current price of the items. Now contains data only about electronic price shields.             Source: Solum, Imagotag (ESL)');
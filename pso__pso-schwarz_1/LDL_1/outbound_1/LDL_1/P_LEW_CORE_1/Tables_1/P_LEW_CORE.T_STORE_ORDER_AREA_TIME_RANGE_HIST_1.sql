/* --------------------------------------------------------------------------------
   DDL for table: t_store_order_area_time_range_hist_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_store_order_area_time_range_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='store that wants to order'),
order_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='order area that is relevant for the order'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='warehouse, at which the order is placed'),
wh_order_time_range_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='time range relevant for the Store, if items of the specified order area at the WH are ordered'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='indication, whether the relationship is still active (deleted_fg = 0) or inactive (deleted_fg = 1)'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid_store, loc_sid_wh, order_area_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Definition of which order times are relevant for a store that orders items of a specific order area of a WH in order to guarantee a delivery in time');
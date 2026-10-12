/* --------------------------------------------------------------------------------
   DDL for table: t_warehouse_order_area_hist_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_warehouse_order_area_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2;'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='reference to the WH'),
order_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='reference to the Order Area'),
wh_order_area_name STRING(100)
OPTIONS(description='name describing the order area within a WH - may or may not be the same as the general name of the order area'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='indication, whether the relationship is still active (deleted_fg = 0) or inactive (deleted_fg = 1)'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid_wh, order_area_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Order areas ("Bestellbereiche") defined for a warehouse - based on the general set of order areas. Items are then related to specific order areas.             Example: Non-Food -> dog toy or T-shirt; Bake-Off -> bread; Cooling -> yoghurt');
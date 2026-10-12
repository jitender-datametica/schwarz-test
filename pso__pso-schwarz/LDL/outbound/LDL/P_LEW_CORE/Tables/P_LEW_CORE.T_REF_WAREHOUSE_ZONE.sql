/* --------------------------------------------------------------------------------
   DDL for table: t_ref_warehouse_zone
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 16:00:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_warehouse_zone (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION'),
wh_zone_nr STRING(100) NOT NULL OPTIONS(description='Code for the WH area of activity.'),
wh_zone_descr STRING(250) OPTIONS(description='Description of the WH area of activity.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_loc_sid, wh_zone_nr) NOT ENFORCED
) OPTIONS(description='Table contains the warehouse area where the activity is to be performed.');
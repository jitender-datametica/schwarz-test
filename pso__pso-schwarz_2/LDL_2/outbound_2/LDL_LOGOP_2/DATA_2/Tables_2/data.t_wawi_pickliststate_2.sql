CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_pickliststate_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country_2 code'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number'),
picklistno BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Primary key, identification of the picking list number'),
orderarea STRING(8) NOT NULL OPTIONS(description='Order area number'),
keycode BIGNUMERIC(38,0) OPTIONS(description='Current status_2 of the picking list.'),
storeno BIGNUMERIC(38,0) OPTIONS(description='Branch number'),
formdate DATETIME OPTIONS(description='Delivery date of the order'),
moddate DATETIME OPTIONS(description='Last time changes were made'),
moduser STRING(8) OPTIONS(description='Last user who made changes'),
oldkeycode BIGNUMERIC(38,0) OPTIONS(description='Last status_2 of the picking list'),
scn BIGNUMERIC(38,0) OPTIONS(description=''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, picklistno, orderarea, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='WAWI - WHWAWIADM.T831_PICKLISTSTATE. Detailed table for the status_2 of branch orders or picking lists.');
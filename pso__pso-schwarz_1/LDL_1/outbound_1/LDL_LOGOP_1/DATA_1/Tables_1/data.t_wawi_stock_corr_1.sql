/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_stock_corr_1
Description		|	WAWI table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_stock_corr_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number. Original name: wh_nr'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country_1 code'),
form_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Document number'),
form_date DATE OPTIONS(description='End of day date'),
item_nr STRING(18) OPTIONS(description='Item_1 number'),
item_desc STRING(100) OPTIONS(description='Item_1 name'),
reason_id STRING(20) OPTIONS(description=''),
reason_desc STRING(254) OPTIONS(description='Reason for inventory change'),
stc_val_flag BIGNUMERIC(38,0) OPTIONS(description=''),
case_qty BIGNUMERIC(38,0) OPTIONS(description='Inventory change'),
tg_status BIGNUMERIC(38,0) OPTIONS(description=''),
mod_user STRING(8) OPTIONS(description='User who made changes'),
mod_date DATETIME OPTIONS(description='Date of change'),
decimal_case BIGNUMERIC(38,3) OPTIONS(description=''),
piece_qty BIGNUMERIC(38,3) OPTIONS(description='Piece quantity'),
form_nr_ref STRING(25) OPTIONS(description='Formno ref (e.g. EWM Formno)'),
ewm_form_date DATE OPTIONS(description='EWM Formdate'),
act_price_gross BIGNUMERIC(38,3) OPTIONS(description='Actual Price Gross'),
act_price_net BIGNUMERIC(38,3) OPTIONS(description='Actual Price Net'),
value_gross BIGNUMERIC(38,3) OPTIONS(description='Value Gross'),
value_net BIGNUMERIC(38,3) OPTIONS(description='Value net'),
charge STRING(35) OPTIONS(description='C067_CHARGE'),
scn BIGNUMERIC(38,0) OPTIONS(description=''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, form_nr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.T067_STOCK_CORR_1 table');
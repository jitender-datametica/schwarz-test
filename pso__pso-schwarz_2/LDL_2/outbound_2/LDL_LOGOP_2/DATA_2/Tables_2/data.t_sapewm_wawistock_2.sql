/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_wawistock_2
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_wawistock_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
lgnum STRING(5) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
entitled STRING(10) OPTIONS(description='Party Entitled to Dispose'),
matnr STRING(40) NOT NULL OPTIONS(description='Product'),
charg STRING(10) OPTIONS(description='Batch'),
batch STRING(50) OPTIONS(description='Batch characteristic: External vendor batch'),
sub_art STRING(5) OPTIONS(description='F&V Sub Article Number'),
qty BIGNUMERIC(38,14) OPTIONS(description='Quantity Field'),
uom STRING(3) OPTIONS(description='Base Unit_2 of Measure'),
del_date DATE OPTIONS(description='Delivery Date (Planned)'),
pick_qty BIGNUMERIC(38,14) OPTIONS(description='Picking quantity'),
auom STRING(3) OPTIONS(description='Alternative Unit_2 of Measure for Stockkeeping Unit_2'),
nfc_calc BOOL OPTIONS(description='NFC: Calculation flag'),
nfc_calc_icon STRING(4) OPTIONS(description='NFC: Calculation flag (icon)'),
nfc_ewmcalc BIGNUMERIC(38,14) OPTIONS(description='NFC: Calculated EWM'),
nfc_underdlv BIGNUMERIC(38,14) OPTIONS(description='NFC: Underdelivery'),
nfc_overdlv BIGNUMERIC(38,14) OPTIONS(description='NFC: Overdelivery'),
nfc_nonrecall BIGNUMERIC(38,14) OPTIONS(description='NFC: Non-Recall'),
nfc_zerodlv BIGNUMERIC(38,14) OPTIONS(description='NFC: Zero delivery'),
nfc_spsenhance BIGNUMERIC(38,14) OPTIONS(description='NFC: SPS Enhancement'),
nfc_spsreduct BIGNUMERIC(38,14) OPTIONS(description='NFC: SPS Reduction'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, lgnum, matnr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='SAP EWM - Monitor node WaWi Stock/FVM Determination');
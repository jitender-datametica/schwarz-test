/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_availablestock
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_availablestock (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
lgnum STRING(5) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
lgtyp STRING(4) OPTIONS(description='Storage Type'),
lgpla STRING(18) NOT NULL OPTIONS(description='Storage Bin'),
logpos STRING(2) OPTIONS(description='Logical Position of Handling Unit'),
rsrc STRING(18) OPTIONS(description='Resource (Means of Transportation or User)'),
tu_num STRING(18) OPTIONS(description='Internal Number of Transportation Unit'),
tu_num_ext STRING(20) OPTIONS(description='Transportation Unit'),
tsp STRING(10) OPTIONS(description='Carrier'),
guid_parent STRING(50) OPTIONS(description='Parent GUID'),
guid_stock STRING(50) NOT NULL OPTIONS(description='GUID Stock Item'),
huident STRING(20) NOT NULL OPTIONS(description='Handling Unit Identification'),
matid STRING(50) OPTIONS(description='Product'),
matnr STRING(40) NOT NULL OPTIONS(description='Product'),
maktx STRING(40) OPTIONS(description='Product Short Description'),
quan BIGNUMERIC(38,3) OPTIONS(description='Quantity'),
unit STRING(3) OPTIONS(description='Base Unit of Measure'),
cat STRING(2) OPTIONS(description='Stock Type'),
cat_txt STRING(30) OPTIONS(description='Description of Stock Type'),
charg STRING(10) NOT NULL OPTIONS(description='Batch'),
brestr BOOL OPTIONS(description='Batch in Restricted-Use Stock'),
coo STRING(3) OPTIONS(description='Country of Origin'),
owner STRING(10) OPTIONS(description='Owner'),
entitled STRING(10) NOT NULL OPTIONS(description='Party Entitled to Dispose'),
stock_usage STRING(1) OPTIONS(description='Stock Usage'),
stock_doccat STRING(3) OPTIONS(description='Type: Sales Order Stock or Project Stock'),
stock_docno STRING(35) OPTIONS(description='Number of the Sales Order or Project for Special Stock'),
stock_itmno BIGNUMERIC(38,0) OPTIONS(description='Sales Order Item for Sales Order Stock'),
insptyp STRING(1) OPTIONS(description='Inspection ID Type'),
inspdocno STRING(35) OPTIONS(description='QIE Entity: External Identification'),
vfdat DATE OPTIONS(description='Shelf Life Expiration Date'),
ui_wdatt TIME NOT NULL OPTIONS(description='Goods Receipt Time'),
ui_wdatu DATE NOT NULL OPTIONS(description='Goods Receipt Date'),
skzsi BOOL OPTIONS(description='Blocking Indicator: Current Inventory (System)'),
outcon STRING(1) OPTIONS(description='Storage Bin Improvable'),
dummy_field STRING(1) OPTIONS(description='Dummy function in length 1'),
zeugn STRING(10) OPTIONS(description='Certificate Number'),
psa STRING(15) OPTIONS(description='Production Supply Area'),
doccat STRING(3) OPTIONS(description='Doc. Category for Doc. Reference and Doc.-Related Stocks'),
quana BIGNUMERIC(38,3) OPTIONS(description='Available Quantity in Alternative Unit of Measure'),
altme STRING(3) OPTIONS(description='Alternative Unit of Measure for Stockkeeping Unit'),
flgmove BOOL OPTIONS(description='Indicator: Handling Unit is Being Moved (Open HU WT)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, lgnum, huident, matnr, ui_wdatu, ui_wdatt, charg, lgpla, guid_stock, entitled, dwh_valid_from)
NOT ENFORCED
) OPTIONS(description='SAP EWM - Overview of Available Stock Monitor');
/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_warehouseattributeitem_1
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_warehouseattributeitem_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
lgnum STRING(5) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
matnr STRING(40) NOT NULL OPTIONS(description='Product'),
entitled STRING(10) OPTIONS(description='Party Entitled to Dispose'),
umren BIGNUMERIC(38,0) OPTIONS(description='Denominator for conversion to base units of measure'),
mandt STRING(3) OPTIONS(description='Client'),
matid STRING(22) OPTIONS(description='Internal Number (UID) for Product'),
meinh STRING(3) NOT NULL OPTIONS(description='Alternative Unit_1 of Measure'),
umrez BIGNUMERIC(38,0) OPTIONS(description='Numerator for Conversion to Base Units of Measure'),
basme STRING(3) OPTIONS(description='Base Unit_1 of Measure'),
ean11 STRING(18) OPTIONS(description='GTIN (EAN_1 or UPC)'),
eancat STRING(2) OPTIONS(description='Number Category of GTIN (EAN_1/UPC)'),
gtin_variant STRING(2) OPTIONS(description='Variant for the Global Trade Item_1 Number'),
brgew BIGNUMERIC(38,3) OPTIONS(description='Gross Weight'),
ntgew BIGNUMERIC(38,3) OPTIONS(description='Net weight'),
gewei STRING(3) OPTIONS(description='Unit_1 of Weight'),
volum BIGNUMERIC(38,3) OPTIONS(description='Volume'),
voleh STRING(3) OPTIONS(description='Unit_1 of Volume'),
capause BIGNUMERIC(38,3) OPTIONS(description='Capacity Consumption'),
laeng BIGNUMERIC(38,3) OPTIONS(description='Length'),
breit BIGNUMERIC(38,3) OPTIONS(description='Width'),
hoehe BIGNUMERIC(38,3) OPTIONS(description='Height'),
meabm STRING(3) OPTIONS(description='Unit_1 of Dimension for Length/Width/Height'),
maxstack BIGNUMERIC(38,0) OPTIONS(description='Maximum Stacking Factor'),
nest_ftr BIGNUMERIC(38,0) OPTIONS(description='Remaining Volume After Nesting (in Percent)'),
ty2tq STRING(1) OPTIONS(description='Category of Unit_1 of Measure'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, lgnum, matnr, meinh, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='SAP EWM - Product Units of Measure Structure');
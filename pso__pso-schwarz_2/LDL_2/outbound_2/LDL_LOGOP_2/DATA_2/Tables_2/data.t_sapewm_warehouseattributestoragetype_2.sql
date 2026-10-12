/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_warehouseattributestoragetype_2
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_warehouseattributestoragetype_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
lgnum STRING(5) NOT NULL OPTIONS(description='Client of the EWM system'),
matid STRING(22) OPTIONS(description='Warehouse Number/Warehouse Complex'),
matnr STRING(40) NOT NULL OPTIONS(description='Product'),
entitled STRING(10) NOT NULL OPTIONS(description='Party Entitled to Dispose'),
lgtyp STRING(4) NOT NULL OPTIONS(description='Storage Type'),
sectind STRING(4) OPTIONS(description='Storage Section Indicator'),
sectind_fix BOOL OPTIONS(description='Preferred Storage Section Indicator: Fixed'),
sectind_plan STRING(4) OPTIONS(description='Planned Storage Section Indicator'),
bintype STRING(4) OPTIONS(description='Storage Bin Type'),
bintype_fix BOOL OPTIONS(description='Preferred Storage Bin Type Fixed'),
bintype_plan STRING(4) OPTIONS(description='Planned Storage Bin Type'),
maxfixbin BIGNUMERIC(38,0) OPTIONS(description='Maximum No. of Bins'),
maxfixbin_fix BOOL OPTIONS(description='Maximum Number of Fixed Bins: Fixed'),
maxfixbin_plan BIGNUMERIC(38,0) OPTIONS(description='Planned Maximum Number of Bins'),
binsrch STRING(1) OPTIONS(description='Sort Rule for Empty Storage Bin Search'),
splitth BIGNUMERIC(38,2) OPTIONS(description='Putaway Threshold Addition (in Percent of Storage Bin)'),
splitput BOOL OPTIONS(description='Split During Putaway'),
norpln BOOL OPTIONS(description='No Replenishment'),
repqty BIGNUMERIC(38,3) OPTIONS(description='Minimum Replenishment Quantity'),
repqty_uom_dsp STRING(3) OPTIONS(description='Display Unit_2 of Measure for Replenishment Quantity'),
repqty_plan BIGNUMERIC(38,3) OPTIONS(description='Planned Minimum Replenishment Quantity'),
minqty BIGNUMERIC(38,3) OPTIONS(description='Minimum Quantity'),
minqty_uom_dsp STRING(3) OPTIONS(description='Display Unit_2 of Measure for Minimum Quantity'),
minqty_plan BIGNUMERIC(38,3) OPTIONS(description='Planned Minimum Quantity in Storage Type'),
maxqty BIGNUMERIC(38,3) OPTIONS(description='Maximum Quantity'),
maxqty_uom_dsp STRING(3) OPTIONS(description='Display Unit_2 of Measure for Maximum Quantity'),
maxqty_plan BIGNUMERIC(38,3) OPTIONS(description='Planned Maximum Quantity in Storage Type'),
rmmqty_fix BOOL OPTIONS(description='Minimum/Maximum/Replenishment Quantity Fixed'),
permxqty BIGNUMERIC(38,2) OPTIONS(description='Minimum Quantity as Percentage of Maximum Quantity'),
quancla STRING(1) OPTIONS(description='Quantity Classification in Warehouse'),
quanclaput STRING(1) OPTIONS(description='Putaway Quantity Classification'),
seqput STRING(2) OPTIONS(description='Putaway Sequence'),
seqput_fix BOOL OPTIONS(description='Sequence of Putaway Fixed'),
seqput_plan STRING(2) OPTIONS(description='Planned Putaway Sequence'),
skipptw BOOL OPTIONS(description='Skip During Putaway'),
skipptw_fix BOOL OPTIONS(description='Skip in Putaway Fixed'),
skipptw_plan BOOL OPTIONS(description='Planned Skip During Putaway'),
meins STRING(3) OPTIONS(description='Base Unit_2 of Measure'),
no_whstdata STRING(1) OPTIONS(description='Product Has No Storage Type Warehouse Data View'),
whst_data_exists STRING(8) OPTIONS(description='Storage Type Warehouse Data Exists'),
mtart STRING(4) OPTIONS(description='Material Type'),
mmsta STRING(2) OPTIONS(description='Plant-Specific Material Status_2'),
dummy_whst_incl_eew_ps STRING(1) OPTIONS(description='Dummy_2 Field for Enhancement Fields'),
z_ptwy_max_qty BIGNUMERIC(38,3) OPTIONS(description='EEW: LIDL PTWY Max. Quantity'),
zz_ptwy_max_0001 STRING(3) OPTIONS(description='Ref field for Quantity in EEW'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, lgnum, matnr, lgtyp, entitled, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='SAP EWM - Product storage type attributes');
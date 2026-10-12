/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_scwmbinmat_1
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_scwmbinmat_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
lgnum STRING(5) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
matid STRING(50) OPTIONS(description='Product'),
entitled STRING(10) OPTIONS(description='Party Entitled to Dispose'),
lgpla STRING(18) NOT NULL OPTIONS(description='Storage Bin'),
lgtyp STRING(4) OPTIONS(description='Storage Type'),
outcon STRING(1) OPTIONS(description='Storage Bin Improvable'),
datout DATE OPTIONS(description='Storage Bin Improvable Changed On'),
maxqty BIGNUMERIC(38,3) OPTIONS(description='Maximum Quantity'),
maxqty_uom_dsp STRING(3) OPTIONS(description='Display Unit_1 of Measure for Maximum Quantity'),
minqty BIGNUMERIC(38,3) OPTIONS(description='Minimum Quantity'),
minqty_uom_dsp STRING(3) OPTIONS(description='Display Unit_1 of Measure for Minimum Quantity'),
matnr STRING(40) NOT NULL OPTIONS(description='Product'),
rmmqty_fix STRING(1) OPTIONS(description='Minimum/Maximum/Replenishment Quantity Fixed'),
created_at DATETIME OPTIONS(description='Creation Time'),
created_by STRING(12) OPTIONS(description='Created By'),
improv_fix STRING(1) OPTIONS(description='Storage Bin Improvable Fixed'),
zz_campaign STRING(1) OPTIONS(description='Campaign'),
zz_maxhufixbin BIGNUMERIC(38,0) OPTIONS(description='Maximal HUs in Fixbin'),
zz_reservefixbin BIGNUMERIC(38,0) OPTIONS(description='Reserve HUs for Fix bins'),
zz_acp_sqty STRING(1) OPTIONS(description='ACP Small qty'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, lgnum, lgpla, matnr) NOT ENFORCED
) OPTIONS(description='SAP EWM - Assignment Table for Fixed Bins - Product');
/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_nfstoreevaluation_temp_1
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_sapewm_nfstoreevaluation_temp_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
lgnum STRING(4) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
zz_kw STRING(2) NOT NULL OPTIONS(description='Calendar_1 week'),
zz_year STRING(4) NOT NULL OPTIONS(description='Calendar_1 year'),
zz_refbs STRING(10) NOT NULL OPTIONS(description='Return number'),
zz_refbs_top STRING(10) OPTIONS(description='Return number'),
partyno STRING(10) OPTIONS(description='Company number'),
bu_sort1 STRING(40) OPTIONS(description='Description'),
zz_werks STRING(4) NOT NULL OPTIONS(description='Store'),
party_text STRING(40) OPTIONS(description='Description'),
bu_partner STRING(10) OPTIONS(description='Business Partner Number'),
productno STRING(40) NOT NULL OPTIONS(description='Product Number'),
maktx STRING(40) OPTIONS(description='Product Short Description'),
mat_price BIGNUMERIC(38,2) OPTIONS(description='Material price'),
ok_prep_qty BIGNUMERIC(38,0) OPTIONS(description='Dataelement scanned ok quantity'),
dfkt_qty BIGNUMERIC(38,0) OPTIONS(description='NF complete defect qty'),
total_quan BIGNUMERIC(38,0) OPTIONS(description='scanned quantity'),
credit BIGNUMERIC(38,2) OPTIONS(description='Credit value'),
exp_quan BIGNUMERIC(38,0) OPTIONS(description='Expected Quantity'),
total_value BIGNUMERIC(38,2) OPTIONS(description='Total value'),
dif_quan BIGNUMERIC(38,0) OPTIONS(description='Dataelement difference quantity'),
dif_value BIGNUMERIC(38,2) OPTIONS(description='Dataelement difference value'),
matnr_dummy STRING(40) OPTIONS(description='Dummy_1 material number'),
maktxd STRING(40) OPTIONS(description='Product Short Description'),
dummy_price BIGNUMERIC(38,2) OPTIONS(description='dummy_1 material price'),
dummy_quan BIGNUMERIC(38,0) OPTIONS(description='Dataelement Dummy_1 quantity'),
waers STRING(5) OPTIONS(description='Currency Key'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, lgnum, zz_refbs, zz_kw, zz_year, zz_werks, productno) NOT ENFORCED
) OPTIONS(description='SAP EWM - Store evaluation');
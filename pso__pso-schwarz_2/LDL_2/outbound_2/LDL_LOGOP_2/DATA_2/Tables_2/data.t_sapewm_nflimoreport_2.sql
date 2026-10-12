/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_nflimoreport_2
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_nflimoreport_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
lgnum STRING(4) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
zz_refbs STRING(10) NOT NULL OPTIONS(description='Return number'),
ret_status STRING(4) OPTIONS(description='Retrun Status_2'),
zz_kw STRING(2) NOT NULL OPTIONS(description='Calendar_2 week'),
zz_year STRING(4) NOT NULL OPTIONS(description='Calendar_2 year'),
action_cd STRING(60) OPTIONS(description='Action'),
reason STRING(40) OPTIONS(description='Reason'),
counted_hu BIGNUMERIC(38,0) OPTIONS(description='WE EP'),
amount_stores BIGNUMERIC(38,0) OPTIONS(description='Amount Stores in Return'),
avg_gr_p_s BIGNUMERIC(38,0) OPTIONS(description='Average Goods Receipt per Store'),
avg_sum_pp BIGNUMERIC(38,0) OPTIONS(description='Average Sum per Pallet'),
diff_art BIGNUMERIC(38,0) OPTIONS(description='Different Articles'),
avg_pal_pc BIGNUMERIC(38,0) OPTIONS(description='Average pieces/pallet'),
avg_rv_exp BIGNUMERIC(38,0) OPTIONS(description='Average Return Value Expected'),
avg_val_s BIGNUMERIC(38,0) OPTIONS(description='Average Value Store'),
val_pal BIGNUMERIC(38,2) OPTIONS(description='Exp.Quantity per Counted HU'),
val_ex BIGNUMERIC(38,2) OPTIONS(description='Value Ok Scanned materials'),
ex_quan BIGNUMERIC(38,0) OPTIONS(description='Expected Quantities'),
avg_pc_exp BIGNUMERIC(38,0) OPTIONS(description='Average Piece per Store expected'),
scan_am_val BIGNUMERIC(38,0) OPTIONS(description='Scanned Amount Value'),
scan_pc_p_ret BIGNUMERIC(38,0) OPTIONS(description='Scanned Pieces per Return'),
df_quan_per BIGNUMERIC(38,2) OPTIONS(description='defect quantity percentage'),
df_quan BIGNUMERIC(38,0) OPTIONS(description='NF complete defect qty'),
unkn_quan BIGNUMERIC(38,0) OPTIONS(description='NF Complete Unknown Quantity'),
pack_pal BIGNUMERIC(38,0) OPTIONS(description='Packed Pallets'),
pack_pc BIGNUMERIC(38,0) OPTIONS(description='Packed Pieces'),
waers STRING(5) OPTIONS(description='Currency Key'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, lgnum, zz_refbs, zz_kw, zz_year) NOT ENFORCED
) OPTIONS(description='SAP EWM - Limo report');
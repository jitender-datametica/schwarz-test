/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_bestand_2
Description		|	LPV source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lpv_bestand_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'),
stock_id STRING(20) NOT NULL OPTIONS(description='Surrogate key: Internal ID. Primary key. Original name - bestandid'),
src_pallet_nr STRING(30)
OPTIONS(description='Number of the pallet on which the stock is located. Original name - lhmnr'),
article_nr STRING(20) OPTIONS(description='Article number. Original name - anr'),
batch STRING(30) OPTIONS(description='Batch. Original name - charge'),
src_qty BIGNUMERIC(38,0)
OPTIONS(description='Quantity (number of pieces of unit_2 AST.VPE1). May be multiplied in order to display decimal places according to the global setting MengenFakt. Original name - menge'),
available_qty BIGNUMERIC(38,0)
OPTIONS(description='Available quantity. Quantities will be reserved as soon as warehouse orders for movements and replenishments are created. In such cases the value MENGE_V will be smaller than MENGE. Original name - menge_v'),
status_2 STRING(3)
OPTIONS(description='Indicates whether the stock is blocked. 2nd letter indicated whether the stock is inventoried. Original name - status_2'),
gr_date DATE OPTIONS(description='GR date. Original name - datum'),
src_area_nr BIGNUMERIC(38,0)
OPTIONS(description='Number of the area the stock is currently located in. Original name - bereich'),
gr_id BIGNUMERIC(38,0) OPTIONS(description='LPV-internal number of the goods receipt. Original name - weidnr'),
change_dt DATE OPTIONS(description='Last change of the record. Original name - letzter_zugriff'),
supplier_2 STRING(40)
OPTIONS(description='Supplier_2 of the article (communicated by eGIN via WMI). Original name - lieferant'),
weight BIGNUMERIC(38,0)
OPTIONS(description='Stock weight in g. The number is multiplied with 1000. Original name - gewicht'),
p1_egin_task_id STRING(70) OPTIONS(description='eGIN task ID. Original name - p1'),
p2_gr_position STRING(70)
OPTIONS(description='Position at the gate during counting (in order to load 3 consecutive pallets onto a fast mover). Original name - p2'),
p3_gr_priority STRING(70) OPTIONS(description='Priority. Default: 50. Missing item_2: 1. Original name - p3'),
p4_pallet_factor STRING(70) OPTIONS(description='Pallet factor. Original name - p4'),
p5_best_before_dt DATE OPTIONS(description='Best before date. Original name - p5'),
p6_filling_year BIGNUMERIC(38,0) OPTIONS(description='Filling year. May be empty for most articles. Original name - p6'),
p7_gr_id STRING(70) OPTIONS(description='GR ID. Original name - p7'),
p8_special_offer STRING(70) OPTIONS(description='Special offers indicator (German: Aktionsware). Original name - p8'),
p9 STRING(70) OPTIONS(description='Not used in LPV 8. Original name - p9'),
p10 STRING(70) OPTIONS(description='Not used in LPV 8. Original name - p10'),
delivery_dt DATE
OPTIONS(description='Latest delivery date, calculated with BESTAND.P5 - AST.V4 (BBD - Minimum days before the BBD is reached / Restlaufzeit). Original name - mhd'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, stock_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='LPV - This table saves stock quantities and information.');
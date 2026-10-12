/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_tabakt
Description		|	LPV source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lpv_tabakt (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number(lagernummer)'),
operation_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key. Original name - REIHE'),
operation_tmsp DATETIME OPTIONS(description='Time stamp in format\"YYYYMMDDHH24MiSS\". Original name - STAMPNR'),
operation_type STRING(2) OPTIONS(description='Operation type. Original name - OPERATION'),
user_id STRING(9)
OPTIONS(description='User ID of the executing user. Foreign key: Referencing LPV.PERSONAL.PERSNR. Original name - PERSNR'),
article_nr STRING(20) OPTIONS(description='Article number. Foreign key: References LPV.AST.ANR. Original name - ANR'),
src_qty BIGNUMERIC(38,0)
OPTIONS(description='Quantity (cf. explantion for table LPV.BESTAND in order to correctly interpret this number). Original name - MENGE'),
tgt_qty BIGNUMERIC(38,0) OPTIONS(description='Target quantity. Original name - SOLLMENGE'),
stock_id STRING(20)
OPTIONS(description='Stock ID. Foreign key: References LPV.BESTAND.BESTANDID. Original name - BESTANDID'),
gr_id BIGNUMERIC(38,0) OPTIONS(description='LPV-internal number of the goods receipt. Original name - WEIDNR'),
batch STRING(30) OPTIONS(description='Batch. Original name - CHARGE'),
p1_egin_task_id STRING(70) OPTIONS(description='eGIN task ID. Original name - P1'),
p2_gr_position STRING(70) OPTIONS(description='Position at the gate during counting. Original name - P2'),
p3_gr_priority STRING(70) OPTIONS(description='Priority. Original name - P3'),
p4_pallet_factor STRING(70) OPTIONS(description='Pallet factor. Original name - P4'),
p5_best_before_dt DATE OPTIONS(description='Best before date in Format\"YYYYMMDD\". Original name - P5'),
p6_filling_year BIGNUMERIC(38,0)
OPTIONS(description='Filling year in Format\"YYYY\". May be empty for most articles.. Original name - P6'),
p7_gr_id STRING(70) OPTIONS(description='GR ID. Original name - P7'),
p8_special_offer STRING(70) OPTIONS(description='Special offers indicator (German: Aktionsware). Original name - P8'),
p9 STRING(70) OPTIONS(description='Not used in LPV 8. Original name - P9'),
p10 STRING(70) OPTIONS(description='Not used in LPV 8. Original name - P10'),
src_area_nr BIGNUMERIC(38,0)
OPTIONS(description='Source area. Foreign key: Referencing LPV.BEREICH.NR. Original name - BEREICH'),
src_location_id STRING(11)
OPTIONS(description='Source location ID. Foreign key: Referencing LPV.WHX.ORT. Original name - ORT'),
src_pallet_nr STRING(30)
OPTIONS(description='Number of the pallet on which the stock is located. Foreign key: References LPV.LHM.LHMNR. Original name - LHMNR'),
tgt_area_nr BIGNUMERIC(38,0)
OPTIONS(description='Target area. Foreign key: Referencing LPV.BEREICH.NR. Original name - ZIELBEREICH'),
tgt_location_id STRING(11)
OPTIONS(description='Target location ID, may be empty. Foreign key: Referencing LPV.WHX.ORT. Original name - ZIELORT'),
tgt_pallet_nr STRING(30)
OPTIONS(description='Target pallet number. Foreign key: References LPV.LHM.LHMNR. Original name - ZIELLHMNR'),
computer_id STRING(15)
OPTIONS(description='Computer that initiated the goods movement. Foreign key: References LPV.RECHNER.RECHNERID. Original name - RECHNERID'),
delivery_dt DATE OPTIONS(description='Delivery date. Original name - MHD'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, operation_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='LPV - This table saves all stock movements and withdrawals.');
/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_lpv_tabakt_1
Description		|	LPV - prepared view on source table
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_lpv_tabakt_1 (
	client_id COMMENT 'Client id - calculated based on the country_1 code'
	,lidl_ctry COMMENT 'Country_1 code. Original field name bic_zmlila'
	,wh_id COMMENT 'Warehouse number (datastore_data:lagernummer). Foreign key: Referencing LPV.LAGER.LAGERNR'
	,src_sys COMMENT 'Source system'
	,op_id COMMENT 'Surrogate key'
	,op_ts COMMENT 'Time stamp in format "YYYYMMDDHH24MiSS"'
	,op_dt COMMENT 'Operation date from timestamp'
	,op_tm COMMENT 'Operation time from timestamp'
	,op_type COMMENT 'Operation type'
	,user_id COMMENT 'User ID of the executing user. Foreign key: Referencing LPV.PERSONAL.PERSNR'
	,article_nr COMMENT 'Article number. Foreign key: References LPV.AST.ANR'
	,src_qty COMMENT 'Quantity (cf. explantion for table LPV.BESTAND in order to correctly interpret this number)'
	,tgt_qty COMMENT 'Target quantity'
	,stock_id COMMENT 'Stock ID. Foreign key: References LPV.BESTAND.BESTANDID'
	,gr_id COMMENT 'LPV-internal number of the goods receipt'
	,batch COMMENT 'Batch'
	,p1_egin_task_id COMMENT 'eGIN task ID'
	,p2_gr_position COMMENT 'Position at the gate during counting'
	,p3_gr_priority COMMENT 'Priority'
	,p4_pallet_factor COMMENT 'Pallet factor'
	,p5_best_before_dt COMMENT 'Best before date in Format "YYYYMMDD"'
	,p6_filling_year COMMENT 'Filling year in Format "YYYY". May be empty for most articles.'
	,p7_gr_id COMMENT 'GR ID'
	,p8_special_offer COMMENT 'Special offers indicator (German: Aktionsware)'
	,p9 COMMENT 'Not used in LPV 8'
	,p10 COMMENT 'Not used in LPV 8'
	,src_area_nr COMMENT 'Source area. Foreign key: Referencing LPV.BEREICH.NR'
	,src_loc_id COMMENT 'Source location_1 ID. Foreign key: Referencing LPV.WHX.ORT'
	,src_pallet_nr COMMENT 'Number of the pallet on which the stock is located. Foreign key: References LPV.LHM.LHMNR'
	,tgt_area_nr COMMENT 'Target area. Foreign key: Referencing LPV.BEREICH.NR'
	,tgt_loc_id COMMENT 'Target location_1 ID, may be empty. Foreign key: Referencing LPV.WHX.ORT'
	,tgt_pallet_nr COMMENT 'Target pallet number. Foreign key: References LPV.LHM.LHMNR'
	,comp_id COMMENT 'Computer that initiated the goods movement. Foreign key: References LPV.RECHNER.RECHNERID'
	,deliv_dt COMMENT 'Delivery date'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,dwh_valid_from COMMENT 'Valid from date'
	,dwh_valid_to COMMENT 'Valid to date'
	,deleted_fg COMMENT 'Flag if record is deleted'
	)
COMMENT = 'LPV - prepared view on base table (PK client_id, wh_nr, op_id, dwh_valid_from)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,wh_id
	,source_system AS src_sys
	,operation_id AS op_id
	,operation_tmsp AS op_ts
	,TO_DATE(operation_tmsp) AS op_dt
	,TO_TIME(operation_tmsp) AS op_tm
	,operation_type AS op_type
	,user_id
	,article_nr
	,src_qty
	,tgt_qty
	,stock_id
	,gr_id
	,batch
	,p1_egin_task_id
	,p2_gr_position
	,p3_gr_priority
	,p4_pallet_factor
	,p5_best_before_dt
	,p6_filling_year
	,p7_gr_id
	,p8_special_offer
	,p9
	,p10
	,src_area_nr
	,src_location_id AS src_loc_id
	,src_pallet_nr
	,tgt_area_nr
	,tgt_location_id AS tgt_loc_id
	,tgt_pallet_nr
	,computer_id AS comp_id
	,delivery_dt AS deliv_dt
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM DATA.t_lpv_tabakt_1
;

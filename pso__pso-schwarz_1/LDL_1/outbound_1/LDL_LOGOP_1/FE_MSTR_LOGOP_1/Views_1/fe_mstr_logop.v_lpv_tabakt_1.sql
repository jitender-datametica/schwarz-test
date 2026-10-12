/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_lpv_tabakt_1
Description		|	LPV - prepared view on source table
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_tabakt_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_ctry
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), wh_id
OPTIONS(description='Warehouse number (datastore_data:lagernummer). Foreign key: Referencing LPV.LAGER.LAGERNR'),
src_sys OPTIONS(description='Source system'), op_id OPTIONS(description='Surrogate key'), op_ts
OPTIONS(description='Time stamp in format "YYYYMMDDHH24MiSS"'), op_dt
OPTIONS(description='Operation date from timestamp'), op_tm OPTIONS(description='Operation time from timestamp'),
op_type OPTIONS(description='Operation type'), user_id
OPTIONS(description='User ID of the executing user. Foreign key: Referencing LPV.PERSONAL.PERSNR'), article_nr
OPTIONS(description='Article number. Foreign key: References LPV.AST.ANR'), src_qty
OPTIONS(description='Quantity (cf. explantion for table LPV.BESTAND in order to correctly interpret this number)'),
tgt_qty OPTIONS(description='Target quantity'), stock_id
OPTIONS(description='Stock ID. Foreign key: References LPV.BESTAND.BESTANDID'), gr_id
OPTIONS(description='LPV-internal number of the goods receipt'), batch OPTIONS(description='Batch'), p1_egin_task_id
OPTIONS(description='eGIN task ID'), p2_gr_position OPTIONS(description='Position at the gate during counting'),
p3_gr_priority OPTIONS(description='Priority'), p4_pallet_factor OPTIONS(description='Pallet factor'), p5_best_before_dt
OPTIONS(description='Best before date in Format "YYYYMMDD"'), p6_filling_year
OPTIONS(description='Filling year in Format "YYYY". May be empty for most articles.'), p7_gr_id
OPTIONS(description='GR ID'), p8_special_offer OPTIONS(description='Special offers indicator (German: Aktionsware)'), p9
OPTIONS(description='Not used in LPV 8'), p10 OPTIONS(description='Not used in LPV 8'), src_area_nr
OPTIONS(description='Source area. Foreign key: Referencing LPV.BEREICH.NR'), src_loc_id
OPTIONS(description='Source location_1 ID. Foreign key: Referencing LPV.WHX.ORT'), src_pallet_nr
OPTIONS(description='Number of the pallet on which the stock is located. Foreign key: References LPV.LHM.LHMNR'),
tgt_area_nr OPTIONS(description='Target area. Foreign key: Referencing LPV.BEREICH.NR'), tgt_loc_id
OPTIONS(description='Target location_1 ID, may be empty. Foreign key: Referencing LPV.WHX.ORT'), tgt_pallet_nr
OPTIONS(description='Target pallet number. Foreign key: References LPV.LHM.LHMNR'), comp_id
OPTIONS(description='Computer that initiated the goods movement. Foreign key: References LPV.RECHNER.RECHNERID'),
deliv_dt OPTIONS(description='Delivery date'), dwh_load_id OPTIONS(description='Load id'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from
OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `LPV - PREPARED VIEW ON BASE TABLE (PK CLIENT_ID, WH_NR, OP_ID, DWH_VALID_FROM)`) AS SELECT
 client_id,
 lidl_country AS lidl_ctry,
 wh_id,
 source_system AS src_sys,
 operation_id AS op_id,
 operation_tmsp AS op_ts,
 DATE(operation_tmsp) AS op_dt,
 TIME(operation_tmsp) AS op_tm,
 operation_type AS op_type,
 user_id,
 article_nr,
 src_qty,
 tgt_qty,
 stock_id,
 gr_id,
 batch,
 p1_egin_task_id,
 p2_gr_position,
 p3_gr_priority,
 p4_pallet_factor,
 p5_best_before_dt,
 p6_filling_year,
 p7_gr_id,
 p8_special_offer,
 p9,
 p10,
 src_area_nr,
 src_location_id AS src_loc_id,
 src_pallet_nr,
 tgt_area_nr,
 tgt_location_id AS tgt_loc_id,
 tgt_pallet_nr,
 computer_id AS comp_id,
 delivery_dt AS deliv_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_lpv_tabakt_1;
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_SUBTOTAL_EXTRACT
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  27.07.2023    Wandtke,Andrzej          AP0177530: add column timestamp_begin_ejr
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_SUBTOTAL_EXTRACT AS
   SELECT	
     sttl.store_id
	,sttl.client_id
	,sttl.pos_terminal_id
	,sttl.dat_formdate
	,sttl.time_receipt_ejr
	,sttl.orig_receipt_nr_ejr
	,sttl.orig_receipt_serial_nr_ejr
	,sttl.timezone_cd
	,sttl.dat_dayend
	,sttl.checker_id
	,sttl.transactiontype_id
	,sttl.authority_id
	,sttl.load_id
	,sttl.timestamp_begin_ejr
   FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_subtotal sttl	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk sst	
   ON sttl.client_id = sst.client_id	
   AND sttl.store_id = sst.store_id	
   AND sttl.dat_formdate BETWEEN sst.dat_formdate_from AND sst.dat_formdate_until	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk revday	
   ON sttl.dat_formdate = revday.dat_calendar	
;
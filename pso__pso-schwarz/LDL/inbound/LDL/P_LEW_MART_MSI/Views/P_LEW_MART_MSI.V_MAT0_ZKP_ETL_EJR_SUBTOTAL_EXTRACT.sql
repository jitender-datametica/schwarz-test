/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT0_ZKP_ETL_EJR_SUBTOTAL_EXTRACT
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  27.07.2023    Wandtke,Andrzej          AP0177530: add column timestamp_begin_ejr
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_ZKP_ETL_EJR_SUBTOTAL_EXTRACT AS
   SELECT	
      st_loc_sid AS store_id
	 ,client_id
	 ,pos_terminal_id
	 ,dat_formdate
	 ,time_receipt_ejr
	 ,orig_receipt_nr_ejr
	 ,orig_receipt_serial_nr_ejr
	 ,timezone_cd
	 ,dat_dayend
	 ,checker_id
	 ,transactiontype_id
	 ,authority_id
	 ,load_id
	 ,timestamp_begin_ejr
   FROM p_lew_mart_msi.t_msi_ejr_subtotal_extract	
;
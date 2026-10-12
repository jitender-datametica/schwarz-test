/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_log_1
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_1 mit V_WAREHOUSE_1 ersetzt
#  1.3  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_ZKP_ETL_SYS_REVISION_LOG_1 as
   SELECT	
   a.client_id,	
   wh.src_wh_id AS wh_id,	
   a.orig_store_nr,	
   a.requesting_user,	
   a.timestamp_request,	
   a.approval_user,	
   a.approval_fg,	
   a.timestamp_approval,	
   a.dat_formdate_from,	
   a.dat_formdate_until,	
   a.void_fg,	
   a.deposit_fg,	
   a.return_fg,	
   a.aborted_suspended_fg,	
   a.discount_fg,
   a.other_fg,	
   a.timestamp_start,	
   a.timestamp_end,	
   a.delete_fg,	
   a.timestamp_delete,	
   a.revision_test_fg,	
   a.revision_fg,	
   a.revision_user,	
   a.timestamp_revision_start,	
   a.revision_reason_cd	
   FROM p_lew_mart_msi.t_msi_sys_revision_log_1 a	
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh	
   ON a.client_id = wh.client_id	
   AND a.wh_loc_sid = wh.loc_sid_wh	
   AND wh.dwh_actual_fg = 1	
;
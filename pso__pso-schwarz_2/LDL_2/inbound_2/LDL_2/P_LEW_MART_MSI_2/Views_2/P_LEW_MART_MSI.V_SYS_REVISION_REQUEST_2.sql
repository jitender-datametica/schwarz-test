/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for x_lew_mart_msi.v_sys_revision_request_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  10.01.2018    Michael Ueding           Lkp Key Map fuer wh_id
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  30.10.2018    Arnold,Arne              V_LOC_MAP_KEY_2 mit V_WAREHOUSE_2 ersetzt
#  1.5  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SYS_REVISION_REQUEST_2	
(	
   client_id	
  ,wh_id	
  ,orig_store_nr	
  ,requesting_user	
  ,timestamp_request	
  ,approval_user	
  ,approval_fg	
  ,timestamp_approval	
  ,dat_formdate_from	
  ,dat_formdate_until	
  ,void_fg	
  ,deposit_fg	
  ,return_fg	
  ,aborted_suspended_fg	
  ,discount_fg
  ,other_fg	
  ,revision_test_fg	
)	
AS	
   SELECT	
      ow.client_id
   ,wh.src_wh_id AS wh_id
   ,ow.orig_store_nr	
   ,ow.requesting_user	
   ,ow.timestamp_request	
   ,ow.approval_user	
   ,ow.approval_fg
   ,ow.timestamp_approval	
   ,ow.dat_formdate_from	
   ,ow.dat_formdate_until	
   ,ow.void_fg
   ,ow.deposit_fg	
   ,ow.return_fg	
   ,ow.aborted_suspended_fg	
   ,ow.discount_fg
   ,ow.other_fg	
   ,ow.revision_test_fg	
   FROM p_lew_mart_msi.t_msi_sys_revision_request_2 ow	
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh	
   ON wh.client_id = ow.client_id	
   AND wh.loc_sid_wh = ow.wh_loc_sid	
   AND wh.dwh_actual_fg = 1	
;
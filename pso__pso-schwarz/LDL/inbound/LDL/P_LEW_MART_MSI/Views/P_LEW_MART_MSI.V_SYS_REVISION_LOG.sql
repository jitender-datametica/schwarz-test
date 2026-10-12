/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_sys_revision_log
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.2  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.3  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.6  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.7  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.8  25.04.2018    Wieber.Harald            Update Release 3.5
#  1.9  03.05.2018    Wieber.Harald            Release 3.6
# 1.10  17.05.2018    Wieber,Harald            Update Release 3.8
# 1.11  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SYS_REVISION_LOG	
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
  ,timestamp_start	
  ,timestamp_end	
  ,delete_fg	
  ,timestamp_delete	
  ,revision_test_fg	
  ,revision_fg	
  ,revision_user	
  ,timestamp_revision_start	
  ,revision_reason_cd	
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
   ,ow.timestamp_start	
   ,ow.timestamp_end	
   ,ow.delete_fg	
   ,ow.timestamp_delete	
   ,ow.revision_test_fg	
   ,ow.revision_fg
   ,ow.revision_user
   ,ow.timestamp_revision_start	
   ,ow.revision_reason_cd	
   FROM p_lew_mart_msi.t_msi_sys_revision_log AS ow	
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh	
   ON wh.client_id = ow.client_id	
   AND wh.loc_sid_wh = ow.wh_loc_sid	
   AND wh.dwh_actual_fg = 1	
;
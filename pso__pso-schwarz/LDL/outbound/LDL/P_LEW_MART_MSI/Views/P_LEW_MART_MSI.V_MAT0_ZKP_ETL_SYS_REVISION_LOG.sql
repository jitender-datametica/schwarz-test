/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_log
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY mit V_WAREHOUSE ersetzt
#  1.3  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_log AS SELECT A.client_id,
 WH.src_wh_id AS wh_id,
 A.orig_store_nr,
 A.requesting_user,
 A.timestamp_request,
 A.approval_user,
 A.approval_fg,
 A.timestamp_approval,
 A.dat_formdate_from,
 A.dat_formdate_until,
 A.void_fg,
 A.deposit_fg,
 A.return_fg,
 A.aborted_suspended_fg,
 A.discount_fg,
 A.other_fg,
 A.timestamp_start,
 A.timestamp_end,
 A.delete_fg,
 A.timestamp_delete,
 A.revision_test_fg,
 A.revision_fg,
 A.revision_user,
 A.timestamp_revision_start,
 A.revision_reason_cd
FROM ldl_p_lew_mart_msi.t_msi_sys_revision_log AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON A.client_id = WH.client_id AND A.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1;
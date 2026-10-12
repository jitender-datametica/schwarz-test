/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for x_lew_mart_msi.v_sys_revision_request
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  10.01.2018    Michael Ueding           Lkp Key Map fuer wh_id
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  30.10.2018    Arnold,Arne              V_LOC_MAP_KEY mit V_WAREHOUSE ersetzt
#  1.5  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sys_revision_request (client_id, wh_id, orig_store_nr, requesting_user,
timestamp_request, approval_user, approval_fg, timestamp_approval, dat_formdate_from, dat_formdate_until, void_fg,
deposit_fg, return_fg, aborted_suspended_fg, discount_fg, other_fg, revision_test_fg) AS SELECT OW.client_id,
 WH.src_wh_id AS wh_id,
 OW.orig_store_nr,
 OW.requesting_user,
 OW.timestamp_request,
 OW.approval_user,
 OW.approval_fg,
 OW.timestamp_approval,
 OW.dat_formdate_from,
 OW.dat_formdate_until,
 OW.void_fg,
 OW.deposit_fg,
 OW.return_fg,
 OW.aborted_suspended_fg,
 OW.discount_fg,
 OW.other_fg,
 OW.revision_test_fg
FROM ldl_p_lew_mart_msi.t_msi_sys_revision_request AS OW
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON OW.client_id = WH.client_id AND OW.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1;
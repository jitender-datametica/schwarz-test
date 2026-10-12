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


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sys_revision_log (client_id, wh_id, orig_store_nr, requesting_user,
timestamp_request, approval_user, approval_fg, timestamp_approval, dat_formdate_from, dat_formdate_until, void_fg,
deposit_fg, return_fg, aborted_suspended_fg, discount_fg, other_fg, timestamp_start, timestamp_end, delete_fg,
timestamp_delete, revision_test_fg, revision_fg, revision_user, timestamp_revision_start, revision_reason_cd) AS SELECT
 OW.client_id,
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
 OW.timestamp_start,
 OW.timestamp_end,
 OW.delete_fg,
 OW.timestamp_delete,
 OW.revision_test_fg,
 OW.revision_fg,
 OW.revision_user,
 OW.timestamp_revision_start,
 OW.revision_reason_cd
FROM ldl_p_lew_mart_msi.t_msi_sys_revision_log AS OW
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON OW.client_id = WH.client_id AND OW.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1;
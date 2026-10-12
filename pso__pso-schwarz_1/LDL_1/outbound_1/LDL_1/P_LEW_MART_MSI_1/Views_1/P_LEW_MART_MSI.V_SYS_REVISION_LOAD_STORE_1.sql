/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_msi.v_sys_revision_load_store_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  06.11.2017    Toth,Gabriel             View angepasst
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  10.01.2018    Michael Ueding           Lkp Key Map fuer wh_id
#  1.4  11.01.2018    Michael Ueding           CROSS JOIN korrigiert.
#  1.5  17.01.2018    Wieber,Harald            Release 2.2
#  1.6  30.10.2018    Arnold,Arne              V_LOC_MAP_KEY_1 mit V_WAREHOUSE_1 ersetzt
#  1.7  30.10.2018    Arnold,Arne              V_LOC_MAP_KEY_1 mit V_WAREHOUSE_1 ersetzt
#  1.8  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sys_revision_load_store_1 (client_id, wh_id, store_id, orig_store_nr,
dat_formdate_from, dat_formdate_until, load_in_progress_fg, void_fg, deposit_fg, return_fg, aborted_suspended_fg,
discount_fg, other_fg, store_load_fg, materialize_id, revision_test_fg, revision_fg, revision_user, revision_reason_cd)
AS -- Anpassung für Snowflake
 -- Auflösung WH
 SELECT REVSTR.client_id,
 WH.src_wh_id AS wh_id,
 REVSTR.st_loc_sid AS store_id,
 REVSTR.orig_store_nr,
 REVSTR.dat_formdate_from,
 REVSTR.dat_formdate_until,
 REVSTR.load_in_progress_fg,
 REVLOG.void_fg,
 REVLOG.deposit_fg,
 REVLOG.return_fg,
 REVLOG.aborted_suspended_fg,
 REVLOG.discount_fg,
 REVLOG.other_fg,
  CASE
  WHEN REVLOG.orig_store_nr IS NULL
  THEN 0
  ELSE 1
  END AS store_load_fg,
  FORMAT_DATE('%Y%m%d', REVSTR.dat_formdate_from) || FORMAT_DATE('%Y%m%d', REVSTR.dat_formdate_until) AS materialize_id
 ,
 REVLOG.revision_test_fg,
 REVLOG.revision_fg,
 REVLOG.revision_user,
 REVLOG.revision_reason_cd
FROM ldl_p_lew_mart_msi.t_msi_sys_revision_load_store_1 AS REVSTR
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON REVSTR.client_id = WH.client_id AND REVSTR.wh_loc_sid = WH.loc_sid_wh
  AND WH.dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_mart_msi.v_sys_revision_log_1 AS REVLOG ON REVSTR.client_id = REVLOG.client_id AND WH.src_wh_id =
    REVLOG.wh_id AND (REVLOG.orig_store_nr IS NULL OR REVSTR.orig_store_nr = REVLOG.orig_store_nr)
WHERE REVLOG.timestamp_delete IS NULL;
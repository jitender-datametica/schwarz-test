/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_msi.v_sys_revision_load_store
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  06.11.2017    Toth,Gabriel             View angepasst
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  10.01.2018    Michael Ueding           Lkp Key Map fuer wh_id
#  1.4  11.01.2018    Michael Ueding           Join korrigiert.
#  1.5  17.01.2018    Wieber,Harald            Release 2.2
#  1.6  30.10.2018    Arnold,Arne              V_LOC_MAP_KEY mit V_WAREHOUSE ersetzt
#  1.7  30.10.2018    Arnold,Arne              V_LOC_MAP_KEY mit V_WAREHOUSE ersetzt
#  1.8  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SYS_REVISION_LOAD_STORE
(
   client_id
  ,wh_id
  ,store_id
  ,orig_store_nr
  ,dat_formdate_from
  ,dat_formdate_until
  ,load_in_progress_fg
  ,void_fg
  ,deposit_fg
  ,return_fg
  ,aborted_suspended_fg
  ,discount_fg
  ,other_fg
  ,store_load_fg
  ,materialize_id
  ,revision_test_fg
  ,revision_fg
  ,revision_user
  ,revision_reason_cd
)
AS
SELECT
revstr.client_id
,wh.src_wh_id AS wh_id
,revstr.st_loc_sid AS store_id
,revstr.orig_store_nr
,revstr.dat_formdate_from
,revstr.dat_formdate_until
,revstr.load_in_progress_fg
,revlog.void_fg
,revlog.deposit_fg
,revlog.return_fg
,revlog.aborted_suspended_fg
,revlog.discount_fg
,revlog.other_fg
,CASE WHEN revlog.orig_store_nr IS NULL THEN 0 ELSE 1 END AS store_load_fg
-- Anpassung für Snowflake
,to_varchar(revstr.dat_formdate_from, 'YYYYMMDD') || to_varchar(revstr.dat_formdate_until,'YYYYMMDD') AS materialize_id
,revlog.revision_test_fg
,revlog.revision_fg
,revlog.revision_user
,revlog.revision_reason_cd
FROM p_lew_mart_msi.t_msi_sys_revision_load_store revstr
-- Auflösung WH
INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON wh.client_id = revstr.client_id
  AND wh.loc_sid_wh = revstr.wh_loc_sid
  AND wh.dwh_actual_fg = 1

INNER JOIN p_lew_mart_msi.v_sys_revision_log revlog
ON revstr.client_id = revlog.client_id
  AND wh.src_wh_id = revlog.wh_id
  AND
  (
    revstr.orig_store_nr = revlog.orig_store_nr
    OR revlog.orig_store_nr IS NULL
  )

WHERE revlog.timestamp_delete IS NULL
;




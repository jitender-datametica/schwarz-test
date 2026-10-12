/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_itm_item_foodatcion_aswas.
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  02.08.2021    Bachmann, Torsten        Init, Materialize view
#                                              Similar logic like in lew_bil.v_item_foodaction_hist_1
#                                              REP3-9070, PatchNo 2899
#  1.1  06.10.2021    Bachmann, Torsten        Change logic how to differentiate between ELWIS and WAWI and when to take which information
#                                              PatchNo: 2949, REP3-9444, INC3542030
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ITM_ITEM_FOODACTION_ASWAS_1 AS
/*
#------------------------------------------------------------------------------------------------------
#  Please keep in mind to keep same logic also in view #X_LEW_BIL#.v_item_foodaction_hist_1
#------------------------------------------------------------------------------------------------------
*/

SELECT
  z.client_id                /* Land_1 */ 
, z.item_sid   AS item_id   /* Artikel_1 */
, cal.cal_dt   AS dat_valid /* Gueltigkeitsdatum */ 
FROM
(
  SELECT
    client_id
  , item_sid
  , MIN(y.starti)+1 AS dwh_valid_from
  , MAX(y.endi)     AS dwh_valid_to
  FROM (
    SELECT 
    x.client_id
  , x.item_sid
  , x.starti
  , x.endi
  , x.GroupStartFlag
  , SUM(GroupStartFlag) OVER (PARTITION BY x.client_id, x.item_sid ORDER BY x.starti, x.endi ROWS UNBOUNDED PRECEDING) AS GroupID
    FROM
    (
      SELECT
        a.client_id
      , a.item_sid
      , GREATEST((a.dwh_valid_from),(b.dwh_valid_from),(c.dwh_valid_from),(li.dwh_valid_from))-1                         AS starti
      , LEAST((a.dwh_valid_to),(b.dwh_valid_to),(c.dwh_valid_to ),(li.dwh_valid_to))                                     AS endi
      , CASE WHEN starti <= LAG(endi) OVER(PARTITION BY a.client_id, a.item_sid ORDER BY starti, endi) THEN 0 ELSE 1 END AS GroupStartFlag
      FROM P_LEW_CORE_AC.v_item_hist_1 a
      INNER JOIN P_LEW_CORE_AC.v_item_familygroup_hist_1 AS b
        ON b.client_id = a.client_id
        AND b.item_fam_grp_sid = a.item_fam_grp_sid
        AND b.dwh_valid_from <= a.dwh_valid_to
        AND b.dwh_valid_to >= a.dwh_valid_from
        AND b.deleted_fg = 0
      INNER JOIN P_LEW_CORE_AC.v_subitemgroup_hist_1 AS c
        ON c.client_id = b.client_id
        AND c.sub_item_grp_sid = b.sub_item_grp_sid
        AND c.dwh_valid_from <= b.dwh_valid_to
        AND c.dwh_valid_to >= b.dwh_valid_from
        AND c.deleted_fg = 0
      INNER JOIN P_LEW_CORE_AC.v_itemgroup_international_1 AS d
        ON d.client_id = c.client_id
        AND d.item_grp_int_sid = c.item_grp_int_sid
        AND d.src_itemgrp_int_cd NOT IN(1,7,10,70)
      INNER JOIN (SELECT client_id
                       , item_sid
                       , dwh_valid_from
                       , dwh_valid_to
                       , list_type_mark
                       , COUNT(*) AS cnt_itm
                    FROM P_LEW_CORE_AC.v_item_listing_type_hist_1
                   WHERE deleted_fg = 0
                   GROUP BY client_id
                       , item_sid
                       , dwh_valid_from
                       , dwh_valid_to
                       , list_type_mark
                  QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id , item_sid, dwh_valid_to
                  /* because ordering was not deterministic, dwh_valid_from was added to get the oldest one and list_type_mark*/
                                                 ORDER BY cnt_itm DESC, dwh_valid_from, list_type_mark) = 1) AS li
        ON li.client_id = a.client_id
        AND li.item_sid = a.item_sid
        AND li.list_type_mark = 'A'
        AND li.dwh_valid_from <= a.dwh_valid_to
        AND li.dwh_valid_to >= a.dwh_valid_from
      WHERE starti < endi
    ) AS x
  ) AS y
  GROUP BY y.client_id,y.item_sid, y.GroupID
) z
INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1 cal
  ON cal.cal_dt BETWEEN z.dwh_valid_from AND z.dwh_valid_to
  AND cal.cal_dt      <= CURRENT_DATE
  AND cal.busyear_seq >= -3
/* get only data for timeperiod when country_1 was an elwis country_1 */
INNER JOIN P_LEW_CORE_AC.v_client_migration_per_1 mig
   ON z.client_id = mig.client_id
WHERE cal.cal_dt BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to

UNION ALL

SELECT
  fa.client_id
, fa.item_sid
, fa.dat_valid
FROM P_LEW_CORE_AC.v_wawi_itm_item_foodaction_asws_act_1  fa
INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1 cal
   ON cal.cal_dt       = fa.dat_valid
  AND cal.cal_dt      <= CURRENT_DATE
  AND cal.busyear_seq >= -3
/* get only data for timeperiod when country_1 was NOT an elwis country_1 (WAWI time period) */
INNER JOIN P_LEW_CORE_AC.v_client_migration_per_1 mig
   ON fa.client_id = mig.client_id
WHERE fa.dat_valid NOT BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to
;

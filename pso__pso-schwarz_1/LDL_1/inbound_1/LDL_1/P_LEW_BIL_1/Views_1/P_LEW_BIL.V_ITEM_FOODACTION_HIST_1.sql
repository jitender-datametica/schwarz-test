/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_item_foodaction_hist.
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  2.0  02.11.2017    -                        Martin Murtenthaler Split des UNION ALLs
#  2.1  03.11.2017    -                        Martin Murtenthaler Fehlerkorrektur
#  2.2  15.11.2017    Wieber,Harald            Release 1.1
#  2.3  16.11.2017    Wieber,Harald            Relese 1.1 v2
#  2.4  16.11.2017    Martin Murtenthaler WAWI-Zweig für ELWIS stillgelegt t t t t t
#  2,5  20.11.2017    Wieber,Harald            Set CommentString to max length 255
#  2,6  20.11.2017    Wieber,Harald            Set CommentString to max length 255
#  2,7  20.11.2017    Wieber,Harald            Set CommentString to max length 255 (Fix 3)
#  2,8  20.11.2017    Wieber,Harald            Correct SVN File
#  2,9  06.12.2017    Martin Murtenthaler      t_item_hist_1 - take also deleted ones
#  3.0  09.04.2018    Martin Murtenthaler      different criteria for seperating WAWI from SAP
#  3.1  12.10.2020    Artur Chudyka            delete joins for PINFO sources (not needed anymore - requested in e-mail from 09.10.2020 by Lucas Kaiser)
#  3.2  17.11.2020    Rodrigo Cione            Subselect added in the join with v_item_listing_type_hist_1 to avoid sortiments that are not foodaction
#  3.2  24.03.2021    Aleksander Bialek        WGI's (10,70) addded to the condition (needed for this to work with both old a new WGI id's)
#  3.3  06.10.2021    Torsten Bachmann         Change logic how to differentiate between ELWIS and WAWI and when to take which information
#                                              PatchNo: 2949, REP3-9444, INC3542030
#----------------------------------------------------------------------------
*/

/*
#------------------------------------------------------------------------------------------------------
#  Please keep in mind to keep same logic also in view #X_LEW_MART_MSI#.v_mat_itm_item_foodaction_aswas_1
#------------------------------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_FOODACTION_HIST_1
COMMENT = '$Revision: 17430 $ '

AS

SELECT
  z.client_id
, z.item_sid
, GREATEST (z.valid_from, mig.migration_dat_valid_from)   AS dwh_valid_from
, LEAST (z.valid_to, mig.migration_dat_valid_to)          AS dwh_valid_to
FROM
(
  SELECT
    y.client_id
  , y.item_sid
  , MIN(y.starti)+1      AS valid_from
  , MAX(y.endi)          AS valid_to
  FROM (
    SELECT 
    x.client_id
  , x.item_sid
  , x.starti
  , x.endi
  , x.GroupStartFlag
  , SUM(GroupStartFlag) OVER (PARTITION BY x.client_id, x.item_sid ORDER BY x.starti ROWS UNBOUNDED PRECEDING) AS GroupID
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
) AS z
 INNER JOIN P_LEW_CORE_AC.v_client_migration_per_1 mig
  ON z.client_id = mig.client_id
WHERE dwh_valid_from <= dwh_valid_to

UNION ALL

SELECT
  wawi.client_id
, wawi.item_sid
, wawi.dat_valid AS dwh_valid_from
, wawi.dat_valid AS dwh_valid_to
FROM P_LEW_CORE_AC.v_wawi_itm_item_foodaction_asws_act_1 wawi
 INNER JOIN P_LEW_CORE_AC.v_client_migration_per_1 mig
  ON wawi.client_id = mig.client_id
WHERE wawi.dat_valid NOT BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to
;



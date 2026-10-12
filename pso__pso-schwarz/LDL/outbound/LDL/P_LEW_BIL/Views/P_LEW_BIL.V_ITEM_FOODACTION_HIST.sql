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
#  2,9  06.12.2017    Martin Murtenthaler      t_item_hist - take also deleted ones
#  3.0  09.04.2018    Martin Murtenthaler      different criteria for seperating WAWI from SAP
#  3.1  12.10.2020    Artur Chudyka            delete joins for PINFO sources (not needed anymore - requested in e-mail from 09.10.2020 by Lucas Kaiser)
#  3.2  17.11.2020    Rodrigo Cione            Subselect added in the CROSS JOIN with v_item_listing_type_hist to avoid sortiments that are not foodaction
#  3.2  24.03.2021    Aleksander Bialek        WGI's (10,70) addded to the condition (needed for this to work with both old a new WGI id's)
#  3.3  06.10.2021    Torsten Bachmann         Change logic how to differentiate between ELWIS and WAWI and when to take which information
#                                              PatchNo: 2949, REP3-9444, INC3542030
#----------------------------------------------------------------------------
*/

/*
#------------------------------------------------------------------------------------------------------
#  Please keep in mind to keep same logic also in view #X_LEW_MART_MSI#.v_mat_itm_item_foodaction_aswas
#------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_foodaction_hist OPTIONS(DESCRIPTION = `$Revision: 17430 $ `) AS SELECT z
 .client_id,
 z.item_sid,
 GREATEST(z.valid_from, MIG.migration_dat_valid_from) AS dwh_valid_from,
 LEAST(z.valid_to, MIG.migration_dat_valid_to) AS dwh_valid_to
FROM (SELECT client_id,
   item_sid,
   DATE_ADD(MIN(starti), INTERVAL 1 DAY) AS valid_from,
   MAX(endi) AS valid_to
  FROM (SELECT client_id,
     item_sid,
     SUM(groupstartflag) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING) ORDER BY starti IS NULL
        , starti ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS groupid,
     starti,
     endi
    FROM (SELECT A.client_id,
       A.item_sid,
       DATE_SUB(GREATEST(A.dwh_valid_from, B.dwh_valid_from, C.dwh_valid_from, li.dwh_valid_from), INTERVAL 1 DAY) AS
       starti,
       LEAST(A.dwh_valid_to, B.dwh_valid_to, C.dwh_valid_to, li.dwh_valid_to) AS endi,
        CASE
        WHEN DATE_SUB(GREATEST(A.dwh_valid_from, B.dwh_valid_from, C.dwh_valid_from, li.dwh_valid_from), INTERVAL 1 DAY
          ) <= (LAG(LEAST(A.dwh_valid_to, B.dwh_valid_to, C.dwh_valid_to, li.dwh_valid_to)) OVER (PARTITION BY CAST(A.client_id AS STRING)
             , CAST(A.item_sid AS STRING) ORDER BY DATE_SUB(GREATEST(A.dwh_valid_from, B.dwh_valid_from, C.dwh_valid_from
               , li.dwh_valid_from), INTERVAL 1 DAY) IS NULL, DATE_SUB(GREATEST(A.dwh_valid_from, B.dwh_valid_from, C.dwh_valid_from
               , li.dwh_valid_from), INTERVAL 1 DAY), LEAST(A.dwh_valid_to, B.dwh_valid_to, C.dwh_valid_to, li.dwh_valid_to
              ) IS NULL, LEAST(A.dwh_valid_to, B.dwh_valid_to, C.dwh_valid_to, li.dwh_valid_to)))
        THEN 0
        ELSE 1
        END AS groupstartflag
      FROM ldl_p_lew_core_ac.v_item_hist AS A
       INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS B ON A.client_id = B.client_id AND A.item_fam_grp_sid = B
            .item_fam_grp_sid AND A.dwh_valid_to >= B.dwh_valid_from AND A.dwh_valid_from <= B.dwh_valid_to AND B.deleted_fg
          = 0
       INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist AS C ON B.client_id = C.client_id AND B.sub_item_grp_sid = C.sub_item_grp_sid
             AND B.dwh_valid_to >= C.dwh_valid_from AND B.dwh_valid_from <= C.dwh_valid_to AND C.deleted_fg = 0
       INNER JOIN ldl_p_lew_core_ac.v_itemgroup_international AS D ON C.client_id = D.client_id AND C.item_grp_int_sid =
          D.item_grp_int_sid AND CAST(D.src_itemgrp_int_cd AS INTEGER) NOT IN (1, 7, 10, 70)
       INNER JOIN (SELECT client_id,
         item_sid,
         dwh_valid_from,
         dwh_valid_to,
         list_type_mark,
         COUNT(*) AS cnt_itm
        FROM ldl_p_lew_core_ac.v_item_listing_type_hist
        WHERE deleted_fg = 0
        GROUP BY client_id,
         item_sid,
         list_type_mark,
         dwh_valid_from,
         dwh_valid_to
        QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING), dwh_valid_to
            ORDER BY cnt_itm IS NULL DESC, cnt_itm DESC, dwh_valid_from IS NULL, dwh_valid_from, list_type_mark IS NULL
              , list_type_mark)) = 1) AS li ON A.client_id = li.client_id AND A.item_sid = li.item_sid AND li.list_type_mark
            = 'A' AND A.dwh_valid_to >= li.dwh_valid_from AND A.dwh_valid_from <= li.dwh_valid_to
      WHERE DATE_SUB(GREATEST(A.dwh_valid_from, B.dwh_valid_from, C.dwh_valid_from, li.dwh_valid_from), INTERVAL 1 DAY)
        < LEAST(A.dwh_valid_to, B.dwh_valid_to, C.dwh_valid_to, li.dwh_valid_to)) AS x) AS y
  GROUP BY client_id,
   item_sid,
   groupid) AS z
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON z.client_id = MIG.client_id
WHERE GREATEST(z.valid_from, MIG.migration_dat_valid_from) <= LEAST(z.valid_to, MIG.migration_dat_valid_to)
UNION ALL
SELECT WAWI.client_id,
 WAWI.item_sid,
 WAWI.dat_valid AS dwh_valid_from,
 WAWI.dat_valid AS dwh_valid_to
FROM ldl_p_lew_core_ac.v_wawi_itm_item_foodaction_asws_act AS WAWI
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON WAWI.client_id = MIG.client_id
WHERE WAWI.dat_valid NOT BETWEEN MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to;
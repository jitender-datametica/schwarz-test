/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_itm_item_foodatcion_aswas.
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  02.08.2021    Bachmann, Torsten        Init, Materialize view
#                                              Similar logic like in lew_bil.v_item_foodaction_hist
#                                              REP3-9070, PatchNo 2899
#  1.1  06.10.2021    Bachmann, Torsten        Change logic how to differentiate between ELWIS and WAWI and when to take which information
#                                              PatchNo: 2949, REP3-9444, INC3542030
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_itm_item_foodaction_aswas AS SELECT z.client_id,
 z.item_sid AS item_id,
 CAL.cal_dt AS dat_valid
FROM (SELECT client_id,
   item_sid,
   DATE_ADD(MIN(starti), INTERVAL 1 DAY) AS dwh_valid_from,
   MAX(endi) AS dwh_valid_to
  FROM (SELECT client_id,
     item_sid,
     SUM(groupstartflag) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING) ORDER BY starti IS NULL
        , starti, endi IS NULL, endi ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS groupid,
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
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON CAL.cal_dt BETWEEN z.dwh_valid_from AND z.dwh_valid_to AND CAL
    .cal_dt <= CURRENT_DATE AND CAL.busyear_seq >= - 3
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON z.client_id = MIG.client_id
WHERE CAL.cal_dt BETWEEN MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to
UNION ALL
SELECT FA.client_id,
 FA.item_sid,
 FA.dat_valid
FROM ldl_p_lew_core_ac.v_wawi_itm_item_foodaction_asws_act AS FA
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON FA.dat_valid = CAL.cal_dt AND CAL.cal_dt <= CURRENT_DATE AND
   CAL.busyear_seq >= - 3
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON FA.client_id = MIG.client_id
WHERE FA.dat_valid NOT BETWEEN MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to;
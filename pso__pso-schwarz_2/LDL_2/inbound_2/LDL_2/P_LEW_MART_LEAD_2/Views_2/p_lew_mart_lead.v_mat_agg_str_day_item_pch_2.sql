/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_mat_agg_str_day_item_pch.
#----------------------------------------------------------------------------
# History:
#  1.0  19.02.2020    Bachmann, Torsten           Initial
#  1.1  29.07.2020    Bachmann, Torsten           Replaced faked BNL data with new BNL table
#  1.2  18.08.2020    Bachmann, Torsten           Use switch-Table in CORE instead of LEAD
#  1.3  26.08.2020    Bachmann, Torsten           Adjust BNL calculation: credit - debit (instead of debit - credit)
#  1.4  16.08.2020    Bialek, Aleksander         Changed CORE->MART_LEAD layer for v_wh_pch_switch_2
#                                                 Added CASE STATEMENT for pch_bnl_switch_fg
#  1.5  30.03.2022    Bialek, Aleksander         Added ORDER BY clause to ensure best micro-partitions structure for reporting.
#  1.6  26.01.2023    Bialek, Aleksander         186 and 196 sfotype added (they should appear only wth pcwo_reason 42). ADO:429038, IT4YOU: SPEC0183988.
#  1.7  06.03.2023    Bialek, Aleksander         Filtering for UWG extended to include newly added UWGs, ADO: 448371, it4you:PRJ0015189 
#                                                (as was: tsig.src_subitemgrp_cd BETWEEN 100 AND 199 -> as is: tsig.src_subitemgrp_cd BETWEEN 100 AND 399)
#  1.8  21.03.2023    Cyganska, Malgorzata        Adding a new pcwo_reason_id = 45 within ADO-447579.
#  1.9  27.04.2023    Bachmann, Torsten          Extend history to last 3 business years
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MAT_AGG_STR_DAY_ITEM_PCH_2 COMMENT = 'mat-View for new PV reason aggregates'
AS 
/*
#DescStart#
#SubjectAreas#: PV reason
#DescEnd#
*/
SELECT
  client_id
, loc_sid_store
, item_sid
, pcwo_reason_id
, sfotype_id
, pch_bnl_switch_fg
, dwh_cal_dt
, val_price_change
, dwh_updated
FROM (

SELECT
  sfo.client_id
, sfo.loc_sid_store
, sfo.item_sid
, sfo.pcwo_reason_id
, sfo.sfotype_id
, (CASE WHEN COALESCE (tsc.switch_date, DATE '9999-12-31') >  sfo.booking_dat
        THEN 0
        ELSE 1
   END)                      AS pch_bnl_switch_fg
, sfo.booking_dat            AS dwh_cal_dt
, SUM(CASE WHEN sfo.sfotype_id IN (134,144,180,190,186,196)
             AND sfo.pcwo_reason_id IN (41,42,43,45)
            THEN sfo.sfo_total_rtl_rl_net_val
            WHEN sfo.sfotype_id IN (130, 131, 132, 133, 135, 138, 139, 140, 141, 142, 143, 145, 148, 149, 151, 161)
             AND COALESCE (tsc.switch_date, DATE '9999-12-31') >  sfo.booking_dat
            THEN sfo.val_pr_diff_net_sfo
            ELSE NULL
       END
     )                       AS val_price_change
, MAX(sfo.dwh_updated)       AS dwh_updated

FROM P_LEW_BIL_AC.v_agg_store_day_item_sfo_2 AS sfo

 INNER JOIN P_LEW_BIL_AC.v_org_store_merge_2 AS twh
    ON sfo.client_id                = twh.client_id
   AND sfo.loc_sid_store            = twh.loc_sid_store
   AND twh.aspect_id = 1

 INNER JOIN P_LEW_MART_LEAD_AC.v_org_all_store_merge_2 AS toas
    ON twh.aspect_id             = toas.aspect_id
   AND twh.client_id             = toas.client_id
   AND twh.loc_sid_store_move_to = toas.move_to_store_id

 LEFT OUTER JOIN P_LEW_MART_LEAD_AC.v_wh_pch_switch_2 AS tsc
    ON sfo.client_id = tsc.client_id
   AND toas.wh_id    = tsc.wh_id

 LEFT OUTER JOIN
 (
   SELECT
     titm.client_id
   , titm.item_sid
   , (CASE WHEN tsig.src_subitemgrp_cd BETWEEN 100 AND 399
              OR tsig.src_subitemgrp_cd IN (75, 76)
            THEN 1
            ELSE 0
       END) AS flg_subitemgroup

   FROM P_LEW_BIL_AC.v_item_2 AS titm

   LEFT OUTER JOIN P_LEW_BIL_AC.v_subitemgroup_2 AS tsig
     ON titm.client_id             = tsig.client_id
    AND titm.sub_item_grp_sid_asis = tsig.sub_item_grp_sid
   WHERE CURRENT_DATE BETWEEN titm.dwh_valid_from AND  titm.dwh_valid_to
 ) AS sort
    ON sfo.client_id = sort.client_id
   AND sfo.item_sid  = sort.item_sid
 
WHERE sfo.booking_dat >= (SELECT MIN(cal_dt)
                          FROM P_LEW_CORE_AC.v_cal_calendarday_2
                          WHERE busyear_seq = -3)
  AND sfo.sfotype_id IN (130, 131, 132, 133, 135, 138, 139, 140, 141, 142, 143, 145, 148, 149, 151, 161, 144, 134, 180, 190)
  AND NOT(sfo.sfotype_id IN (131, 141) AND sort.flg_subitemgroup = 1)
  /* to exclude NULLL values, same condition like in CASE statement */
  AND ( (sfo.sfotype_id IN (134,144,180,190) AND sfo.pcwo_reason_id IN (41,42,43,45))
       OR
        (sfo.sfotype_id IN (130, 131, 132, 133, 135, 138, 139, 140, 141, 142, 143, 145, 148, 149, 151, 161)
             AND COALESCE (tsc.switch_date, DATE '9999-12-31') >  sfo.booking_dat)
      )
  AND NOT(sfo.val_pr_diff_net_sfo = 0 AND sfo.sfo_total_rtl_rl_net_val = 0)
GROUP BY
  sfo.client_id
, sfo.loc_sid_store
, sfo.item_sid
, sfo.pcwo_reason_id
, sfo.sfotype_id
, (CASE WHEN COALESCE (tsc.switch_date, DATE '9999-12-31') >  sfo.booking_dat
        THEN 0
        ELSE 1
   END)
, sfo.booking_dat

UNION ALL

SELECT
  tdel.client_id
, tdel.loc_sid_store
, tdel.item_sid
, -99                           AS pcwo_reason_id
, -99                           AS sfotype_id
, 0                             AS pch_bnl_switch_fg
, tdel.dat_formdate
, SUM(tdel.val_pr_diff_net_del) AS val_pr_diff_net_bnl
, MAX(tdel.dwh_updated)         AS dwh_updated

FROM P_LEW_BIL_AC.v_agg_deliv_base_2 AS tdel

 INNER JOIN P_LEW_BIL_AC.v_org_store_merge_2 AS twh
    ON tdel.client_id               = twh.client_id
   AND tdel.loc_sid_store           = twh.loc_sid_store
   AND twh.aspect_id = 1

 INNER JOIN P_LEW_MART_LEAD_AC.v_org_all_store_merge_2 AS toas
    ON twh.aspect_id             = toas.aspect_id
   AND twh.client_id             = toas.client_id
   AND twh.loc_sid_store_move_to = toas.move_to_store_id

 LEFT OUTER JOIN P_LEW_MART_LEAD_AC.v_wh_pch_switch_2 AS tsc
    ON tdel.client_id = tsc.client_id
   AND toas.wh_id     = tsc.wh_id

WHERE tdel.dat_formdate >= (SELECT MIN(cal_dt)
                            FROM P_LEW_CORE_AC.v_cal_calendarday_2
                            WHERE busyear_seq = -3)
  AND tdel.dat_formdate < COALESCE (tsc.switch_date, DATE '9999-12-31')
  AND tdel.val_pr_diff_net_del <> 0
GROUP BY
  tdel.client_id
, tdel.loc_sid_store
, tdel.item_sid
, tdel.dat_formdate

UNION ALL

SELECT
  tbnl.client_id
, tbnl.loc_sid_store
, tbnl.item_sid
, -99                           AS pcwo_reason_id
, -99                           AS sfotype_id
, CASE WHEN tbnl.dwh_cal_dt >= COALESCE (tsc.switch_date, DATE '9999-12-31') THEN  1  ELSE 0 END AS pch_bnl_switch_fg
, tbnl.dwh_cal_dt
, SUM(tbnl.price_change_credit_net_val - tbnl.price_change_debit_net_val) AS val_pr_diff_net_bnl
, MAX(tbnl.dwh_updated)         AS dwh_updated

FROM P_LEW_CORE_AC.v_price_change_item_2 AS tbnl

 INNER JOIN P_LEW_BIL_AC.v_org_store_merge_2 AS twh
    ON tbnl.client_id               = twh.client_id
   AND tbnl.loc_sid_store           = twh.loc_sid_store
   AND twh.aspect_id = 1

 INNER JOIN P_LEW_MART_LEAD_AC.v_org_all_store_merge_2 AS toas
    ON twh.aspect_id             = toas.aspect_id
   AND twh.client_id             = toas.client_id
   AND twh.loc_sid_store_move_to = toas.move_to_store_id

 LEFT OUTER JOIN P_LEW_MART_LEAD_AC.v_wh_pch_switch_2 AS tsc
    ON tbnl.client_id  = tsc.client_id
   AND toas.wh_id      = tsc.wh_id

 WHERE tbnl.dwh_cal_dt >= (SELECT MIN(cal_dt)
                           FROM P_LEW_CORE_AC.v_cal_calendarday_2
                           WHERE busyear_seq = -3)
   AND tbnl.price_change_debit_net_val <> tbnl.price_change_credit_net_val

GROUP BY
  tbnl.client_id
, tbnl.loc_sid_store
, tbnl.item_sid
, CASE WHEN tbnl.dwh_cal_dt >= COALESCE (tsc.switch_date, DATE '9999-12-31') THEN  1  ELSE 0 END
, tbnl.dwh_cal_dt
) mat
ORDER BY 
  client_id
, dwh_cal_dt
, sfotype_id
, pcwo_reason_id
, item_sid
, loc_sid_store
;
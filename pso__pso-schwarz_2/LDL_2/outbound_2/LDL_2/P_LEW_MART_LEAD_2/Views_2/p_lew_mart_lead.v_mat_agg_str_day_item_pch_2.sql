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


/* #DescStart#
#SubjectAreas#: PV reason
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mat_agg_str_day_item_pch_2
OPTIONS(DESCRIPTION = `MAT-VIEW FOR NEW PV REASON AGGREGATES`) AS
/* to exclude NULLL values, same condition like in CASE statement */ SELECT *
FROM (SELECT SFO.client_id,
    SFO.loc_sid_store,
    SFO.item_sid,
    SFO.pcwo_reason_id,
    SFO.sfotype_id,
     CASE
     WHEN COALESCE(TSC.switch_date, DATE '9999-12-31') > SFO.booking_dat
     THEN 0
     ELSE 1
     END AS pch_bnl_switch_fg,
    SFO.booking_dat AS dwh_cal_dt,
    SUM(CASE
      WHEN SFO.sfotype_id IN (134, 144, 180, 190, 186, 196) AND SFO.pcwo_reason_id IN (41, 42, 43, 45)
      THEN SFO.sfo_total_rtl_rl_net_val
      WHEN SFO.sfotype_id IN (130, 131, 132, 133, 135, 138, 139, 140, 141, 142, 143, 145, 148, 149, 151, 161) AND
        COALESCE(TSC.switch_date, DATE '9999-12-31') > SFO.booking_dat
      THEN SFO.val_pr_diff_net_sfo
      ELSE NULL
      END) AS val_price_change,
    MAX(SFO.dwh_updated) AS dwh_updated
   FROM ldl_p_lew_bil_ac.v_agg_store_day_item_sfo_2 AS SFO
    INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_2 AS TWH ON SFO.client_id = TWH.client_id AND SFO.loc_sid_store = TWH.loc_sid_store
        AND TWH.aspect_id = 1
    INNER JOIN ldl_p_lew_mart_lead_ac.v_org_all_store_merge_2 AS TOAS ON TWH.aspect_id = TOAS.aspect_id AND TWH.client_id
       = TOAS.client_id AND TWH.loc_sid_store_move_to = TOAS.move_to_store_id
    LEFT JOIN ldl_p_lew_mart_lead_ac.v_wh_pch_switch_2 AS TSC ON SFO.client_id = TSC.client_id AND TOAS.wh_id = TSC.wh_id
    LEFT JOIN (SELECT TITM.client_id,
      TITM.item_sid,
       CASE
       WHEN CAST(TSIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399 OR CAST(TSIG.src_subitemgrp_cd AS INTEGER) IN (75
          , 76)
       THEN 1
       ELSE 0
       END AS flg_subitemgroup
     FROM ldl_p_lew_bil_ac.v_item_2 AS TITM
      LEFT JOIN ldl_p_lew_bil_ac.v_subitemgroup_2 AS TSIG ON TITM.client_id = TSIG.client_id AND TITM.sub_item_grp_sid_asis
         = TSIG.sub_item_grp_sid
     WHERE CURRENT_DATE BETWEEN TITM.dwh_valid_from AND TITM.dwh_valid_to) AS sort ON SFO.client_id = sort.client_id AND
      SFO.item_sid = sort.item_sid
   WHERE SFO.booking_dat >= (SELECT MIN(cal_dt)
      FROM ldl_p_lew_core_ac.v_cal_calendarday_2
      WHERE busyear_seq = - 3)
    AND SFO.sfotype_id IN (130, 131, 132, 133, 135, 138, 139, 140, 141, 142, 143, 145, 148, 149, 151, 161, 144, 134, 180
      , 190)
    AND (SFO.sfotype_id NOT IN (131, 141) OR sort.flg_subitemgroup <> 1)
    AND (SFO.sfotype_id IN (134, 144, 180, 190) AND SFO.pcwo_reason_id IN (41, 42, 43, 45) OR SFO.sfotype_id IN (130,
         131, 132, 133, 135, 138, 139, 140, 141, 142, 143, 145, 148, 149, 151, 161) AND COALESCE(TSC.switch_date,
         DATE '9999-12-31') > SFO.booking_dat)
    AND (SFO.val_pr_diff_net_sfo <> 0 OR SFO.sfo_total_rtl_rl_net_val <> 0)
   GROUP BY SFO.client_id,
    SFO.loc_sid_store,
    SFO.item_sid,
    SFO.pcwo_reason_id,
    SFO.sfotype_id,
    pch_bnl_switch_fg,
    dwh_cal_dt
   UNION ALL
   SELECT TDEL.client_id,
    TDEL.loc_sid_store,
    TDEL.item_sid,
    - 99 AS pcwo_reason_id,
    - 99 AS sfotype_id,
    0 AS pch_bnl_switch_fg,
    TDEL.dat_formdate,
    SUM(TDEL.val_pr_diff_net_del) AS val_pr_diff_net_bnl,
    MAX(TDEL.dwh_updated) AS dwh_updated
   FROM ldl_p_lew_bil_ac.v_agg_deliv_base_2 AS TDEL
    INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_2 AS TWH ON TDEL.client_id = TWH.client_id AND TDEL.loc_sid_store = TWH
       .loc_sid_store AND TWH.aspect_id = 1
    INNER JOIN ldl_p_lew_mart_lead_ac.v_org_all_store_merge_2 AS TOAS ON TWH.aspect_id = TOAS.aspect_id AND TWH.client_id
       = TOAS.client_id AND TWH.loc_sid_store_move_to = TOAS.move_to_store_id
    LEFT JOIN ldl_p_lew_mart_lead_ac.v_wh_pch_switch_2 AS TSC ON TDEL.client_id = TSC.client_id AND TOAS.wh_id = TSC.wh_id
      
   WHERE TDEL.dat_formdate >= (SELECT MIN(cal_dt)
      FROM ldl_p_lew_core_ac.v_cal_calendarday_2
      WHERE busyear_seq = - 3)
    AND TDEL.dat_formdate < COALESCE(TSC.switch_date, DATE '9999-12-31')
    AND TDEL.val_pr_diff_net_del <> 0
   GROUP BY TDEL.client_id,
    TDEL.item_sid,
    TDEL.dat_formdate,
    TDEL.loc_sid_store
   UNION ALL
   SELECT TBNL.client_id,
    TBNL.loc_sid_store,
    TBNL.item_sid,
    - 99 AS pcwo_reason_id,
    - 99 AS sfotype_id,
     CASE
     WHEN TBNL.dwh_cal_dt >= COALESCE(TSC.switch_date, DATE '9999-12-31')
     THEN 1
     ELSE 0
     END AS pch_bnl_switch_fg,
    TBNL.dwh_cal_dt,
    SUM(TBNL.price_change_credit_net_val - TBNL.price_change_debit_net_val) AS val_pr_diff_net_bnl,
    MAX(TBNL.dwh_updated) AS dwh_updated
   FROM ldl_p_lew_core_ac.v_price_change_item_2 AS TBNL
    INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_2 AS TWH ON TBNL.client_id = TWH.client_id AND TBNL.loc_sid_store = TWH
       .loc_sid_store AND TWH.aspect_id = 1
    INNER JOIN ldl_p_lew_mart_lead_ac.v_org_all_store_merge_2 AS TOAS ON TWH.aspect_id = TOAS.aspect_id AND TWH.client_id
       = TOAS.client_id AND TWH.loc_sid_store_move_to = TOAS.move_to_store_id
    LEFT JOIN ldl_p_lew_mart_lead_ac.v_wh_pch_switch_2 AS TSC ON TBNL.client_id = TSC.client_id AND TOAS.wh_id = TSC.wh_id
      
   WHERE TBNL.dwh_cal_dt >= (SELECT MIN(cal_dt)
      FROM ldl_p_lew_core_ac.v_cal_calendarday_2
      WHERE busyear_seq = - 3)
    AND TBNL.price_change_debit_net_val <> TBNL.price_change_credit_net_val
   GROUP BY TBNL.client_id,
    TBNL.loc_sid_store,
    TBNL.item_sid,
    pch_bnl_switch_fg,
    TBNL.dwh_cal_dt)
ORDER BY client_id NULLS LAST,
 dwh_cal_dt NULLS LAST,
 sfotype_id NULLS LAST,
 pcwo_reason_id NULLS LAST,
 item_sid NULLS LAST,
 loc_sid_store NULLS LAST;
/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Individual load SQL for loading of aggregate t_agg_prc_dvlp_wh_day_itm
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2022-09-14   Aleksander Bialek    Initial version, view delivering IST-VJ  values for components of price development metrics.
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_sell_prc_dvlp_str_day_itm_2 AS WITH SORT_CTE AS (SELECT A.client_id,
   A.item_sid,
   A.item_sid_map AS item_id,
   A2.src_familygrp_cd,
   A3.src_subitemgrp_cd AS subitemgroup_id,
   COALESCE(CAST(A4.src_itemgrp_int_cd AS BIGNUMERIC), 0) AS itemgroup_int_id
  FROM ldl_p_lew_core_ac.v_item_map_key_2 AS A
   LEFT JOIN ldl_p_lew_bil_ac.v_item_2 AS A1 ON A.client_id = A1.client_id AND A.item_sid = A1.item_sid AND CURRENT_DATE
     BETWEEN A1.dwh_valid_from AND A1.dwh_valid_to
   LEFT JOIN ldl_p_lew_bil_ac.v_item_familygroup_2 AS A2 ON A1.client_id = A2.client_id AND A1.item_fam_grp_sid = A2.item_fam_grp_sid
     
   LEFT JOIN ldl_p_lew_bil_ac.v_subitemgroup_2 AS A3 ON A1.client_id = A3.client_id AND A1.sub_item_grp_sid_asis = A3.sub_item_grp_sid
     
   LEFT JOIN ldl_p_lew_core_ac.v_itemgroup_international_2 AS A4 ON A3.client_id = A4.client_id AND A3.item_grp_int_sid =
     A4.item_grp_int_sid
  WHERE CAST(A4.src_itemgrp_int_cd AS FLOAT64) > 0
   AND CAST(A4.src_itemgrp_int_cd AS INTEGER) NOT IN (7, 70)), LOC_CTE AS (SELECT OSM.client_id,
   OSM.move_to_st_loc_sid AS move_to_store_id,
   WH.src_wh_id AS wh_id,
   WH.loc_sid_wh,
   OSM.orig_store_nr
  FROM ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS OSM
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON OSM.wh_loc_sid = WH.loc_sid_wh AND OSM.client_id = WH.client_id AND
      WH.dwh_actual_fg = 1 AND OSM.aspect_id = 1), BASE_CTE AS (SELECT POS.client_id,
    POS.item_sid,
    POS.loc_sid_store AS move_to_store_id,
    CAL.cal_dt AS dat_formdate,
     SUM(CASE
       WHEN CAL.cal_dt = POS.dwh_cal_dt
       THEN POS.sales_net_val + POS.return_net_val
       ELSE NULL
       END) / CURR.rate_currency_exchange AS sales_volume_val,
    SUM(CASE
      WHEN CAL.cal_dt = POS.dwh_cal_dt
      THEN POS.sales_piece_qty + POS.sales_weight_qty + POS.return_qty
      ELSE NULL
      END) AS sales_piece_qty,
     SUM(CASE
       WHEN CAL.cal_dt_prev_1y = POS.dwh_cal_dt
       THEN POS.sales_net_val + POS.return_net_val
       ELSE NULL
       END) / CURR.rate_currency_exchange AS sales_volume_val_py,
    SUM(CASE
      WHEN CAL.cal_dt_prev_1y = POS.dwh_cal_dt
      THEN POS.sales_piece_qty + POS.sales_weight_qty + POS.return_qty
      ELSE NULL
      END) AS sales_piece_qty_py,
     SUM(CASE
       WHEN CAL.cal_dt_swday_prev_1y = POS.dwh_cal_dt
       THEN POS.sales_net_val + POS.return_net_val
       ELSE NULL
       END) / CURR.rate_currency_exchange AS sales_volume_val_swpy,
    SUM(CASE
      WHEN CAL.cal_dt_swday_prev_1y = POS.dwh_cal_dt
      THEN POS.sales_piece_qty + POS.sales_weight_qty + POS.return_qty
      ELSE NULL
      END) AS sales_piece_qty_swpy,
    CURR.currency_iso_cd
   FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL
    INNER JOIN ldl_p_lew_bil_ac.v_agg_pos_store_item_day_2 AS POS ON CAL.cal_dt = POS.dwh_cal_dt OR CAL.cal_dt_swday_prev_1y
        = POS.dwh_cal_dt OR CAL.cal_dt_prev_1y = POS.dwh_cal_dt
    INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CURR ON POS.client_id = CURR.client_id
    INNER JOIN SORT_CTE AS itm ON POS.client_id = itm.client_id AND POS.item_sid = itm.item_sid
   WHERE CAL.cal_dt BETWEEN (SELECT MIN(cal_dt)
      FROM ldl_p_lew_core_ac.v_cal_calendarday_2
      WHERE busyear_seq = - 2) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    AND CURR.currency_iso_cd = 'EUR'
    AND CURRENT_DATE BETWEEN CURR.dat_rec_start AND CURR.dat_rec_end
   GROUP BY POS.client_id,
    dat_formdate,
    POS.item_sid,
    move_to_store_id,
    CURR.rate_currency_exchange,
    CURR.currency_iso_cd
   UNION ALL
   SELECT A.client_id,
    A.item_sid,
    b.move_to_store_id,
    A.dat_formdate,
    CAST(NULL AS NUMERIC) AS sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty,
    CAST(NULL AS NUMERIC) AS sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_swpy,
    'EUR' AS currency_iso_cd
   FROM ldl_p_lew_mart_lead.t_agg_sell_prc_dvlp_wh_day_itm_2 AS A
    INNER JOIN LOC_CTE AS b ON A.client_id = b.client_id AND A.wh_id = b.wh_id) (SELECT client_id,
   item_sid,
   move_to_store_id,
   dat_formdate,
   SUM(sales_volume_val) AS sales_volume_val,
   SUM(sales_piece_qty) AS sales_piece_qty,
   SUM(sales_volume_val_py) AS sales_volume_val_py,
   SUM(sales_piece_qty_py) AS sales_piece_qty_py,
   SUM(sales_volume_val_swpy) AS sales_volume_val_swpy,
   SUM(sales_piece_qty_swpy) AS sales_piece_qty_swpy,
   currency_iso_cd
  FROM BASE_CTE
  GROUP BY client_id,
   item_sid,
   move_to_store_id,
   dat_formdate,
   currency_iso_cd);
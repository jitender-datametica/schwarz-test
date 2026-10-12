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



CREATE OR REPLACE VIEW p_lew_mart_lead.V_AGG_SELL_PRC_DVLP_STR_DAY_ITM_2
AS 
WITH loc_cte 
AS (
SELECT
  osm.client_id
 ,osm.move_to_st_loc_sid AS move_to_store_id
 ,wh.src_wh_id           AS wh_id
 ,wh.loc_sid_wh          AS loc_sid_wh
 ,osm.orig_store_nr
FROM p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS osm
INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
ON osm.wh_loc_sid = wh.loc_sid_wh
AND osm.client_id = wh.client_id
AND wh.dwh_actual_fg = 1
AND osm.aspect_id  = 1
)
, sort_cte 
AS (
SELECT
  a.client_id
, a.item_sid
, a.item_sid_map                     AS item_id
, a2.src_familygrp_cd
, a3.src_subitemgrp_cd               AS subitemgroup_id
, COALESCE(a4.src_itemgrp_int_cd, 0) AS itemgroup_int_id
FROM P_LEW_CORE_AC.v_item_map_key_2 AS a

LEFT OUTER JOIN P_LEW_BIL_AC.v_item_2 AS a1
ON a.client_id = a1.client_id
AND a.item_sid  = a1.item_sid
AND CURRENT_DATE BETWEEN a1.dwh_valid_from
                    AND a1.dwh_valid_to

LEFT OUTER JOIN P_LEW_BIL_AC.v_item_familygroup_2 AS a2
ON a1.client_id        = a2.client_id
AND a1.item_fam_grp_sid = a2.item_fam_grp_sid

LEFT OUTER JOIN P_LEW_BIL_AC.v_subitemgroup_2 AS a3
ON a1.client_id             = a3.client_id
AND a1.sub_item_grp_sid_asis = a3.sub_item_grp_sid

LEFT OUTER JOIN P_LEW_CORE_AC.v_itemgroup_international_2 AS a4
ON a3.client_id           = a4.client_id
AND a3.item_grp_int_sid    = a4.item_grp_int_sid

WHERE a4.src_itemgrp_int_cd  > 0
AND a4.src_itemgrp_int_cd NOT IN ( 7 , 70 )
) 
, BASE_cte 
AS (
SELECT 
  pos.client_id
, pos.item_sid 
, pos.loc_sid_store AS move_to_store_id
, cal.cal_dt dat_formdate
, SUM(CASE WHEN cal_dt = dwh_cal_dt THEN pos.sales_net_val + pos.return_net_val ELSE NULL END) / curr.rate_currency_exchange AS sales_volume_val
, SUM(CASE WHEN cal_dt = dwh_cal_dt THEN pos.sales_piece_qty + pos.sales_weight_qty + pos.return_qty ELSE NULL END) AS sales_piece_qty
, SUM(CASE WHEN cal_dt_prev_1y = dwh_cal_dt THEN pos.sales_net_val + pos.return_net_val ELSE NULL END) / curr.rate_currency_exchange AS sales_volume_val_py
, SUM(CASE WHEN cal_dt_prev_1y = dwh_cal_dt THEN pos.sales_piece_qty + pos.sales_weight_qty + pos.return_qty ELSE NULL END) AS sales_piece_qty_py
, SUM(CASE WHEN cal_dt_swday_prev_1y = dwh_cal_dt THEN pos.sales_net_val + pos.return_net_val ELSE NULL END) / curr.rate_currency_exchange AS sales_volume_val_swpy
, SUM(CASE WHEN cal_dt_swday_prev_1y = dwh_cal_dt THEN pos.sales_piece_qty + pos.sales_weight_qty + pos.return_qty ELSE NULL END) AS sales_piece_qty_swpy
, currency_iso_cd
FROM P_LEW_CORE_AC.V_CAL_CALENDARDAY_2 cal
JOIN P_LEW_BIL_AC.V_AGG_POS_STORE_ITEM_DAY_2 pos
ON (   cal_dt = pos.dwh_cal_dt 
     OR cal_dt_swday_prev_1y = pos.dwh_cal_dt  
     OR cal_dt_prev_1y = pos.dwh_cal_dt
    )
JOIN P_LEW_CORE_AC.V_WAWI_REF_CLIENT_CURRENCY_RATE_2 CURR
ON pos.client_id = curr.client_id
JOIN sort_cte itm
ON pos.client_id = itm.client_id
AND pos.item_sid = itm.item_sid
WHERE cal_dt BETWEEN (
                        SELECT MIN(cal_dt)
                        FROM P_LEW_CORE_AC.V_CAL_CALENDARDAY_2
                        WHERE busyear_seq = -2
                       )
                   AND CURRENT_DATE - 1
   AND currency_iso_cd = 'EUR'
   AND CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end  

	
GROUP BY
  pos.client_id
, cal_dt
, pos.item_sid 
, pos.loc_sid_store
, curr.rate_currency_exchange
, currency_iso_cd

UNION ALL

SELECT 
  a.client_id
, item_sid 
, move_to_store_id
, dat_formdate
, NULL AS sales_volume_val
, NULL AS sales_piece_qty
, NULL AS sales_volume_val_py
, NULL AS sales_piece_qty_py
, NULL AS sales_volume_val_swpy
, NULL AS sales_piece_qty_swpy
, 'EUR' AS currency_iso_cd
FROM p_lew_mart_lead.t_agg_sell_prc_dvlp_wh_day_itm_2 a
JOIN loc_cte b
ON a.client_id = b.client_id
AND a.wh_id = b.wh_id
)

SELECT 
  client_id
, item_sid 
, move_to_store_id
, dat_formdate
, SUM(sales_volume_val) sales_volume_val
, SUM(sales_piece_qty) sales_piece_qty
, SUM(sales_volume_val_py) sales_volume_val_py
, SUM(sales_piece_qty_py) sales_piece_qty_py
, SUM(sales_volume_val_swpy) sales_volume_val_swpy
, SUM(sales_piece_qty_swpy) sales_piece_qty_swpy
, currency_iso_cd
FROM BASE_cte
GROUP BY client_id
, item_sid 
, move_to_store_id
, dat_formdate
, currency_iso_cd
;

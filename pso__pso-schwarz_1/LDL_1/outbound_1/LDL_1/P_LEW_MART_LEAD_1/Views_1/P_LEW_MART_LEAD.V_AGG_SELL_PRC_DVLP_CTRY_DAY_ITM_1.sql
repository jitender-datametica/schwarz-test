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
# 1.0  2024-07-29   Aleksander Bialek    Initial version, main view delivering data for VKP metrics after re_1-work requested by the business (ADWI:512479).
# 1.1  2024-08-16   Aleksander Bialek    Addineg the data processing in the successor context (ADWI:655914)
#
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_sell_prc_dvlp_ctry_day_itm_1( 
 client_id              
,item_sid               
,dat_formdate           
,sales_volume_val       
,sales_piece_qty   	 
,sales_volume_val_py    
,sales_piece_qty_py     
,sales_volume_val_swpy  
,sales_piece_qty_swpy   
,cbx_pred_sales_volume_val
,cbx_pred_sales_piece_qty
,cbx_pred_sales_volume_val_py
,cbx_pred_sales_piece_qty_py
,cbx_pred_sales_volume_val_swpy
,cbx_pred_sales_piece_qty_swpy
,cbx_pred_pred_sales_volume_val
,cbx_pred_pred_sales_piece_qty
,cbx_pred_pred_sales_volume_val_py
,cbx_pred_pred_sales_piece_qty_py
,cbx_pred_pred_sales_volume_val_swpy
,cbx_pred_pred_sales_piece_qty_swpy
,cbx_pred2_sales_volume_val
,cbx_pred2_sales_piece_qty
,cbx_pred2_sales_volume_val_py
,cbx_pred2_sales_piece_qty_py
,cbx_pred2_sales_volume_val_swpy
,cbx_pred2_sales_piece_qty_swpy
,cbx_succ_sales_volume_val                    
,cbx_succ_sales_piece_qty
,cbx_succ_sales_volume_val_py
,cbx_succ_sales_piece_qty_py
,cbx_succ_sales_volume_val_swpy
,cbx_succ_sales_piece_qty_swpy
,cbx_succ_succ_sales_volume_val
,cbx_succ_succ_sales_piece_qty
,cbx_succ_succ_sales_volume_val_py
,cbx_succ_succ_sales_piece_qty_py
,cbx_succ_succ_sales_volume_val_swpy 
,cbx_succ_succ_sales_piece_qty_swpy
,cbx_succ2_sales_volume_val
,cbx_succ2_sales_piece_qty
,cbx_succ2_sales_volume_val_py
,cbx_succ2_sales_piece_qty_py
,cbx_succ2_sales_volume_val_swpy
,cbx_succ2_sales_piece_qty_swpy   
)
 AS WITH CTE_ITM AS (SELECT A.client_id,
   A.item_sid,
   A.item_sid_map AS item_id,
   A2.src_familygrp_cd,
   A3.src_subitemgrp_cd AS subitemgroup_id,
   COALESCE(CAST(A4.src_itemgrp_int_cd AS BIGNUMERIC), 0) AS itemgroup_int_id,
    CASE
    WHEN CAST(A4.src_itemgrp_int_cd AS INTEGER) IN (7, 70)
    THEN 1
    ELSE 0
    END AS nf_flg
  FROM ldl_p_lew_core_ac.v_item_map_key_1 AS A
   LEFT JOIN ldl_p_lew_bil_ac.v_item_1 AS A1 ON A.client_id = A1.client_id AND A.item_sid = A1.item_sid AND CURRENT_DATE
     BETWEEN A1.dwh_valid_from AND A1.dwh_valid_to
   LEFT JOIN ldl_p_lew_bil_ac.v_item_familygroup_1 AS A2 ON A1.client_id = A2.client_id AND A1.item_fam_grp_sid = A2.item_fam_grp_sid
     
   LEFT JOIN ldl_p_lew_bil_ac.v_subitemgroup_1 AS A3 ON A1.client_id = A3.client_id AND A1.sub_item_grp_sid_asis = A3.sub_item_grp_sid
     
   LEFT JOIN ldl_p_lew_core_ac.v_itemgroup_international_1 AS A4 ON A3.client_id = A4.client_id AND A3.item_grp_int_sid =
     A4.item_grp_int_sid
  WHERE CAST(A4.src_itemgrp_int_cd AS FLOAT64) > 0), CTE_CAL AS (SELECT cal_dt,
   cal_dt_swday_prev_1y,
   cal_dt_prev_1y
  FROM ldl_p_lew_core_ac.v_cal_calendarday_1
  WHERE cal_dt BETWEEN (SELECT MIN(cal_dt)
     FROM ldl_p_lew_core_ac.v_cal_calendarday_1
     WHERE busyear_seq = - 2) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))), CTE_MASTER_DAT AS (SELECT t1.client_id,
   t1.item_sid,
   t1.nf_flg,
   t6.cal_dt,
   t6.cal_dt_swday_prev_1y,
   t6.cal_dt_prev_1y
  FROM CTE_ITM AS t1_1
   INNER JOIN CTE_CAL AS t6 ON TRUE), CTE_AGG AS (SELECT AGG.client_id,
   AGG.item_sid,
   CAL.cal_dt,
    SUM(CASE
      WHEN CAL.cal_dt = AGG.dwh_cal_dt
      THEN AGG.sales_net_val + AGG.return_net_val
      ELSE NULL
      END) / CURR.rate_currency_exchange AS sales_volume_val,
   SUM(CASE
     WHEN CAL.cal_dt = AGG.dwh_cal_dt
     THEN CASE
      WHEN AGG.discount_sid = - 1
      THEN AGG.sales_piece_qty + AGG.sales_weight_qty + AGG.return_qty
      ELSE 0
      END
     ELSE NULL
     END) AS sales_piece_qty,
    SUM(CASE
      WHEN CAL.cal_dt_prev_1y = AGG.dwh_cal_dt
      THEN AGG.sales_net_val + AGG.return_net_val
      ELSE NULL
      END) / CURR.rate_currency_exchange AS sales_volume_val_py,
   SUM(CASE
     WHEN CAL.cal_dt_prev_1y = AGG.dwh_cal_dt
     THEN CASE
      WHEN AGG.discount_sid = - 1
      THEN AGG.sales_piece_qty + AGG.sales_weight_qty + AGG.return_qty
      ELSE 0
      END
     ELSE NULL
     END) AS sales_piece_qty_py,
    SUM(CASE
      WHEN CAL.cal_dt_swday_prev_1y = AGG.dwh_cal_dt
      THEN AGG.sales_net_val + AGG.return_net_val
      ELSE NULL
      END) / CURR.rate_currency_exchange AS sales_volume_val_swpy,
   SUM(CASE
     WHEN CAL.cal_dt_swday_prev_1y = AGG.dwh_cal_dt
     THEN CASE
      WHEN AGG.discount_sid = - 1
      THEN AGG.sales_piece_qty + AGG.sales_weight_qty + AGG.return_qty
      ELSE 0
      END
     ELSE NULL
     END) AS sales_piece_qty_swpy
  FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL
   INNER JOIN ldl_p_lew_bil_ac.v_agg_pos_wh_day_item_asis_1 AS AGG ON CAL.cal_dt = AGG.dwh_cal_dt OR CAL.cal_dt_swday_prev_1y
       = AGG.dwh_cal_dt OR CAL.cal_dt_prev_1y = AGG.dwh_cal_dt
   INNER JOIN CTE_ITM AS itm ON AGG.client_id = itm.client_id AND AGG.item_sid = itm.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CURR ON AGG.client_id = CURR.client_id
  WHERE CAL.cal_dt BETWEEN (SELECT MIN(cal_dt)
     FROM ldl_p_lew_core_ac.v_cal_calendarday_1
     WHERE busyear_seq = - 2) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
   AND CURR.currency_iso_cd = 'EUR'
   AND CURRENT_DATE BETWEEN CURR.dat_rec_start AND CURR.dat_rec_end
  GROUP BY AGG.client_id,
   CAL.cal_dt,
   AGG.item_sid,
   CURR.rate_currency_exchange), CTE_MDM_PRED_HIST AS (SELECT client_id,
   mdm_item_sid,
   mdm_item_sid_related,
   item_rel_type_cd
  FROM ldl_p_lew_core.t_mdm_item_related_item_hist_1
  WHERE (item_rel_type_cd LIKE 'PRED1' OR item_rel_type_cd LIKE 'PRED2')
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND deleted_fg = 0
  GROUP BY client_id,
   mdm_item_sid,
   item_rel_type_cd,
   mdm_item_sid_related), CTE_ITEM_MDM_LINK AS (SELECT client_id,
   item_sid,
   mdm_item_sid
  FROM ldl_p_lew_core.t_item_mdm_link_1
  GROUP BY client_id,
   item_sid,
   mdm_item_sid), CTE_ITM_CBX AS (SELECT b.client_id,
   b.item_sid,
   c.item_sid AS item_sid_pred,
   a.item_rel_type_cd
  FROM CTE_MDM_PRED_HIST AS a
   INNER JOIN CTE_ITEM_MDM_LINK AS b ON a.mdm_item_sid = b.mdm_item_sid
   INNER JOIN CTE_ITEM_MDM_LINK AS c ON a.mdm_item_sid_related = c.mdm_item_sid AND b.client_id = c.client_id
  WHERE b.item_sid <> c.item_sid
  GROUP BY b.client_id,
   b.item_sid,
   item_sid_pred,
   a.item_rel_type_cd), CTE_AGG_ALL AS (SELECT client_id,
    item_sid,
    cal_dt,
    CAST(NULL AS NUMERIC) AS sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty,
    CAST(NULL AS NUMERIC) AS sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_swpy
   FROM CTE_MASTER_DAT
   UNION ALL
   SELECT client_id,
    item_sid,
    cal_dt,
    sales_volume_val,
    sales_piece_qty,
    sales_volume_val_py,
    sales_piece_qty_py,
    sales_volume_val_swpy,
    sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_swpy
   FROM CTE_AGG
   UNION ALL
   SELECT agg.client_id,
    itm.item_sid,
    agg.cal_dt,
    CAST(NULL AS NUMERIC) AS sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty,
    CAST(NULL AS NUMERIC) AS sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_swpy,
    agg.sales_volume_val AS cbx_pred_sales_volume_val,
    agg.sales_piece_qty AS cbx_pred_sales_piece_qty,
    agg.sales_volume_val_py AS cbx_pred_sales_volume_val_py,
    agg.sales_piece_qty_py AS cbx_pred_sales_piece_qty_py,
    agg.sales_volume_val_swpy AS cbx_pred_sales_volume_val_swpy,
    agg.sales_piece_qty_swpy AS cbx_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_swpy
   FROM CTE_AGG AS agg
    INNER JOIN CTE_ITM_CBX AS cbx ON agg.client_id = cbx.client_id AND agg.item_sid = cbx.item_sid_pred AND cbx.item_rel_type_cd
      LIKE 'PRED1'
    INNER JOIN CTE_ITM AS itm ON cbx.client_id = itm.client_id AND cbx.item_sid = itm.item_sid AND itm.nf_flg = 1
   UNION ALL
   SELECT agg.client_id,
    itm.item_sid,
    agg.cal_dt,
    CAST(NULL AS NUMERIC) AS sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty,
    CAST(NULL AS NUMERIC) AS sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_swpy,
    agg.sales_volume_val AS cbx_pred_pred_sales_volume_val,
    agg.sales_piece_qty AS cbx_pred_pred_sales_piece_qty,
    agg.sales_volume_val_py AS cbx_pred_pred_sales_volume_val_py,
    agg.sales_piece_qty_py AS cbx_pred_pred_sales_piece_qty_py,
    agg.sales_volume_val_swpy AS cbx_pred_pred_sales_volume_val_swpy,
    agg.sales_piece_qty_swpy AS cbx_pred_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_swpy
   FROM CTE_AGG AS agg
    INNER JOIN CTE_ITM_CBX AS cbx ON agg.client_id = cbx.client_id AND agg.item_sid = cbx.item_sid_pred AND cbx.item_rel_type_cd
      LIKE 'PRED1'
    INNER JOIN CTE_ITM_CBX AS cbx2 ON cbx.client_id = cbx2.client_id AND cbx.item_sid = cbx2.item_sid_pred AND cbx2.item_rel_type_cd
      LIKE 'PRED1'
    INNER JOIN CTE_ITM AS itm ON cbx2.client_id = itm.client_id AND cbx2.item_sid = itm.item_sid AND agg.item_sid <> itm
       .item_sid AND itm.nf_flg = 1
   GROUP BY agg.client_id,
    itm.item_sid,
    agg.cal_dt,
    cbx_pred_pred_sales_volume_val,
    cbx_pred_pred_sales_piece_qty,
    cbx_pred_pred_sales_volume_val_py,
    cbx_pred_pred_sales_piece_qty_py,
    cbx_pred_pred_sales_volume_val_swpy,
    cbx_pred_pred_sales_piece_qty_swpy
   UNION ALL
   SELECT agg.client_id,
    itm.item_sid,
    agg.cal_dt,
    CAST(NULL AS NUMERIC) AS sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty,
    CAST(NULL AS NUMERIC) AS sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_swpy,
    agg.sales_volume_val AS cbx_pred2_sales_volume_val,
    agg.sales_piece_qty AS cbx_pred2_sales_piece_qty,
    agg.sales_volume_val_py AS cbx_pred2_sales_volume_val_py,
    agg.sales_piece_qty_py AS cbx_pred2_sales_piece_qty_py,
    agg.sales_volume_val_swpy AS cbx_pred2_sales_volume_val_swpy,
    agg.sales_piece_qty_swpy AS cbx_pred2_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_swpy
   FROM CTE_AGG AS agg
    INNER JOIN CTE_ITM_CBX AS cbx ON agg.client_id = cbx.client_id AND agg.item_sid = cbx.item_sid_pred AND cbx.item_rel_type_cd
      LIKE 'PRED2'
    INNER JOIN CTE_ITM AS itm ON cbx.client_id = itm.client_id AND cbx.item_sid = itm.item_sid AND itm.nf_flg = 1
   UNION ALL
   SELECT agg.client_id,
    itm.item_sid,
    agg.cal_dt,
    CAST(NULL AS NUMERIC) AS sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty,
    CAST(NULL AS NUMERIC) AS sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_swpy,
    agg.sales_volume_val AS cbx_succ_sales_volume_val,
    agg.sales_piece_qty AS cbx_succ_sales_piece_qty,
    agg.sales_volume_val_py AS cbx_succ_sales_volume_val_py,
    agg.sales_piece_qty_py AS cbx_succ_sales_piece_qty_py,
    agg.sales_volume_val_swpy AS cbx_succ_sales_volume_val_swpy,
    agg.sales_piece_qty_swpy AS cbx_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_swpy
   FROM CTE_AGG AS agg
    INNER JOIN CTE_ITM_CBX AS cbx ON agg.client_id = cbx.client_id AND agg.item_sid = cbx.item_sid AND cbx.item_rel_type_cd
      LIKE 'PRED1'
    INNER JOIN CTE_ITM AS itm ON cbx.client_id = itm.client_id AND cbx.item_sid_pred = itm.item_sid AND itm.nf_flg = 1
   UNION ALL
   SELECT agg.client_id,
    itm.item_sid,
    agg.cal_dt,
    CAST(NULL AS NUMERIC) AS sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty,
    CAST(NULL AS NUMERIC) AS sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_swpy,
    agg.sales_volume_val AS cbx_succ_succ_sales_volume_val,
    agg.sales_piece_qty AS cbx_succ_succ_sales_piece_qty,
    agg.sales_volume_val_py AS cbx_succ_succ_sales_volume_val_py,
    agg.sales_piece_qty_py AS cbx_succ_succ_sales_piece_qty_py,
    agg.sales_volume_val_swpy AS cbx_succ_succ_sales_volume_val_swpy,
    agg.sales_piece_qty_swpy AS cbx_succ_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ2_sales_piece_qty_swpy
   FROM CTE_AGG AS agg
    INNER JOIN CTE_ITM_CBX AS cbx ON agg.client_id = cbx.client_id AND agg.item_sid = cbx.item_sid AND cbx.item_rel_type_cd
      LIKE 'PRED1'
    INNER JOIN CTE_ITM_CBX AS cbx2 ON cbx.client_id = cbx2.client_id AND cbx.item_sid_pred = cbx2.item_sid AND cbx2.item_rel_type_cd
      LIKE 'PRED1'
    INNER JOIN CTE_ITM AS itm ON cbx2.client_id = itm.client_id AND cbx2.item_sid_pred = itm.item_sid AND agg.item_sid
       <> itm.item_sid AND itm.nf_flg = 1
   GROUP BY agg.client_id,
    itm.item_sid,
    agg.cal_dt,
    cbx_succ_succ_sales_volume_val,
    cbx_succ_succ_sales_piece_qty,
    cbx_succ_succ_sales_volume_val_py,
    cbx_succ_succ_sales_piece_qty_py,
    cbx_succ_succ_sales_volume_val_swpy,
    cbx_succ_succ_sales_piece_qty_swpy
   UNION ALL
   SELECT agg.client_id,
    itm.item_sid,
    agg.cal_dt,
    CAST(NULL AS NUMERIC) AS sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty,
    CAST(NULL AS NUMERIC) AS sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred_pred_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred_pred_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_pred2_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_pred2_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_sales_piece_qty_swpy,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_py,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_py,
    CAST(NULL AS NUMERIC) AS cbx_succ_succ_sales_volume_val_swpy,
    CAST(NULL AS BIGNUMERIC) AS cbx_succ_succ_sales_piece_qty_swpy,
    agg.sales_volume_val AS cbx_succ2_sales_volume_val,
    agg.sales_piece_qty AS cbx_succ2_sales_piece_qty,
    agg.sales_volume_val_py AS cbx_succ2_sales_volume_val_py,
    agg.sales_piece_qty_py AS cbx_succ2_sales_piece_qty_py,
    agg.sales_volume_val_swpy AS cbx_succ2_sales_volume_val_swpy,
    agg.sales_piece_qty_swpy AS cbx_succ2_sales_piece_qty_swpy
   FROM CTE_AGG AS agg
    INNER JOIN CTE_ITM_CBX AS cbx ON agg.client_id = cbx.client_id AND agg.item_sid = cbx.item_sid AND cbx.item_rel_type_cd
      LIKE 'PRED2'
    INNER JOIN CTE_ITM AS itm ON cbx.client_id = itm.client_id AND cbx.item_sid_pred = itm.item_sid AND itm.nf_flg = 1)
  (/* t_mdm_item_related_item_hist_1 is historized, only the current records are representing the correct information as of Today, so you have to filter here */
  SELECT client_id,
   item_sid,
   cal_dt AS dat_fordmate,
   SUM(sales_volume_val) AS sales_volume_val,
   SUM(sales_piece_qty) AS sales_piece_qty,
   SUM(sales_volume_val_py) AS sales_volume_val_py,
   SUM(sales_piece_qty_py) AS sales_piece_qty_py,
   SUM(sales_volume_val_swpy) AS sales_volume_val_swpy,
   SUM(sales_piece_qty_swpy) AS sales_piece_qty_swpy,
   SUM(cbx_pred_sales_volume_val) AS cbx_pred_sales_volume_val,
   SUM(cbx_pred_sales_piece_qty) AS cbx_pred_sales_piece_qty,
   SUM(cbx_pred_sales_volume_val_py) AS cbx_pred_sales_volume_val_py,
   SUM(cbx_pred_sales_piece_qty_py) AS cbx_pred_sales_piece_qty_py,
   SUM(cbx_pred_sales_volume_val_swpy) AS cbx_pred_sales_volume_val_swpy,
   SUM(cbx_pred_sales_piece_qty_swpy) AS cbx_pred_sales_piece_qty_swpy,
   SUM(cbx_pred_pred_sales_volume_val) AS cbx_pred_pred_sales_volume_val,
   SUM(cbx_pred_pred_sales_piece_qty) AS cbx_pred_pred_sales_piece_qty,
   SUM(cbx_pred_pred_sales_volume_val_py) AS cbx_pred_pred_sales_volume_val_py,
   SUM(cbx_pred_pred_sales_piece_qty_py) AS cbx_pred_pred_sales_piece_qty_py,
   SUM(cbx_pred_pred_sales_volume_val_swpy) AS cbx_pred_pred_sales_volume_val_swpy,
   SUM(cbx_pred_pred_sales_piece_qty_swpy) AS cbx_pred_pred_sales_piece_qty_swpy,
   SUM(cbx_pred2_sales_volume_val) AS cbx_pred2_sales_volume_val,
   SUM(cbx_pred2_sales_piece_qty) AS cbx_pred2_sales_piece_qty,
   SUM(cbx_pred2_sales_volume_val_py) AS cbx_pred2_sales_volume_val_py,
   SUM(cbx_pred2_sales_piece_qty_py) AS cbx_pred2_sales_piece_qty_py,
   SUM(cbx_pred2_sales_volume_val_swpy) AS cbx_pred2_sales_volume_val_swpy,
   SUM(cbx_pred2_sales_piece_qty_swpy) AS cbx_pred2_sales_piece_qty_swpy,
   SUM(cbx_succ_sales_volume_val) AS cbx_succ_sales_volume_val,
   SUM(cbx_succ_sales_piece_qty) AS cbx_succ_sales_piece_qty,
   SUM(cbx_succ_sales_volume_val_py) AS cbx_succ_sales_volume_val_py,
   SUM(cbx_succ_sales_piece_qty_py) AS cbx_succ_sales_piece_qty_py,
   SUM(cbx_succ_sales_volume_val_swpy) AS cbx_succ_sales_volume_val_swpy,
   SUM(cbx_succ_sales_piece_qty_swpy) AS cbx_succ_sales_piece_qty_swpy,
   SUM(cbx_succ_succ_sales_volume_val) AS cbx_succ_succ_sales_volume_val,
   SUM(cbx_succ_succ_sales_piece_qty) AS cbx_succ_succ_sales_piece_qty,
   SUM(cbx_succ_succ_sales_volume_val_py) AS cbx_succ_succ_sales_volume_val_py,
   SUM(cbx_succ_succ_sales_piece_qty_py) AS cbx_succ_succ_sales_piece_qty_py,
   SUM(cbx_succ_succ_sales_volume_val_swpy) AS cbx_succ_succ_sales_volume_val_swpy,
   SUM(cbx_succ_succ_sales_piece_qty_swpy) AS cbx_succ_succ_sales_piece_qty_swpy,
   SUM(cbx_succ2_sales_volume_val) AS cbx_succ2_sales_volume_val,
   SUM(cbx_succ2_sales_piece_qty) AS cbx_succ2_sales_piece_qty,
   SUM(cbx_succ2_sales_volume_val_py) AS cbx_succ2_sales_volume_val_py,
   SUM(cbx_succ2_sales_piece_qty_py) AS cbx_succ2_sales_piece_qty_py,
   SUM(cbx_succ2_sales_volume_val_swpy) AS cbx_succ2_sales_volume_val_swpy,
   SUM(cbx_succ2_sales_piece_qty_swpy) AS cbx_succ2_sales_piece_qty_swpy
  FROM CTE_AGG_ALL
  GROUP BY client_id,
   item_sid,
   cal_dt);

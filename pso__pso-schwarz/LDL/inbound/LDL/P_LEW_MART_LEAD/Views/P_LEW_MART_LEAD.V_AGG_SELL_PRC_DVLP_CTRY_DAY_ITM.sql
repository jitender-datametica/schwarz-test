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
# 1.0  2024-07-29   Aleksander Bialek    Initial version, main view delivering data for VKP metrics after re-work requested by the business (ADWI:512479).
# 1.1  2024-08-16   Aleksander Bialek    Addineg the data processing in the successor context (ADWI:655914)
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_SELL_PRC_DVLP_CTRY_DAY_ITM
( 
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
AS 
WITH cte_itm 
AS (
SELECT
  a.client_id
, a.item_sid
, a.item_sid_map                     AS item_id
, a2.src_familygrp_cd
, a3.src_subitemgrp_cd               AS subitemgroup_id
, COALESCE(a4.src_itemgrp_int_cd, 0) AS itemgroup_int_id
, CASE WHEN a4.src_itemgrp_int_cd IN ( 7,70) THEN 1 ELSE 0 END nf_flg
FROM P_LEW_CORE_AC.v_item_map_key AS a

LEFT OUTER JOIN P_LEW_BIL_AC.v_item AS a1
ON a.client_id = a1.client_id
AND a.item_sid  = a1.item_sid
AND CURRENT_DATE BETWEEN a1.dwh_valid_from
                    AND a1.dwh_valid_to

LEFT OUTER JOIN P_LEW_BIL_AC.v_item_familygroup AS a2
ON a1.client_id        = a2.client_id
AND a1.item_fam_grp_sid = a2.item_fam_grp_sid

LEFT OUTER JOIN P_LEW_BIL_AC.v_subitemgroup AS a3
ON a1.client_id             = a3.client_id
AND a1.sub_item_grp_sid_asis = a3.sub_item_grp_sid

LEFT OUTER JOIN P_LEW_CORE_AC.v_itemgroup_international AS a4
ON a3.client_id           = a4.client_id
AND a3.item_grp_int_sid    = a4.item_grp_int_sid
WHERE a4.src_itemgrp_int_cd  > 0
)
, cte_cal AS (
SELECT cal_dt, cal_dt_swday_prev_1y, cal_dt_prev_1y  
FROM P_LEW_CORE_AC.v_cal_calendarday
WHERE cal_dt BETWEEN (
                        SELECT MIN(cal_dt)
                        FROM P_LEW_CORE_AC.v_cal_calendarday
                        WHERE busyear_seq = -2
                       )
                   AND CURRENT_DATE - 1
)
, cte_master_dat AS (
SELECT client_id, item_sid, nf_flg, cal_dt, cal_dt_swday_prev_1y, cal_dt_prev_1y
FROM cte_itm
JOIN cte_cal
)
, cte_item_mdm_link
AS 
(
SELECT 
client_id
,item_sid
,mdm_item_sid 
FROM p_lew_core.T_ITEM_MDM_LINK
GROUP BY 1,2,3
)
, cte_mdm_pred_hist 
AS (
SELECT 
    client_id
  , mdm_item_sid
  , mdm_item_sid_related
  , ITEM_REL_TYPE_CD
FROM p_lew_core.t_mdm_item_related_item_hist
WHERE 
(ITEM_REL_TYPE_CD LIKE 'PRED1' OR ITEM_REL_TYPE_CD LIKE 'PRED2' 
)
/* t_mdm_item_related_item_hist is historized, only the current records are representing the correct information as of Today, so you have to filter here */
AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
AND deleted_fg=0
GROUP BY 1,2,3,4
)
, cte_itm_cbx AS (
SELECT 
  b.client_id
, b.item_sid
, c.item_sid AS item_sid_pred
, ITEM_REL_TYPE_CD
FROM cte_mdm_pred_hist a
JOIN cte_item_mdm_link b
ON  a.mdm_item_sid = b.mdm_item_sid
JOIN cte_item_mdm_link c
ON a.mdm_item_sid_related = c.mdm_item_sid
AND b.client_id=c.client_id
WHERE b.item_sid <> c.item_sid
GROUP BY 1,2,3,4
)
, cte_agg AS (
SELECT 
  agg.client_id
, agg.item_sid 
, cal.cal_dt
, SUM(CASE WHEN cal_dt = dwh_cal_dt THEN agg.sales_net_val + agg.return_net_val ELSE NULL END) / curr.rate_currency_exchange AS sales_volume_val
, SUM(CASE WHEN cal_dt = dwh_cal_dt THEN CASE WHEN discount_sid = -1 THEN agg.sales_piece_qty + agg.sales_weight_qty + agg.return_qty ELSE 0 END ELSE NULL END) AS sales_piece_qty
, SUM(CASE WHEN cal_dt_prev_1y = dwh_cal_dt THEN agg.sales_net_val + agg.return_net_val ELSE NULL END) / curr.rate_currency_exchange AS sales_volume_val_py
, SUM(CASE WHEN cal_dt_prev_1y = dwh_cal_dt THEN CASE WHEN discount_sid = -1 THEN agg.sales_piece_qty + agg.sales_weight_qty + agg.return_qty ELSE 0 END ELSE NULL END) AS sales_piece_qty_py
, SUM(CASE WHEN cal_dt_swday_prev_1y = dwh_cal_dt THEN agg.sales_net_val + agg.return_net_val ELSE NULL END) / curr.rate_currency_exchange AS sales_volume_val_swpy
, SUM(CASE WHEN cal_dt_swday_prev_1y = dwh_cal_dt THEN CASE WHEN discount_sid = -1 THEN agg.sales_piece_qty + agg.sales_weight_qty + agg.return_qty ELSE 0 END ELSE NULL END) AS sales_piece_qty_swpy
FROM P_LEW_CORE_AC.V_CAL_CALENDARDAY cal
JOIN P_LEW_BIL_AC.v_agg_pos_wh_day_item_asis agg
ON (   cal_dt = agg.dwh_cal_dt 
     OR cal_dt_swday_prev_1y = agg.dwh_cal_dt  
     OR cal_dt_prev_1y = agg.dwh_cal_dt
    )
JOIN cte_itm itm
ON agg.client_id = itm.client_id
AND agg.item_sid = itm.item_sid

JOIN P_LEW_CORE_AC.V_WAWI_REF_CLIENT_CURRENCY_RATE CURR
ON agg.client_id = curr.client_id

WHERE cal_dt BETWEEN (
                        SELECT MIN(cal_dt)
                        FROM P_LEW_CORE_AC.v_cal_calendarday
                        WHERE busyear_seq = -2
                       )
                   AND CURRENT_DATE - 1
   AND currency_iso_cd = 'EUR'
   AND CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end  
GROUP BY
  agg.client_id
, cal_dt
, agg.item_sid 
, curr.rate_currency_exchange
)
, cte_agg_all AS (
SELECT client_id
, item_sid
, cal_dt 
,NULL AS sales_volume_val       
,NULL AS sales_piece_qty   	 
,NULL AS sales_volume_val_py    
,NULL AS sales_piece_qty_py     
,NULL AS sales_volume_val_swpy  
,NULL AS sales_piece_qty_swpy   
,NULL AS cbx_pred_sales_volume_val
,NULL AS cbx_pred_sales_piece_qty
,NULL AS cbx_pred_sales_volume_val_py
,NULL AS cbx_pred_sales_piece_qty_py
,NULL AS cbx_pred_sales_volume_val_swpy
,NULL AS cbx_pred_sales_piece_qty_swpy
,NULL AS cbx_pred_pred_sales_volume_val
,NULL AS cbx_pred_pred_sales_piece_qty
,NULL AS cbx_pred_pred_sales_volume_val_py
,NULL AS cbx_pred_pred_sales_piece_qty_py
,NULL AS cbx_pred_pred_sales_volume_val_swpy
,NULL AS cbx_pred_pred_sales_piece_qty_swpy
,NULL AS cbx_pred2_sales_volume_val
,NULL AS cbx_pred2_sales_piece_qty
,NULL AS cbx_pred2_sales_volume_val_py
,NULL AS cbx_pred2_sales_piece_qty_py
,NULL AS cbx_pred2_sales_volume_val_swpy
,NULL AS cbx_pred2_sales_piece_qty_swpy
,NULL AS cbx_succ_sales_volume_val
,NULL AS cbx_succ_sales_piece_qty
,NULL AS cbx_succ_sales_volume_val_py
,NULL AS cbx_succ_sales_piece_qty_py
,NULL AS cbx_succ_sales_volume_val_swpy
,NULL AS cbx_succ_sales_piece_qty_swpy
,NULL AS cbx_succ_succ_sales_volume_val
,NULL AS cbx_succ_succ_sales_piece_qty
,NULL AS cbx_succ_succ_sales_volume_val_py
,NULL AS cbx_succ_succ_sales_piece_qty_py
,NULL AS cbx_succ_succ_sales_volume_val_swpy
,NULL AS cbx_succ_succ_sales_piece_qty_swpy
,NULL AS cbx_succ2_sales_volume_val
,NULL AS cbx_succ2_sales_piece_qty
,NULL AS cbx_succ2_sales_volume_val_py
,NULL AS cbx_succ2_sales_piece_qty_py
,NULL AS cbx_succ2_sales_volume_val_swpy
,NULL AS cbx_succ2_sales_piece_qty_swpy
FROM cte_master_dat

UNION ALL 

SELECT 
  client_id
, item_sid
, cal_dt 
, sales_volume_val      AS sales_volume_val       
, sales_piece_qty       AS sales_piece_qty   	 
, sales_volume_val_py   AS sales_volume_val_py    
, sales_piece_qty_py    AS sales_piece_qty_py     
, sales_volume_val_swpy AS sales_volume_val_swpy  
, sales_piece_qty_swpy  AS sales_piece_qty_swpy   
, NULL AS cbx_pred_sales_volume_val
, NULL AS cbx_pred_sales_piece_qty
, NULL AS cbx_pred_sales_volume_val_py
, NULL AS cbx_pred_sales_piece_qty_py
, NULL AS cbx_pred_sales_volume_val_swpy
, NULL AS cbx_pred_sales_piece_qty_swpy
, NULL AS cbx_pred_pred_sales_volume_val
, NULL AS cbx_pred_pred_sales_piece_qty
, NULL AS cbx_pred_pred_sales_volume_val_py
, NULL AS cbx_pred_pred_sales_piece_qty_py
, NULL AS cbx_pred_pred_sales_volume_val_swpy
, NULL AS cbx_pred_pred_sales_piece_qty_swpy
, NULL AS cbx_pred2_sales_volume_val
, NULL AS cbx_pred2_sales_piece_qty
, NULL AS cbx_pred2_sales_volume_val_py
, NULL AS cbx_pred2_sales_piece_qty_py
, NULL AS cbx_pred2_sales_volume_val_swpy
, NULL AS cbx_pred2_sales_piece_qty_swpy
, NULL AS cbx_succ_sales_volume_val
, NULL AS cbx_succ_sales_piece_qty
, NULL AS cbx_succ_sales_volume_val_py
, NULL AS cbx_succ_sales_piece_qty_py
, NULL AS cbx_succ_sales_volume_val_swpy
, NULL AS cbx_succ_sales_piece_qty_swpy
, NULL AS cbx_succ_succ_sales_volume_val
, NULL AS cbx_succ_succ_sales_piece_qty
, NULL AS cbx_succ_succ_sales_volume_val_py
, NULL AS cbx_succ_succ_sales_piece_qty_py
, NULL AS cbx_succ_succ_sales_volume_val_swpy
, NULL AS cbx_succ_succ_sales_piece_qty_swpy
, NULL AS cbx_succ2_sales_volume_val
, NULL AS cbx_succ2_sales_piece_qty
, NULL AS cbx_succ2_sales_volume_val_py
, NULL AS cbx_succ2_sales_piece_qty_py
, NULL AS cbx_succ2_sales_volume_val_swpy
, NULL AS cbx_succ2_sales_piece_qty_swpy
FROM cte_agg 

UNION ALL 

SELECT agg.client_id
, itm.item_sid
, cal_dt 
, NULL AS sales_volume_val       
, NULL AS sales_piece_qty   	 
, NULL AS sales_volume_val_py    
, NULL AS sales_piece_qty_py     
, NULL AS sales_volume_val_swpy  
, NULL AS sales_piece_qty_swpy   
, sales_volume_val        AS cbx_pred_sales_volume_val
, sales_piece_qty         AS cbx_pred_sales_piece_qty
, sales_volume_val_py     AS cbx_pred_sales_volume_val_py
, sales_piece_qty_py      AS cbx_pred_sales_piece_qty_py
, sales_volume_val_swpy   AS cbx_pred_sales_volume_val_swpy
, sales_piece_qty_swpy    AS cbx_pred_sales_piece_qty_swpy
, NULL AS cbx_pred_pred_sales_volume_val
, NULL AS cbx_pred_pred_sales_piece_qty
, NULL AS cbx_pred_pred_sales_volume_val_py
, NULL AS cbx_pred_pred_sales_piece_qty_py
, NULL AS cbx_pred_pred_sales_volume_val_swpy
, NULL AS cbx_pred_pred_sales_piece_qty_swpy
, NULL AS cbx_pred2_sales_volume_val
, NULL AS cbx_pred2_sales_piece_qty
, NULL AS cbx_pred2_sales_volume_val_py
, NULL AS cbx_pred2_sales_piece_qty_py
, NULL AS cbx_pred2_sales_volume_val_swpy
, NULL AS cbx_pred2_sales_piece_qty_swpy
, NULL AS cbx_succ_sales_volume_val
, NULL AS cbx_succ_sales_piece_qty
, NULL AS cbx_succ_sales_volume_val_py
, NULL AS cbx_succ_sales_piece_qty_py
, NULL AS cbx_succ_sales_volume_val_swpy
, NULL AS cbx_succ_sales_piece_qty_swpy
, NULL AS cbx_succ_succ_sales_volume_val
, NULL AS cbx_succ_succ_sales_piece_qty
, NULL AS cbx_succ_succ_sales_volume_val_py
, NULL AS cbx_succ_succ_sales_piece_qty_py
, NULL AS cbx_succ_succ_sales_volume_val_swpy
, NULL AS cbx_succ_succ_sales_piece_qty_swpy
, NULL AS cbx_succ2_sales_volume_val
, NULL AS cbx_succ2_sales_piece_qty
, NULL AS cbx_succ2_sales_volume_val_py
, NULL AS cbx_succ2_sales_piece_qty_py
, NULL AS cbx_succ2_sales_volume_val_swpy
, NULL AS cbx_succ2_sales_piece_qty_swpy
FROM cte_agg agg
JOIN cte_itm_cbx cbx
ON agg.client_id = cbx.client_id 
AND agg.item_sid = cbx.item_sid_pred
AND cbx.ITEM_REL_TYPE_CD LIKE 'PRED1'
JOIN cte_itm itm
ON cbx.client_id = itm.client_id
AND cbx.item_sid = itm.item_sid
AND nf_flg = 1

UNION ALL 

SELECT agg.client_id
, itm.item_sid
, cal_dt 
, NULL AS sales_volume_val       
, NULL AS sales_piece_qty   	 
, NULL AS sales_volume_val_py    
, NULL AS sales_piece_qty_py     
, NULL AS sales_volume_val_swpy  
, NULL AS sales_piece_qty_swpy   
, NULL AS cbx_pred_sales_volume_val
, NULL AS cbx_pred_sales_piece_qty
, NULL AS cbx_pred_sales_volume_val_py
, NULL AS cbx_pred_sales_piece_qty_py
, NULL AS cbx_pred_sales_volume_val_swpy
, NULL AS cbx_pred_sales_piece_qty_swpy
, sales_volume_val      AS cbx_pred_pred_sales_volume_val
, sales_piece_qty       AS cbx_pred_pred_sales_piece_qty
, sales_volume_val_py   AS cbx_pred_pred_sales_volume_val_py
, sales_piece_qty_py    AS cbx_pred_pred_sales_piece_qty_py
, sales_volume_val_swpy AS cbx_pred_pred_sales_volume_val_swpy
, sales_piece_qty_swpy  AS cbx_pred_pred_sales_piece_qty_swpy
, NULL AS cbx_pred2_sales_volume_val
, NULL AS cbx_pred2_sales_piece_qty
, NULL AS cbx_pred2_sales_volume_val_py
, NULL AS cbx_pred2_sales_piece_qty_py
, NULL AS cbx_pred2_sales_volume_val_swpy
, NULL AS cbx_pred2_sales_piece_qty_swpy
, NULL AS cbx_succ_sales_volume_val
, NULL AS cbx_succ_sales_piece_qty
, NULL AS cbx_succ_sales_volume_val_py
, NULL AS cbx_succ_sales_piece_qty_py
, NULL AS cbx_succ_sales_volume_val_swpy
, NULL AS cbx_succ_sales_piece_qty_swpy
, NULL AS cbx_succ_succ_sales_volume_val
, NULL AS cbx_succ_succ_sales_piece_qty
, NULL AS cbx_succ_succ_sales_volume_val_py
, NULL AS cbx_succ_succ_sales_piece_qty_py
, NULL AS cbx_succ_succ_sales_volume_val_swpy
, NULL AS cbx_succ_succ_sales_piece_qty_swpy
, NULL AS cbx_succ2_sales_volume_val
, NULL AS cbx_succ2_sales_piece_qty
, NULL AS cbx_succ2_sales_volume_val_py
, NULL AS cbx_succ2_sales_piece_qty_py
, NULL AS cbx_succ2_sales_volume_val_swpy
, NULL AS cbx_succ2_sales_piece_qty_swpy
FROM cte_agg agg
JOIN cte_itm_cbx cbx
ON agg.client_id = cbx.client_id 
AND agg.item_sid = cbx.item_sid_pred
AND cbx.ITEM_REL_TYPE_CD LIKE 'PRED1'

JOIN cte_itm_cbx cbx2
ON cbx.client_id = cbx2.client_id 
AND cbx.item_sid = cbx2.item_sid_pred
AND cbx2.ITEM_REL_TYPE_CD LIKE 'PRED1'

JOIN cte_itm itm
ON cbx2.client_id = itm.client_id
AND cbx2.item_sid = itm.item_sid
AND agg.item_sid <> itm.item_sid
AND nf_flg = 1
GROUP BY agg.client_id
, itm.item_sid
, cal_dt
, cbx_pred_pred_sales_volume_val
, cbx_pred_pred_sales_piece_qty
, cbx_pred_pred_sales_volume_val_py
, cbx_pred_pred_sales_piece_qty_py
, cbx_pred_pred_sales_volume_val_swpy
, cbx_pred_pred_sales_piece_qty_swpy 

UNION ALL 

SELECT agg.client_id
, itm.item_sid
, cal_dt 
, NULL AS sales_volume_val       
, NULL AS sales_piece_qty   	 
, NULL AS sales_volume_val_py    
, NULL AS sales_piece_qty_py     
, NULL AS sales_volume_val_swpy  
, NULL AS sales_piece_qty_swpy   
, NULL AS cbx_pred_sales_volume_val
, NULL AS cbx_pred_sales_piece_qty
, NULL AS cbx_pred_sales_volume_val_py
, NULL AS cbx_pred_sales_piece_qty_py
, NULL AS cbx_pred_sales_volume_val_swpy
, NULL AS cbx_pred_sales_piece_qty_swpy
, NULL AS cbx_pred_pred_sales_volume_val
, NULL AS cbx_pred_pred_sales_piece_qty
, NULL AS cbx_pred_pred_sales_volume_val_py
, NULL AS cbx_pred_pred_sales_piece_qty_py
, NULL AS cbx_pred_pred_sales_volume_val_swpy
, NULL AS cbx_pred_pred_sales_piece_qty_swpy
, sales_volume_val      AS cbx_pred2_sales_volume_val
, sales_piece_qty       AS cbx_pred2_sales_piece_qty
, sales_volume_val_py   AS cbx_pred2_sales_volume_val_py
, sales_piece_qty_py    AS cbx_pred2_sales_piece_qty_py
, sales_volume_val_swpy AS cbx_pred2_sales_volume_val_swpy
, sales_piece_qty_swpy  AS cbx_pred2_sales_piece_qty_swpy
, NULL AS cbx_succ_sales_volume_val
, NULL AS cbx_succ_sales_piece_qty
, NULL AS cbx_succ_sales_volume_val_py
, NULL AS cbx_succ_sales_piece_qty_py
, NULL AS cbx_succ_sales_volume_val_swpy
, NULL AS cbx_succ_sales_piece_qty_swpy
, NULL AS cbx_succ_succ_sales_volume_val
, NULL AS cbx_succ_succ_sales_piece_qty
, NULL AS cbx_succ_succ_sales_volume_val_py
, NULL AS cbx_succ_succ_sales_piece_qty_py
, NULL AS cbx_succ_succ_sales_volume_val_swpy
, NULL AS cbx_succ_succ_sales_piece_qty_swpy
, NULL AS cbx_succ2_sales_volume_val
, NULL AS cbx_succ2_sales_piece_qty
, NULL AS cbx_succ2_sales_volume_val_py
, NULL AS cbx_succ2_sales_piece_qty_py
, NULL AS cbx_succ2_sales_volume_val_swpy
, NULL AS cbx_succ2_sales_piece_qty_swpy
FROM cte_agg agg
JOIN cte_itm_cbx cbx
ON agg.client_id = cbx.client_id 
AND agg.item_sid = cbx.item_sid_pred
AND cbx.ITEM_REL_TYPE_CD LIKE 'PRED2'
JOIN cte_itm itm
ON cbx.client_id = itm.client_id
AND cbx.item_sid = itm.item_sid
AND nf_flg = 1

UNION ALL 

SELECT agg.client_id
, itm.item_sid
, cal_dt 
, NULL AS sales_volume_val       
, NULL AS sales_piece_qty   	 
, NULL AS sales_volume_val_py    
, NULL AS sales_piece_qty_py     
, NULL AS sales_volume_val_swpy  
, NULL AS sales_piece_qty_swpy   
, NULL AS cbx_pred_sales_volume_val
, NULL AS cbx_pred_sales_piece_qty
, NULL AS cbx_pred_sales_volume_val_py
, NULL AS cbx_pred_sales_piece_qty_py
, NULL AS cbx_pred_sales_volume_val_swpy
, NULL AS cbx_pred_sales_piece_qty_swpy
, NULL AS cbx_pred_pred_sales_volume_val
, NULL AS cbx_pred_pred_sales_piece_qty
, NULL AS cbx_pred_pred_sales_volume_val_py
, NULL AS cbx_pred_pred_sales_piece_qty_py
, NULL AS cbx_pred_pred_sales_volume_val_swpy
, NULL AS cbx_pred_pred_sales_piece_qty_swpy
, NULL AS cbx_pred2_sales_volume_val
, NULL AS cbx_pred2_sales_piece_qty
, NULL AS cbx_pred2_sales_volume_val_py
, NULL AS cbx_pred2_sales_piece_qty_py
, NULL AS cbx_pred2_sales_volume_val_swpy
, NULL AS cbx_pred2_sales_piece_qty_swpy
, sales_volume_val        AS cbx_succ_sales_volume_val
, sales_piece_qty         AS cbx_succ_sales_piece_qty
, sales_volume_val_py     AS cbx_succ_sales_volume_val_py
, sales_piece_qty_py      AS cbx_succ_sales_piece_qty_py
, sales_volume_val_swpy   AS cbx_succ_sales_volume_val_swpy
, sales_piece_qty_swpy    AS cbx_succ_sales_piece_qty_swpy
, NULL AS cbx_succ_succ_sales_volume_val
, NULL AS cbx_succ_succ_sales_piece_qty
, NULL AS cbx_succ_succ_sales_volume_val_py
, NULL AS cbx_succ_succ_sales_piece_qty_py
, NULL AS cbx_succ_succ_sales_volume_val_swpy
, NULL AS cbx_succ_succ_sales_piece_qty_swpy
, NULL AS cbx_succ2_sales_volume_val
, NULL AS cbx_succ2_sales_piece_qty
, NULL AS cbx_succ2_sales_volume_val_py
, NULL AS cbx_succ2_sales_piece_qty_py
, NULL AS cbx_succ2_sales_volume_val_swpy
, NULL AS cbx_succ2_sales_piece_qty_swpy
FROM cte_agg agg
JOIN cte_itm_cbx cbx
ON agg.client_id = cbx.client_id 
AND agg.item_sid = cbx.item_sid
AND cbx.ITEM_REL_TYPE_CD LIKE 'PRED1'
JOIN cte_itm itm
ON cbx.client_id = itm.client_id
AND cbx.item_sid_pred = itm.item_sid
AND nf_flg = 1

UNION ALL

SELECT agg.client_id
, itm.item_sid
, cal_dt 
, NULL AS sales_volume_val       
, NULL AS sales_piece_qty   	 
, NULL AS sales_volume_val_py    
, NULL AS sales_piece_qty_py     
, NULL AS sales_volume_val_swpy  
, NULL AS sales_piece_qty_swpy   
, NULL AS cbx_pred_sales_volume_val
, NULL AS cbx_pred_sales_piece_qty
, NULL AS cbx_pred_sales_volume_val_py
, NULL AS cbx_pred_sales_piece_qty_py
, NULL AS cbx_pred_sales_volume_val_swpy
, NULL AS cbx_pred_sales_piece_qty_swpy
, NULL AS cbx_pred_pred_sales_volume_val
, NULL AS cbx_pred_pred_sales_piece_qty
, NULL AS cbx_pred_pred_sales_volume_val_py
, NULL AS cbx_pred_pred_sales_piece_qty_py
, NULL AS cbx_pred_pred_sales_volume_val_swpy
, NULL AS cbx_pred_pred_sales_piece_qty_swpy
, NULL AS cbx_pred2_sales_volume_val
, NULL AS cbx_pred2_sales_piece_qty
, NULL AS cbx_pred2_sales_volume_val_py
, NULL AS cbx_pred2_sales_piece_qty_py
, NULL AS cbx_pred2_sales_volume_val_swpy
, NULL AS cbx_pred2_sales_piece_qty_swpy
, NULL AS cbx_succ_sales_volume_val
, NULL AS cbx_succ_sales_piece_qty
, NULL AS cbx_succ_sales_volume_val_py
, NULL AS cbx_succ_sales_piece_qty_py
, NULL AS cbx_succ_sales_volume_val_swpy
, NULL AS cbx_succ_sales_piece_qty_swpy
, sales_volume_val      AS cbx_succ_succ_sales_volume_val
, sales_piece_qty       AS cbx_succ_succ_sales_piece_qty
, sales_volume_val_py   AS cbx_succ_succ_sales_volume_val_py
, sales_piece_qty_py    AS cbx_succ_succ_sales_piece_qty_py
, sales_volume_val_swpy AS cbx_succ_succ_sales_volume_val_swpy
, sales_piece_qty_swpy  AS cbx_succ_succ_sales_piece_qty_swpy
, NULL AS cbx_succ2_sales_volume_val
, NULL AS cbx_succ2_sales_piece_qty
, NULL AS cbx_succ2_sales_volume_val_py
, NULL AS cbx_succ2_sales_piece_qty_py
, NULL AS cbx_succ2_sales_volume_val_swpy
, NULL AS cbx_succ2_sales_piece_qty_swpy
FROM cte_agg agg
JOIN cte_itm_cbx cbx
ON agg.client_id = cbx.client_id 
AND agg.item_sid = cbx.item_sid
AND cbx.ITEM_REL_TYPE_CD LIKE 'PRED1'

JOIN cte_itm_cbx cbx2
ON cbx.client_id = cbx2.client_id 
AND cbx.item_sid_pred = cbx2.item_sid
AND cbx2.ITEM_REL_TYPE_CD LIKE 'PRED1'

JOIN cte_itm itm
ON cbx2.client_id = itm.client_id
AND cbx2.item_sid_pred = itm.item_sid
AND agg.item_sid <> itm.item_sid
AND nf_flg = 1
GROUP BY agg.client_id
, itm.item_sid
, cal_dt
, cbx_succ_succ_sales_volume_val
, cbx_succ_succ_sales_piece_qty
, cbx_succ_succ_sales_volume_val_py
, cbx_succ_succ_sales_piece_qty_py
, cbx_succ_succ_sales_volume_val_swpy
, cbx_succ_succ_sales_piece_qty_swpy 

UNION ALL 

SELECT agg.client_id
, itm.item_sid
, cal_dt 
, NULL AS sales_volume_val       
, NULL AS sales_piece_qty   	 
, NULL AS sales_volume_val_py    
, NULL AS sales_piece_qty_py     
, NULL AS sales_volume_val_swpy  
, NULL AS sales_piece_qty_swpy   
, NULL AS cbx_pred_sales_volume_val
, NULL AS cbx_pred_sales_piece_qty
, NULL AS cbx_pred_sales_volume_val_py
, NULL AS cbx_pred_sales_piece_qty_py
, NULL AS cbx_pred_sales_volume_val_swpy
, NULL AS cbx_pred_sales_piece_qty_swpy
, NULL AS cbx_pred_pred_sales_volume_val
, NULL AS cbx_pred_pred_sales_piece_qty
, NULL AS cbx_pred_pred_sales_volume_val_py
, NULL AS cbx_pred_pred_sales_piece_qty_py
, NULL AS cbx_pred_pred_sales_volume_val_swpy
, NULL AS cbx_pred_pred_sales_piece_qty_swpy
, NULL AS cbx_pred2_sales_volume_val
, NULL AS cbx_pred2_sales_piece_qty
, NULL AS cbx_pred2_sales_volume_val_py
, NULL AS cbx_pred2_sales_piece_qty_py
, NULL AS cbx_pred2_sales_volume_val_swpy
, NULL AS cbx_pred2_sales_piece_qty_swpy
, NULL AS cbx_succ_sales_volume_val
, NULL AS cbx_succ_sales_piece_qty
, NULL AS cbx_succ_sales_volume_val_py
, NULL AS cbx_succ_sales_piece_qty_py
, NULL AS cbx_succ_sales_volume_val_swpy
, NULL AS cbx_succ_sales_piece_qty_swpy
, NULL AS cbx_succ_succ_sales_volume_val
, NULL AS cbx_succ_succ_sales_piece_qty
, NULL AS cbx_succ_succ_sales_volume_val_py
, NULL AS cbx_succ_succ_sales_piece_qty_py
, NULL AS cbx_succ_succ_sales_volume_val_swpy
, NULL AS cbx_succ_succ_sales_piece_qty_swpy
, sales_volume_val      AS cbx_succ2_sales_volume_val
, sales_piece_qty       AS cbx_succ2_sales_piece_qty
, sales_volume_val_py   AS cbx_succ2_sales_volume_val_py
, sales_piece_qty_py    AS cbx_succ2_sales_piece_qty_py
, sales_volume_val_swpy AS cbx_succ2_sales_volume_val_swpy
, sales_piece_qty_swpy  AS cbx_succ2_sales_piece_qty_swpy
FROM cte_agg agg
JOIN cte_itm_cbx cbx
ON agg.client_id = cbx.client_id 
AND agg.item_sid = cbx.item_sid
AND cbx.ITEM_REL_TYPE_CD LIKE 'PRED2'
JOIN cte_itm itm
ON cbx.client_id = itm.client_id
AND cbx.item_sid_pred = itm.item_sid
AND nf_flg = 1
)
SELECT 
  client_id
, item_sid
, cal_dt AS dat_fordmate
, SUM(sales_volume_val                    )   AS sales_volume_val                    
, SUM(sales_piece_qty   	              )   AS sales_piece_qty   	             
, SUM(sales_volume_val_py                 )   AS sales_volume_val_py                
, SUM(sales_piece_qty_py                  )   AS sales_piece_qty_py                 
, SUM(sales_volume_val_swpy               )   AS sales_volume_val_swpy              
, SUM(sales_piece_qty_swpy                )   AS sales_piece_qty_swpy               
, SUM(cbx_pred_sales_volume_val           )   AS cbx_pred_sales_volume_val          
, SUM(cbx_pred_sales_piece_qty            )   AS cbx_pred_sales_piece_qty           
, SUM(cbx_pred_sales_volume_val_py        )   AS cbx_pred_sales_volume_val_py       
, SUM(cbx_pred_sales_piece_qty_py         )   AS cbx_pred_sales_piece_qty_py        
, SUM(cbx_pred_sales_volume_val_swpy      )   AS cbx_pred_sales_volume_val_swpy     
, SUM(cbx_pred_sales_piece_qty_swpy       )   AS cbx_pred_sales_piece_qty_swpy      
, SUM(cbx_pred_pred_sales_volume_val      )   AS cbx_pred_pred_sales_volume_val     
, SUM(cbx_pred_pred_sales_piece_qty       )   AS cbx_pred_pred_sales_piece_qty      
, SUM(cbx_pred_pred_sales_volume_val_py   )   AS cbx_pred_pred_sales_volume_val_py  
, SUM(cbx_pred_pred_sales_piece_qty_py    )   AS cbx_pred_pred_sales_piece_qty_py   
, SUM(cbx_pred_pred_sales_volume_val_swpy )   AS cbx_pred_pred_sales_volume_val_swpy
, SUM(cbx_pred_pred_sales_piece_qty_swpy  )   AS cbx_pred_pred_sales_piece_qty_swpy 
, SUM(cbx_pred2_sales_volume_val          )   AS cbx_pred2_sales_volume_val         
, SUM(cbx_pred2_sales_piece_qty           )   AS cbx_pred2_sales_piece_qty          
, SUM(cbx_pred2_sales_volume_val_py       )   AS cbx_pred2_sales_volume_val_py      
, SUM(cbx_pred2_sales_piece_qty_py        )   AS cbx_pred2_sales_piece_qty_py       
, SUM(cbx_pred2_sales_volume_val_swpy     )   AS cbx_pred2_sales_volume_val_swpy    
, SUM(cbx_pred2_sales_piece_qty_swpy      )   AS cbx_pred2_sales_piece_qty_swpy     
, SUM(cbx_succ_sales_volume_val           )   AS cbx_succ_sales_volume_val                    
, SUM(cbx_succ_sales_piece_qty            )   AS cbx_succ_sales_piece_qty
, SUM(cbx_succ_sales_volume_val_py        )   AS cbx_succ_sales_volume_val_py
, SUM(cbx_succ_sales_piece_qty_py         )   AS cbx_succ_sales_piece_qty_py
, SUM(cbx_succ_sales_volume_val_swpy      )   AS cbx_succ_sales_volume_val_swpy
, SUM(cbx_succ_sales_piece_qty_swpy       )   AS cbx_succ_sales_piece_qty_swpy
, SUM(cbx_succ_succ_sales_volume_val      )   AS cbx_succ_succ_sales_volume_val
, SUM(cbx_succ_succ_sales_piece_qty       )   AS cbx_succ_succ_sales_piece_qty
, SUM(cbx_succ_succ_sales_volume_val_py   )   AS cbx_succ_succ_sales_volume_val_py
, SUM(cbx_succ_succ_sales_piece_qty_py    )   AS cbx_succ_succ_sales_piece_qty_py
, SUM(cbx_succ_succ_sales_volume_val_swpy )   AS cbx_succ_succ_sales_volume_val_swpy 
, SUM(cbx_succ_succ_sales_piece_qty_swpy  )   AS cbx_succ_succ_sales_piece_qty_swpy
, SUM(cbx_succ2_sales_volume_val          )   AS cbx_succ2_sales_volume_val
, SUM(cbx_succ2_sales_piece_qty           )   AS cbx_succ2_sales_piece_qty
, SUM(cbx_succ2_sales_volume_val_py       )   AS cbx_succ2_sales_volume_val_py
, SUM(cbx_succ2_sales_piece_qty_py        )   AS cbx_succ2_sales_piece_qty_py
, SUM(cbx_succ2_sales_volume_val_swpy     )   AS cbx_succ2_sales_volume_val_swpy
, SUM(cbx_succ2_sales_piece_qty_swpy      )   AS cbx_succ2_sales_piece_qty_swpy    
FROM cte_agg_all
GROUP BY   
  client_id
, item_sid
, cal_dt;    
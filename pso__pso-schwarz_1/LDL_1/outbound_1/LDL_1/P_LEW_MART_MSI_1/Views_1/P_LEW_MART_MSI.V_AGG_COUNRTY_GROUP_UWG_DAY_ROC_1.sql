/* #----------------------------------------------------------------------------
# History:
#  1.0  18.07.2022    Oliver Haus         Initial DDL deployment - RWL aggregated values for Cockpits
#  1.1  10.07.2023    Chetana Patil       Added logic for RWL_WEIGHTED_VJ  
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_counrty_group_uwg_day_roc_1
OPTIONS(DESCRIPTION = `AGGREGATED VIEW ON COUNRTYGROUP-UWG-LEVEL FOR RWL IN COCKPITS`) AS WITH BASE AS (SELECT WH.country_group_id
   ,
   ITM.subitemgroup_id,
   ROC.dat_formdate,
   ROC.currency_iso_cd,
   SUM(ROC.qty_piece_ep_wh) AS qty_piece_stc_wh,
   SUM(ROC.rwl_nominator) AS rwl_nominator,
    SUM(ROC.rwl_nominator) / SUM(ROC.qty_piece_ep_wh) AS rwl_weighted
  FROM ldl_p_lew_mart_msi.v_itm_item_wh_day_roc_1 AS ROC
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge_1 AS WH ON ROC.client_id = WH.client_id AND ROC.wh_id = WH.wh_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_item_1 AS ITM ON ROC.client_id = ITM.client_id AND ROC.item_id = ITM.item_id
  WHERE ROC.flags_combined = '0000'
   AND WH.aspect_id = 1
   AND ITM.subitemgroup_id IN (74, 78) -- ONLY BACKOFF & HOTCONVINIENCE

  GROUP BY ROC.dat_formdate,
   ROC.currency_iso_cd,
   WH.country_group_id,
   ITM.subitemgroup_id), VORJAHRESWERTE AS (SELECT WH1.country_group_id,
   ITM0.subitemgroup_id,
   V02.cal_dt AS dat_formdate,
   ROC0.currency_iso_cd,
    SUM(ROC0.rwl_nominator) / SUM(ROC0.qty_piece_ep_wh) AS rwl_weighted_vj
  FROM ldl_p_lew_mart_msi.v_itm_item_wh_day_roc_1 AS ROC0
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge_1 AS WH1 ON ROC0.client_id = WH1.client_id AND ROC0.wh_id = WH1.wh_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_item_1 AS ITM0 ON ROC0.client_id = ITM0.client_id AND ROC0.item_id = ITM0.item_id
     
   INNER JOIN ldl_p_lew_mart_lead_ac.v_dim_cal_day_1 AS V02 ON ROC0.dat_formdate = V02.cal_dt_prev_1y
  WHERE ROC0.flags_combined = '0000'
   AND WH1.aspect_id = 1
   AND ITM0.subitemgroup_id IN (74, 78) -- ONLY BACKOFF & HOTCONVINIENCE

  GROUP BY WH1.country_group_id,
   ITM0.subitemgroup_id,
   dat_formdate,
   ROC0.currency_iso_cd) (SELECT COALESCE(t3.country_group_id, VJ.country_group_id) AS country_group_id,
   WH0.client_id,
   COALESCE(t3.subitemgroup_id, VJ.subitemgroup_id) AS subitemgroup_id,
   COALESCE(t3.dat_formdate, VJ.dat_formdate) AS dat_formdate,
   COALESCE(t3.currency_iso_cd, VJ.currency_iso_cd) AS currency_iso_cd,
   t3.qty_piece_stc_wh -- ON LEVEL LAENDERGRUPPE_UWG
,
   t3.rwl_nominator -- ON LEVEL LAENDERGRUPPE_UWG
,
   t3.rwl_weighted -- ON LEVEL LAENDERGRUPPE_UWG
,
   VJ.rwl_weighted_vj -- ON LEVEL LAENDERGRUPPE_UWG

  FROM BASE AS t3
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge_1 AS WH0 ON t3.country_group_id = WH0.country_group_id
   FULL JOIN VORJAHRESWERTE AS VJ ON t3.country_group_id = VJ.country_group_id AND t3.currency_iso_cd = VJ.currency_iso_cd
        AND t3.dat_formdate = VJ.dat_formdate AND t3.subitemgroup_id = VJ.subitemgroup_id);
/* #----------------------------------------------------------------------------
# History:
#  1.0  18.07.2022    Oliver Haus         Initial DDL deployment - RWL aggregated values for Cockpits
#  1.1  10.07.2023    Chetana Patil       Added logic for RWL_WEIGHTED_VJ  
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_int_day_roc_2
OPTIONS(DESCRIPTION = `AGGREGATED VIEW ON INTERNATIONAL-LEVEL FOR RWL IN COCKPITS`) AS WITH BASE AS (SELECT WH.int_id,
   ROC.dat_formdate,
   ROC.currency_iso_cd,
   SUM(ROC.qty_piece_ep_wh) AS qty_piece_stc_wh,
   SUM(ROC.rwl_nominator) AS rwl_nominator,
    SUM(ROC.rwl_nominator) / SUM(ROC.qty_piece_ep_wh) AS rwl_weighted
  FROM ldl_p_lew_mart_msi.v_itm_item_wh_day_roc_2 AS ROC
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge_2 AS WH ON ROC.client_id = WH.client_id AND ROC.wh_id = WH.wh_id
  WHERE ROC.flags_combined = '0000'
   AND WH.aspect_id = 1
  GROUP BY ROC.dat_formdate,
   ROC.currency_iso_cd,
   WH.int_id), VORJAHRESWERTE AS (SELECT WH0.int_id,
   V02.cal_dt AS dat_formdate,
   V01.currency_iso_cd,
    SUM(V01.rwl_nominator) / SUM(V01.qty_piece_ep_wh) AS rwl_weighted_vj
  FROM ldl_p_lew_mart_msi.v_itm_item_wh_day_roc_2 AS V01
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge_2 AS WH0 ON V01.client_id = WH0.client_id AND V01.wh_id = WH0.wh_id
   INNER JOIN ldl_p_lew_mart_lead_ac.v_dim_cal_day_2 AS V02 ON V01.dat_formdate = V02.cal_dt_prev_1y
  WHERE V01.flags_combined = '0000'
   AND WH0.aspect_id = 1
  GROUP BY WH0.int_id,
   dat_formdate,
   V01.currency_iso_cd) (SELECT COALESCE(t3.int_id, VJ.int_id) AS int_id,
   WH1.client_id,
   COALESCE(t3.dat_formdate, VJ.dat_formdate) AS dat_formdate,
   COALESCE(t3.currency_iso_cd, VJ.currency_iso_cd) AS currency_iso_cd,
   t3.qty_piece_stc_wh -- ON LEVEL INTEGER
,
   t3.rwl_nominator -- ON LEVEL INTEGER
,
   t3.rwl_weighted -- ON LEVEL INTEGER
,
   VJ.rwl_weighted_vj
  FROM BASE AS t3
   FULL JOIN VORJAHRESWERTE AS VJ ON t3.int_id = VJ.int_id AND t3.currency_iso_cd = VJ.currency_iso_cd AND t3.dat_formdate
      = VJ.dat_formdate
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge_2 AS WH1 ON t3.int_id = WH1.int_id);

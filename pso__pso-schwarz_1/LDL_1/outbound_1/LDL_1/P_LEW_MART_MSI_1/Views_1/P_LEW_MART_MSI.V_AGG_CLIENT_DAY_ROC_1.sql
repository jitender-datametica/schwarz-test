/* #----------------------------------------------------------------------------
# History:
#  1.0  18.07.2022    Oliver Haus         Initial DDL deployment - RWL aggregated values for Cockpits
#  1.1  10.07.2023    Chetana Patil       Added logic for RWL_WEIGHTED_VJ  
#  1.2  07.09.2023    Chetana Patil       AP0112191 - Added CROSS JOIN with V_ORG_WH_MERGE_1
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_client_day_roc_1
OPTIONS(DESCRIPTION = `AGGREGATED VIEW ON CLIENT-LEVEL FOR RWL IN COCKPITS`) AS WITH MAINFACTTABLE AS (SELECT COALESCE(THISYEAR
    .client_id, VJ.client_id) AS client_id,
   COALESCE(THISYEAR.dat_formdate, VJ.dat_formdate) AS dat_formdate,
   COALESCE(THISYEAR.currency_iso_cd, VJ.currency_iso_cd) AS currency_iso_cd,
   SUM(THISYEAR.qty_piece_stc_wh) AS qty_piece_stc_wh,
   SUM(THISYEAR.rwl_nominator) AS rwl_nominator,
   SUM(THISYEAR.rwl_weighted) AS rwl_weighted,
   SUM(VJ.rwl_weighted_vj) AS rwl_weighted_vj
  FROM (SELECT ROC.client_id,
     ROC.dat_formdate,
     ROC.currency_iso_cd,
     SUM(ROC.qty_piece_ep_wh) AS qty_piece_stc_wh,
     SUM(ROC.rwl_nominator) AS rwl_nominator,
      SUM(ROC.rwl_nominator) / SUM(ROC.qty_piece_ep_wh) AS rwl_weighted
    FROM ldl_p_lew_mart_msi.v_itm_item_wh_day_roc_1 AS ROC
     INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge_1 AS WH ON ROC.client_id = WH.client_id AND ROC.wh_id = WH.wh_id
    WHERE ROC.flags_combined = '0000'
     AND WH.aspect_id = 1
    GROUP BY ROC.client_id,
     ROC.dat_formdate,
     ROC.currency_iso_cd) AS THISYEAR
   FULL JOIN (SELECT ROC0.client_id,
     WEEK_BER.cal_dt AS dat_formdate,
     ROC0.currency_iso_cd,
      SUM(ROC0.rwl_nominator) / SUM(ROC0.qty_piece_ep_wh) AS rwl_weighted_vj
    FROM ldl_p_lew_mart_msi.v_itm_item_wh_day_roc_1 AS ROC0
     INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge_1 AS WH0 ON ROC0.client_id = WH0.client_id AND ROC0.wh_id = WH0.wh_id
       
     INNER JOIN ldl_p_lew_mart_lead_ac.v_dim_cal_day_1 AS WEEK_BER ON ROC0.dat_formdate = WEEK_BER.cal_dt_prev_1y
    WHERE ROC0.flags_combined = '0000'
     AND WH0.aspect_id = 1
    GROUP BY ROC0.client_id,
     dat_formdate,
     ROC0.currency_iso_cd) AS VJ ON THISYEAR.client_id = VJ.client_id AND THISYEAR.dat_formdate = VJ.dat_formdate AND
     THISYEAR.currency_iso_cd = VJ.currency_iso_cd
  GROUP BY client_id,
   dat_formdate,
   currency_iso_cd) (SELECT *
  FROM MAINFACTTABLE AS FCT);
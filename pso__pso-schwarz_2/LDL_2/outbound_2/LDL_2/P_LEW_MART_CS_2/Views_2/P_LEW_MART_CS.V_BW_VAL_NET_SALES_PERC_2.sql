/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_VAL_NET_SALES_PERC_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_val_net_sales_perc_2 (client_id, iso_cd, cy_month, kpi_aspect, wh_id,
wh_descr, v_id, v_descr, currency_iso_cd, brand_descr, wgi, turnover, total_turnover, turnover_percent) AS SELECT AGG.client_id
 ,
 CL.src_country_lidl_cd AS iso_cd,
 AGG.cy_month,
  CASE
  WHEN t0.aspect_id = 1
  THEN 'BGES'
  ELSE 'VGES'
  END AS kpi_aspect,
  CASE
  WHEN t0.aspect_id = 1
  THEN WH.src_wh_id
  ELSE NULL
  END AS wh_id,
  CASE
  WHEN t0.aspect_id = 1
  THEN t0.wh_desc
  ELSE NULL
  END AS wh_descr,
  CASE
  WHEN t0.aspect_id = 2
  THEN WH.src_wh_id
  ELSE NULL
  END AS v_id,
  CASE
  WHEN t0.aspect_id = 2
  THEN t0.wh_desc
  ELSE NULL
  END AS v_descr,
 CL.curr_cd AS currency_iso_cd,
  CASE
  WHEN ITM.brand_type_id = 1
  THEN 'M'
  ELSE 'EM'
  END AS brand_descr,
 SIG.item_grp_int_cd AS wgi,
  SUM(AGG.sales_net_val) + SUM(AGG.return_net_val) AS turnover,
 SUM(SUM(AGG.sales_net_val) + SUM(AGG.return_net_val)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(AGG.cy_month AS STRING)
    , WH.src_wh_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_turnover,
  CAST((SUM(AGG.sales_net_val) + SUM(AGG.return_net_val)) * 100 AS BIGNUMERIC) / NULLIF(CAST(SUM(SUM(AGG.sales_net_val) + SUM(AGG.return_net_val)) OVER (PARTITION BY CAST(AGG.client_id AS STRING)
       , CAST(AGG.cy_month AS STRING), WH.src_wh_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
    BIGNUMERIC), 0) AS turnover_percent
FROM ldl_p_lew_bil_ac.v_agg_pos_wh_mth_item_asis_2 AS AGG
 INNER JOIN (SELECT client_id,
   wh_loc_sid,
   aspect_id,
   wh_desc
  FROM ldl_p_lew_core_ac.v_wawi_org_wh_merge_act_2
  QUALIFY (COUNT(*) OVER (PARTITION BY CAST(wh_loc_sid AS STRING) ORDER BY aspect_id IS NULL, aspect_id ROWS BETWEEN
      UNBOUNDED PRECEDING AND CURRENT ROW)) = 1) AS t0 ON AGG.client_id = t0.client_id AND AGG.loc_sid_wh = t0.wh_loc_sid
   
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON AGG.client_id = WH.client_id AND AGG.loc_sid_wh = WH.loc_sid_wh AND
   CURRENT_DATE BETWEEN WH.dwh_valid_from AND WH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_cal_busyear_2 AS BUS ON AGG.cy_month BETWEEN BUS.busyear_begin_month AND BUS.busyear_end_month
    AND BUS.cy_by_seq IN (0, - 1)
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS IH ON AGG.client_id = IH.client_id AND AGG.item_sid = IH.item_sid AND
   CURRENT_DATE BETWEEN IH.dwh_valid_from AND IH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_2 AS FGH ON AGG.client_id = FGH.client_id AND IH.item_fam_grp_sid =
    FGH.item_fam_grp_sid AND CURRENT_DATE BETWEEN FGH.dwh_valid_from AND FGH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist_2 AS SIG ON AGG.client_id = SIG.client_id AND FGH.sub_item_grp_sid = SIG
    .sub_item_grp_sid AND CURRENT_DATE BETWEEN SIG.dwh_valid_from AND SIG.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS ITM ON AGG.client_id = ITM.client_id AND AGG.item_sid = ITM.item_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CL ON AGG.client_id = CL.client_id
GROUP BY AGG.client_id,
 AGG.cy_month,
 t0.aspect_id,
 ITM.brand_type_id,
 wgi,
 currency_iso_cd,
 iso_cd,
 WH.src_wh_id,
 t0.wh_desc
UNION ALL
SELECT AGG.client_id,
 CL.src_country_lidl_cd AS iso_cd,
 AGG.cy_month,
 'LAND_2' AS kpi_aspect,
 CAST(NULL AS BIGNUMERIC) AS wh_id,
 CAST(NULL AS STRING) AS wh_descr,
 CAST(NULL AS BIGNUMERIC) AS v_id,
 CAST(NULL AS STRING) AS v_descr,
 CL.curr_cd AS currency_iso_cd,
  CASE
  WHEN ITM.brand_type_id = 1
  THEN 'M'
  ELSE 'EM'
  END AS brand_descr,
 SIG.item_grp_int_cd AS wgi,
  SUM(AGG.sales_net_val) + SUM(AGG.return_net_val) AS turnover,
 SUM(SUM(AGG.sales_net_val) + SUM(AGG.return_net_val)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(AGG.cy_month AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_turnover,
  CAST((SUM(AGG.sales_net_val) + SUM(AGG.return_net_val)) * 100 AS BIGNUMERIC) / NULLIF(CAST(SUM(SUM(AGG.sales_net_val) + SUM(AGG.return_net_val)) OVER (PARTITION BY CAST(AGG.client_id AS STRING)
       , CAST(AGG.cy_month AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS BIGNUMERIC), 0) AS
 turnover_percent
FROM ldl_p_lew_bil_ac.v_agg_pos_wh_mth_item_asis_2 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_cal_busyear_2 AS BUS ON AGG.cy_month BETWEEN BUS.busyear_begin_month AND BUS.busyear_end_month
    AND BUS.cy_by_seq IN (0, - 1)
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS IH ON AGG.client_id = IH.client_id AND AGG.item_sid = IH.item_sid AND
   CURRENT_DATE BETWEEN IH.dwh_valid_from AND IH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_2 AS FGH ON AGG.client_id = FGH.client_id AND IH.item_fam_grp_sid =
    FGH.item_fam_grp_sid AND CURRENT_DATE BETWEEN FGH.dwh_valid_from AND FGH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist_2 AS SIG ON AGG.client_id = SIG.client_id AND FGH.sub_item_grp_sid = SIG
    .sub_item_grp_sid AND CURRENT_DATE BETWEEN SIG.dwh_valid_from AND SIG.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS ITM ON AGG.client_id = ITM.client_id AND AGG.item_sid = ITM.item_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CL ON AGG.client_id = CL.client_id
GROUP BY AGG.client_id,
 AGG.cy_month,
 ITM.brand_type_id,
 wgi,
 iso_cd,
 currency_iso_cd;
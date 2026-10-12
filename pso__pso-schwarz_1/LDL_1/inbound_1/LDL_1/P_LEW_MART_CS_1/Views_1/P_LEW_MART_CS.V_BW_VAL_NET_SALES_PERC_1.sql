/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_VAL_NET_SALES_PERC_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_VAL_NET_SALES_PERC_1
(
  client_id
 ,iso_cd
 ,cy_month
 ,kpi_aspect
 ,wh_id
 ,wh_descr
 ,v_id
 ,v_descr
 ,currency_iso_cd
 ,brand_descr
 ,wgi
 ,turnover
 ,total_turnover
 ,turnover_percent
 )
AS
(SELECT
agg.client_id                                                                                            AS client_id,
cl.src_country_lidl_cd                                                                                  AS iso_cd,
agg.cy_month                                                                                            AS cy_month,
CASE WHEN whm.aspect_id = 1 THEN 'BGES' ELSE 'VGES' END                                                 AS kpi_aspect,
CASE WHEN whm.aspect_id = 1 THEN wh.src_wh_id ELSE NULL END                                             AS wh_id,
CASE WHEN whm.aspect_id = 1 THEN whm.wh_desc  ELSE NULL END                                             AS wh_descr,
CASE WHEN whm.aspect_id = 2 THEN wh.src_wh_id ELSE NULL END                                             AS v_id,
CASE WHEN whm.aspect_id = 2 THEN whm.wh_desc  ELSE NULL END                                             AS v_descr,
cl.curr_cd                                                                                              AS currency_iso_cd,
CASE WHEN itm.brand_type_id = 1 THEN 'M' ELSE 'EM' END                                                  AS brand_descr,
sig.item_grp_int_cd                                                                                     AS wgi,
SUM(agg.sales_net_val) + SUM(agg.return_net_val)                                                        AS turnover,
SUM(turnover) OVER (PARTITION BY agg.client_id, agg.cy_month, wh.src_wh_id)                             AS total_turnover,
(CAST((turnover * 100) AS DECIMAL(38,10))/NULLIF(CAST(total_turnover AS DECIMAL(38,10)),0))             AS turnover_percent
FROM p_lew_bil_ac.v_agg_pos_wh_mth_item_asis_1 agg
INNER JOIN (SELECT
client_id,
wh_loc_sid,
aspect_id,
wh_desc
FROM p_lew_core_ac.v_wawi_org_wh_merge_act_1
QUALIFY COUNT(*) OVER (PARTITION BY wh_loc_sid ORDER BY aspect_id ROWS UNBOUNDED PRECEDING) = 1
) AS whm
ON agg.client_id = whm.client_id
AND agg.loc_sid_wh = whm.wh_loc_sid
INNER JOIN p_lew_bil_ac.v_warehouse_1 wh
ON agg.client_id = wh.client_id
   AND agg.loc_sid_wh = wh.loc_sid_wh
   AND CURRENT_DATE BETWEEN wh.dwh_valid_from AND wh.dwh_valid_to
INNER JOIN p_lew_core_ac.v_cal_busyear_1 bus
ON (agg.cy_month BETWEEN bus.busyear_begin_month AND bus.busyear_end_month)
   AND bus.cy_by_seq IN (0,-1)
INNER JOIN p_lew_core_ac.v_item_hist_1 ih
ON agg.client_id = ih.client_id
   AND agg.item_sid = ih.item_sid
   AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to
INNER JOIN p_lew_core_ac.v_item_familygroup_hist_1 fgh
ON agg.client_id = fgh.client_id
   AND ih.item_fam_grp_sid = fgh.item_fam_grp_sid
   AND CURRENT_DATE BETWEEN fgh.dwh_valid_from AND fgh.dwh_valid_to
INNER JOIN p_lew_core_ac.v_subitemgroup_hist_1 sig
ON agg.client_id = sig.client_id
   AND fgh.sub_item_grp_sid = sig.sub_item_grp_sid
   AND CURRENT_DATE BETWEEN sig.dwh_valid_from AND sig.dwh_valid_to
INNER JOIN p_lew_core_ac.v_wawi_itm_item_act_1 itm
ON agg.client_id = itm.client_id
AND agg.item_sid = itm.item_sid
INNER JOIN p_lew_core_ac.v_client_1 cl
ON agg.client_id = cl.client_id
GROUP BY agg.client_id
       ,agg.cy_month
       ,whm.aspect_id
       ,itm.brand_type_id
       ,sig.item_grp_int_cd
       ,cl.curr_cd
       ,cl.src_country_lidl_cd
       ,wh.src_wh_id
       ,whm.wh_desc
UNION ALL
SELECT
agg.client_id                                                                                           AS client_id,
cl.src_country_lidl_cd                                                                                 AS iso_cd,
agg.cy_month                                                                                           AS cy_month,
'LAND_1'                                                                                                 AS kpi_aspect,
CAST(NULL AS INTEGER)                                                                                  AS wh_id,
CAST(NULL AS VARCHAR(1))                                                                               AS wh_descr,
CAST(NULL AS INTEGER)                                                                                  AS v_id,
CAST(NULL AS VARCHAR(1))                                                                               AS v_descr,
cl.curr_cd                                                                                             AS currency_iso_cd,
CASE WHEN itm.brand_type_id = 1 THEN 'M' ELSE 'EM' END                                                 AS brand_descr,
sig.item_grp_int_cd                                                                                    AS wgi,
SUM(agg.sales_net_val) + SUM(agg.return_net_val)                                                       AS turnover,
SUM(turnover) OVER (PARTITION BY agg.client_id, agg.cy_month)                                          AS total_turnover,
(CAST((turnover * 100) AS DECIMAL(38,10))/NULLIF(CAST(total_turnover AS DECIMAL(38,10)),0))            AS turnover_percent
FROM p_lew_bil_ac.v_agg_pos_wh_mth_item_asis_1 agg
INNER JOIN p_lew_core_ac.v_cal_busyear_1 bus
ON (agg.cy_month BETWEEN bus.busyear_begin_month AND bus.busyear_end_month)
   AND bus.cy_by_seq in (0,-1)
INNER JOIN p_lew_core_ac.v_item_hist_1 ih
ON agg.client_id = ih.client_id
   AND agg.item_sid = ih.item_sid
   AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to
INNER JOIN p_lew_core_ac.v_item_familygroup_hist_1 fgh
ON agg.client_id = fgh.client_id
   AND ih.item_fam_grp_sid = fgh.item_fam_grp_sid
   AND CURRENT_DATE BETWEEN fgh.dwh_valid_from AND fgh.dwh_valid_to
INNER JOIN p_lew_core_ac.v_subitemgroup_hist_1 sig
ON agg.client_id = sig.client_id
   AND fgh.sub_item_grp_sid = sig.sub_item_grp_sid
   AND CURRENT_DATE BETWEEN sig.dwh_valid_from AND sig.dwh_valid_to
INNER JOIN p_lew_core_ac.v_wawi_itm_item_act_1 itm
ON agg.client_id = itm.client_id
   AND agg.item_sid = itm.item_sid
INNER JOIN p_lew_core_ac.v_client_1 cl
ON agg.client_id = cl.client_id
GROUP BY agg.client_id
       ,agg.cy_month
       ,itm.brand_type_id
       ,sig.item_grp_int_cd
       ,cl.src_country_lidl_cd
       ,cl.curr_cd
)
;




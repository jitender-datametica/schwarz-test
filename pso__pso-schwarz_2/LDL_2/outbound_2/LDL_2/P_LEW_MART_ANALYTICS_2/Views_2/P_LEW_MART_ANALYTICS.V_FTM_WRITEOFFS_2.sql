CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_ftm_writeoffs_2 (client_id, country_code, dat_formdate, cy_week,
store_id, orig_store_nr, item_id, orig_item_nr, itemgroup_int_id, subitemgroup_id, item_type, wrtoff_val) AS SELECT
 client_id,
 country_code,
 dat_formdate,
 cy_week,
 store_id,
 orig_store_nr,
 item_id,
 orig_item_nr,
 itemgroup_int_id,
 subitemgroup_id,
 item_type,
  SUM(val_pr_diff_net_sfo_asis) + SUM(val_rtl_rl_net_sfo_asis) AS wrtoff_val
FROM (SELECT AGG.client_id,
    RCTRY.country_iso_cd AS country_code,
    AGG.dat_formdate,
    TAG.cy_week,
    AGG.store_id,
    FIL.orig_store_nr,
    AGG.item_id,
    AGG.orig_item_nr,
    UWG_INFO.itemgroup_int_id,
    AGG.subitemgroup_id,
    AGG.item_type,
    SUM(CASE
      WHEN AGG.dat_formdate < SW.switch_date OR SW.switch_date IS NULL
      THEN AGG.val_pr_diff_net_sfo_asis
      ELSE 0
      END) AS val_pr_diff_net_sfo_asis,
    0 AS val_rtl_rl_net_sfo_asis
   FROM (SELECT AGG_SFO.client_id,
      AGG_SFO.dat_formdate,
      AGG_SFO.store_id,
      AGG_SFO.item_id,
      ART_INFO.orig_item_nr,
      ART_INFO.subitemgroup_id,
       CASE
       WHEN ART_INFO.buying_list_type_id IN (7, 8)
       THEN 'AKTIONSARTIKEL'
       ELSE 'SORTIMENT'
       END AS item_type,
      SUM(CASE
        WHEN (ART_INFO.subitemgroup_id BETWEEN 100 AND 389 OR ART_INFO.subitemgroup_id IN (75, 76)) AND AGG_SFO.sfotype_id
           IN (131, 141)
        THEN AGG_SFO.val_pr_diff_net_sfo_asis
        ELSE 0
        END) AS val_pr_diff_net_sfo_asis
     FROM ldl_p_lew_mart_msi_ac.v_agg_store_day_item_sfo_asis_2 AS AGG_SFO
      INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_item_2 AS ART_INFO ON AGG_SFO.client_id = ART_INFO.client_id AND AGG_SFO.item_id
         = ART_INFO.item_id
     WHERE AGG_SFO.currency_iso_cd = 'EUR'
     GROUP BY AGG_SFO.client_id,
      AGG_SFO.dat_formdate,
      AGG_SFO.store_id,
      AGG_SFO.item_id,
      ART_INFO.orig_item_nr,
      ART_INFO.subitemgroup_id,
      item_type) AS AGG
    INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge_2 AS FIL ON AGG.client_id = FIL.client_id AND AGG.store_id = FIL.store_id
      
    INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_2 AS UWG_INFO ON AGG.subitemgroup_id = UWG_INFO.subitemgroup_id
    INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS TAG_2 ON AGG.dat_formdate = TAG.dat_calendar
    INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country_2 AS RCTRY ON AGG.client_id = RCTRY.country_id
    INNER JOIN (SELECT DISTINCT OWM.client_id,
      OWM.wh_id,
      OWM.aspect_id,
      PS.switch_date
     FROM ldl_p_lew_mart_msi_ac.v_org_wh_merge_2 AS OWM
      LEFT JOIN ldl_p_lew_mart_lead_ac.v_all_wh_pch_switch_2 AS PS ON OWM.aspect_id = PS.aspect_id AND OWM.client_id = PS
         .client_id AND OWM.wh_id = PS.wh_id) AS SW ON FIL.client_id = SW.client_id AND FIL.wh_id = SW.wh_id AND FIL.aspect_id
       = SW.aspect_id
   WHERE FIL.orig_store_nr >= 0
   GROUP BY AGG.client_id,
    country_code,
    AGG.dat_formdate,
    TAG.cy_week,
    AGG.store_id,
    FIL.orig_store_nr,
    AGG.item_id,
    AGG.orig_item_nr,
    UWG_INFO.itemgroup_int_id,
    AGG.subitemgroup_id,
    AGG.item_type,
    val_rtl_rl_net_sfo_asis
   UNION ALL
   SELECT AGG.client_id,
    RCTRY.country_iso_cd AS country_code,
    AGG.dat_formdate,
    TAG.cy_week,
    AGG.store_id,
    FIL.orig_store_nr,
    AGG.item_id,
    AGG.orig_item_nr,
    UWG_INFO.itemgroup_int_id,
    AGG.subitemgroup_id,
    AGG.item_type,
    0 AS val_pr_diff_net_sfo_asis,
    SUM(COALESCE(AGG.val_rtl_rl_net_sfo_asis, 0)) AS val_rtl_rl_net_sfo_asis
   FROM (SELECT AGG_SFO.client_id,
      AGG_SFO.dat_formdate,
      AGG_SFO.store_id,
      AGG_SFO.item_id,
      ART_INFO.orig_item_nr,
      ART_INFO.subitemgroup_id,
       CASE
       WHEN ART_INFO.buying_list_type_id IN (7, 8)
       THEN 'AKTIONSARTIKEL'
       ELSE 'SORTIMENT'
       END AS item_type,
      SUM(CASE
        WHEN AGG_SFO.sfotype_id IN (182, 192) AND AGG_SFO.pcwo_reason_id IN (21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
             , 103, 104, 105, 106, 107, 108, 109, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125,
             126, 132, 133, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153, 154, 156, 157) OR
            AGG_SFO.sfotype_id IN (137, 147) AND AGG_SFO.pcwo_reason_id IN (1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 101, 102,
             110, 111, 127, 128, 129, 130, 131, 134, 135, 136, 137, 152, 155) OR AGG_SFO.sfotype_id IN (181, 191) AND
           AGG_SFO.pcwo_reason_id IN (82, 83, 84)
        THEN AGG_SFO.val_rtl_rl_net_sfo_asis
        ELSE 0
        END) AS val_rtl_rl_net_sfo_asis
     FROM ldl_p_lew_mart_msi_ac.v_agg_store_day_item_sfo_asis_2 AS AGG_SFO
      INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_item_2 AS ART_INFO ON AGG_SFO.client_id = ART_INFO.client_id AND AGG_SFO.item_id
         = ART_INFO.item_id
     WHERE AGG_SFO.currency_iso_cd = 'EUR'
     GROUP BY AGG_SFO.client_id,
      AGG_SFO.dat_formdate,
      AGG_SFO.store_id,
      AGG_SFO.item_id,
      ART_INFO.orig_item_nr,
      ART_INFO.subitemgroup_id,
      item_type) AS AGG
    INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_2 AS UWG_INFO ON AGG.subitemgroup_id = UWG_INFO.subitemgroup_id
    INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS TAG_2 ON AGG.dat_formdate = TAG.dat_calendar
    INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country_2 AS RCTRY ON AGG.client_id = RCTRY.country_id
    INNER JOIN (SELECT DISTINCT store_id,
      client_id,
      orig_store_nr
     FROM ldl_p_lew_mart_msi_ac.v_org_store_merge_2) AS FIL ON AGG.client_id = FIL.client_id AND AGG.store_id = FIL.store_id
      
   WHERE FIL.orig_store_nr >= 0
   GROUP BY AGG.client_id,
    country_code,
    AGG.dat_formdate,
    TAG.cy_week,
    AGG.store_id,
    FIL.orig_store_nr,
    AGG.item_id,
    AGG.orig_item_nr,
    UWG_INFO.itemgroup_int_id,
    AGG.subitemgroup_id,
    AGG.item_type,
    val_pr_diff_net_sfo_asis) AS t17
GROUP BY client_id,
 country_code,
 dat_formdate,
 cy_week,
 store_id,
 orig_store_nr,
 item_id,
 orig_item_nr,
 itemgroup_int_id,
 subitemgroup_id,
 item_type
HAVING SUM(val_pr_diff_net_sfo_asis) + SUM(val_rtl_rl_net_sfo_asis) <> 0;
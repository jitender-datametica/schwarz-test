CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_str_day_item_pch_1 AS WITH CTE_UNION AS (SELECT client_id,
    loc_sid_store,
    item_sid,
    pcwo_reason_id,
    sfotype_id,
    pch_bnl_switch_fg,
    dwh_cal_dt,
    val_price_change,
    dwh_updated
   FROM ldl_p_lew_mart_lead.t_agg_str_day_item_pch_1
   UNION ALL
   SELECT client_id,
    loc_sid AS loc_sid_store,
    item_sid,
    41 AS pcwo_reason_id,
    134 AS sfotype_id,
    1 AS pch_bnl_switch_fg,
    dwh_cal_dt,
     discount_val_net * -1 AS val_price_change,
    dwh_updated
   FROM ldl_p_lew_mart_lead.t_agg_str_day_itm_pch_ldlpl_loyalty_1
   WHERE pcwo_reason_id = 41
   UNION ALL
   SELECT client_id,
    loc_sid AS loc_sid_store,
    item_sid,
     CASE
     WHEN pcwo_reason_id = 41
     THEN 46
     ELSE pcwo_reason_id
     END AS pcwo_reason_id,
    134 AS sfotype_id,
    1 AS pch_bnl_switch_fg,
    dwh_cal_dt,
    discount_val_net AS val_price_change,
    dwh_updated
   FROM ldl_p_lew_mart_lead.t_agg_str_day_itm_pch_ldlpl_loyalty_1) (SELECT v.client_id,
   v.loc_sid_store,
   ITMP.item_sid_map AS item_sid,
   v.pcwo_reason_id,
   v.sfotype_id,
   CRY.currency_iso_cd,
   v.pch_bnl_switch_fg,
   v.dwh_cal_dt,
    v.val_price_change / CASE
     WHEN CRY.rate_currency_exchange = 0
     THEN NULL
     ELSE CRY.rate_currency_exchange
     END AS val_price_change,
   v.dwh_updated
  FROM CTE_UNION AS v
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON v.client_id = CRY.client_id AND CURRENT_DATE
     BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON v.client_id = ITMP.client_id AND v.item_sid = ITMP.item_sid
   LEFT JOIN ldl_p_lew_bil_ac.v_org_store_merge_1 AS OSM ON v.client_id = OSM.client_id AND v.loc_sid_store = OSM.loc_sid_store
       AND OSM.aspect_id = 1);
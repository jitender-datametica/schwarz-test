CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_ftm_ldpl_store_item_day_1 (client_id, country_code, dat_formdate,
cy_week, store_id, orig_store_nr, item_id, orig_item_nr, itemgroup_int_id, subitemgroup_id, item_type, total_net_val) AS
SELECT A12.client_id,
 A12.country_iso_cd AS country_code,
 A11.dwh_cal_dt AS dat_formdate,
 A11.cy_week,
 A11.loc_sid AS store_id,
 A12.orig_store_nr,
 A13.item_id,
 A13.orig_item_nr,
 A14.itemgroup_int_id,
 A13.subitemgroup_id,
  CASE
  WHEN A13.buying_list_type_id IN (7, 8)
  THEN 'AKTIONSARTIKEL'
  ELSE 'SORTIMENT'
  END AS item_type,
 SUM(A11.total_net_val) AS total_net_val
FROM ldl_p_lew_mart_lidl_digital.v_agg_client_store_item_ldpl_day_1 AS A11
 INNER JOIN ldl_p_lew_mart_msi.v_org_all_store_merge_1 AS A12 ON A11.aspect_id = A12.aspect_id AND A11.client_id = A12.client_id
     AND A11.move_to_store_id = A12.move_to_store_id
 INNER JOIN ldl_p_lew_mart_lead.v_itm_item_1 AS A13 ON A11.client_id = A13.client_id AND A11.item_sid = A13.item_id AND
   A12.client_id = A13.client_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_1 AS A14 ON A13.subitemgroup_id = A14.subitemgroup_id
WHERE A11.lidlplus_cust_fg = 'Y'
 AND A11.curr_tot_id = 0
 AND A11.currency_iso_cd = 'EUR'
 AND A12.aspect_id IN (2)
GROUP BY A12.client_id,
 country_code,
 dat_formdate,
 A11.cy_week,
 store_id,
 A12.orig_store_nr,
 A13.item_id,
 A13.orig_item_nr,
 A14.itemgroup_int_id,
 A13.subitemgroup_id,
 item_type;
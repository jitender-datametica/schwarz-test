CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_week_item_period_pv_2 (client_id, item_sid, action_type_id,
item_mstr_sid, orig_item_nr, item_descr_int, item_descr, sub_item_grp_sid, src_subitemgrp_id, src_subitemgrp_cd,
sub_item_grp_name, item_fam_grp_sid, src_familygrp_id, src_familygrp_cd, item_fam_grp_name, item_fam_grp_descr,
item_grp_int_sid, src_itemgrp_int_id, src_itemgrp_int_cd, item_grp_int_name, item_grp_int_descr, brand_sid,
brand_name_int, brand_descr, buying_list_type_id, buying_list_type_descr, buying_list_type_group_id,
buying_list_type_group_descr, listing_type_id, listing_type_descr, listing_type_group_id, listing_type_group_descr,
listing_fg, marke_em_descr, em_fg, marke_fg, case_size, adv_week_id, adv_week_sid, orig_adv_week_id,
assigned_pv_start_dt, assigned_pv_end_dt, assigned_pv_period_descr, adv_period_id, orig_pv_fg_, orig_pv_local_fg,
vat_pct_val, vat_factor, total_sales_net_val, total_pv_sales_net_val, total_sales_net_val_pct, base_receipts_cnt,
base_sales_qty, base_sales_net_val, adv_period_nr_of_days, store_cnt_per_period, sales_qty, sales_net_val,
sales_price_median_day, store_cnt, sales_price_old_median_day, pv_value, add_pv_sales_net_val, price_diff_pct,
total_adv_week_sales_net_val, total_adv_week_receipts_cnt, total_adv_week_sales_qty, pv_effect_pct, receipts_cnt,
pv_value_combined, pv_fg, pv_nr_of_stores_per_item_adv_week, regular_nr_of_stores_per_item_adv_week,
nr_of_stores_per_item_adv_week_pct, nr_of_stores_per_item_adv_week, pv_nr_of_stores_per_item_period,
regular_nr_of_stores_per_item_period, nr_of_stores_per_item_period_pct, nr_of_stores_per_item_period,
sales_price_net_old, sales_price_old, sales_price_net_new, sales_price_new, sales_1d_qty, sales_3d_qty, sales_7d_qty) AS
/* 1: indicates PV */
-- CAST ( assigned_pv_start_dt /*** MSC-WARNING - MSCEWSMALLINT,033 - FORMAT 'E3' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/  AS STRING ( 10 ) )

-- CAST ( assigned_pv_end_dt /*** MSC-WARNING - MSCEWSMALLINT,033 - FORMAT 'E3' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ AS STRING ( 10 ) )

-- CAST ( ( pvp.total_sales_net_val / CASE WHEN pvp.total_pv_sales_net_val = 0 THEN NULL ELSE pvp.total_pv_sales_net_val END) * 100.0

-- AS NUMERIC(38,5)
 -- )                                          AS total_sales_net_val_pct

/* a PV Value must have at least 1000 ? */
/* exclude UWGs 996 | Leergut ( Pfand )  AND -1000 | Verkauf, Artikel_2 nicht in WaWi angelegt | 199 Pauschal |112 Elektrogeraete */
/* do not consider */ /* VK_2  ( alt )   ( netto ) */ /* VK_2  ( alt )   ( brutto ) */ /* VK_2  ( netto )  PV: VK_2  ( neu ) */
/* VK_2  ( brutto )  PV: VK_2  ( neu )   ( brutto ) */ /* ## Parameter TABLE */ SELECT PVP.client_id,
 PVP.item_sid,
 1 AS action_type_id,
 CAST(ITM.item_sid * 100 + ITM.client_id AS BIGNUMERIC) AS item_mstr_sid,
 ITM.orig_item_nr,
 ITM.item_descr_int,
 ITM.item_descr,
 ITM.sub_item_grp_sid,
 ITM.src_subitemgrp_id,
 ITM.src_subitemgrp_cd,
 ITM.sub_item_grp_name,
 ITM.item_fam_grp_sid,
 ITM.src_familygrp_id,
 ITM.src_familygrp_cd,
 ITM.item_fam_grp_name,
 ITM.item_fam_grp_descr,
 ITM.item_grp_int_sid,
 ITM.src_itemgrp_int_id,
 ITM.src_itemgrp_int_cd,
 ITM.item_grp_int_name,
 ITM.item_grp_int_descr,
 ITM.brand_sid,
 ITM.brand_name_int,
 ITM.brand_descr,
 ITM.buying_list_type_id,
 ITM.buying_list_type_descr,
 ITM.buying_list_type_group_id,
 ITM.buying_list_type_group_descr,
 ITM.listing_type_id,
 ITM.listing_type_descr,
 ITM.listing_type_group_id,
 ITM.listing_type_group_descr,
 ITM.listing_fg,
 ITM.marke_em_descr,
 ITM.em_fg,
 ITM.marke_fg,
 ITM.case_size,
 PVP.adv_week_id,
 CAST(PVP.adv_week_id * 100 + PVP.client_id AS BIGNUMERIC) AS adv_week_sid,
 PVP.orig_adv_week_id,
 PVP.assigned_pv_start_dt,
 PVP.assigned_pv_end_dt,
   FORMAT_DATE('%a', PVP.assigned_pv_start_dt) || ' - ' || FORMAT_DATE('%a', PVP.assigned_pv_end_dt) AS
 assigned_pv_period_descr,
 PVP.adv_period_id,
 PVP.pv_fg AS orig_pv_fg_,
 PVP.pv_local_fg AS orig_pv_local_fg,
 PVP.vat_pct_val,
 PVP.vat_factor,
 PVP.total_sales_net_val,
 PVP.total_pv_sales_net_val,
  IF(PVP.total_pv_sales_net_val = 0, 0, SAFE_DIVIDE(PVP.total_sales_net_val, PVP.total_pv_sales_net_val)) * 100 AS
 total_sales_net_val_pct,
 PVP.base_receipts_cnt,
 PVP.base_sales_qty,
 PVP.base_sales_net_val,
 PVP.adv_period_nr_of_days,
 PVP.store_cnt_per_period,
 PVP.sales_qty,
 PVP.sales_net_val,
 PVP.sales_price_median_day,
 PVP.store_cnt,
 PVP.sales_price_old_median_day,
 PVP.pv_value,
 PVP.add_pv_sales_net_val,
 PVP.price_diff_pct,
 PVP.total_adv_week_sales_net_val,
 PVP.total_adv_week_receipts_cnt,
 PVP.total_adv_week_sales_qty,
 CAST((PVP.add_pv_sales_net_val / CASE
       WHEN - 1.00 * PVP.pv_value = 0
       THEN NULL
       ELSE - 1.00 * PVP.pv_value
       END - 1.00) * 100.0 AS BIGNUMERIC) AS pv_effect_pct,
 PVP.receipts_cnt,
 SUM(CASE
   WHEN PVP.pv_fg = 1 AND PVP.pv_local_fg = 0
   THEN PVP.pv_value
   ELSE NULL
   END) OVER (PARTITION BY CAST(PVP.client_id AS STRING), CAST(PVP.item_sid AS STRING), CAST(PVP.adv_week_id AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS pv_value_combined,
  CASE
  WHEN PVP.pv_fg = 1 AND (SUM(CASE
         WHEN PVP.pv_fg = 1 AND PVP.pv_local_fg = 0
         THEN PVP.pv_value
         ELSE NULL
         END) OVER (PARTITION BY CAST(PVP.client_id AS STRING), CAST(PVP.item_sid AS STRING), CAST(PVP.adv_week_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) < pa.pv_value_adv_week
      /* AND NOT  ( itm.src_subitemgrp_cd > 100 OR itm.src_subitemgrp_cd < 9 ) */ AND CAST(ITM.src_subitemgrp_cd AS FLOAT64)
     <= pa.pv_uwg_upperlimit AND CAST(ITM.src_subitemgrp_cd AS FLOAT64) >= pa.pv_uwg_lowerlimit
  THEN 1
  ELSE 0
  END AS pv_fg,
 PVP.pv_nr_of_stores_per_item_adv_week,
 PVP.regular_nr_of_stores_per_item_adv_week,
 CAST(CAST(PVP.pv_nr_of_stores_per_item_adv_week AS BIGNUMERIC) / CASE
    WHEN CAST(PVP.regular_nr_of_stores_per_item_adv_week AS BIGNUMERIC) = 0
    THEN NULL
    ELSE CAST(PVP.regular_nr_of_stores_per_item_adv_week AS BIGNUMERIC)
    END AS BIGNUMERIC) AS nr_of_stores_per_item_adv_week_pct,
  PVP.pv_nr_of_stores_per_item_adv_week + PVP.regular_nr_of_stores_per_item_adv_week AS nr_of_stores_per_item_adv_week,
 PVP.pv_nr_of_stores_per_item_period,
 PVP.regular_nr_of_stores_per_item_period,
 CAST(CAST(PVP.pv_nr_of_stores_per_item_period AS BIGNUMERIC) / CASE
    WHEN CAST(PVP.regular_nr_of_stores_per_item_period AS BIGNUMERIC) = 0
    THEN NULL
    ELSE CAST(PVP.regular_nr_of_stores_per_item_period AS BIGNUMERIC)
    END AS BIGNUMERIC) AS nr_of_stores_per_item_period_pct,
  PVP.pv_nr_of_stores_per_item_period + PVP.regular_nr_of_stores_per_item_period AS nr_of_stores_per_item_period,
 PVP.sales_price_old AS sales_price_net_old,
 ROUND(CAST(PVP.sales_price_old * CAST(1.00 + PVP.vat_factor AS BIGNUMERIC) AS BIGNUMERIC), 5) AS sales_price_old,
 PVP.sales_price AS sales_price_net_new,
 ROUND(CAST(PVP.sales_price * CAST(1.00 + PVP.vat_factor AS BIGNUMERIC) AS BIGNUMERIC), 5) AS sales_price_new,
 PVP.sales_1d_qty,
 PVP.sales_3d_qty,
 PVP.sales_7d_qty
FROM ldl_p_lew_mart_pit_onprem.t_pit_week_item_period_pv_2 AS PVP
 INNER JOIN (SELECT client_id,
   MAX(`A118612`) AS pv_threshold,
   MAX(`A118613`) AS pv_sunday_open_threshold,
   MAX(`A118614`) AS pv_local_pv_threshold,
   MAX(`A118615`) AS pv_time_gap_in_days,
   MAX(`A118616`) AS pv_value_month,
   MAX(`A118617`) AS pv_uwg_lowerlimit,
   MAX(`A118618`) AS pv_uwg_upperlimit,
   MAX(`A118619`) AS pv_value_adv_week
  FROM (SELECT client_id,
     IF(param_id = 1, SAFE_CAST(param_value as BIGNUMERIC), NULL) AS `A118612`,
     IF(param_id = 2, SAFE_CAST(param_value as BIGNUMERIC), NULL) AS `A118613`,
     IF(param_id = 3, SAFE_CAST(param_value as BIGNUMERIC), NULL) AS `A118614`,
     IF(param_id = 5, ROUND(SAFE_CAST(param_value as BIGNUMERIC), 0), NULL) AS `A118615`,
     IF(param_id = 9, SAFE_CAST(param_value as BIGNUMERIC), NULL) AS `A118616`,
     IF(param_id = 10, ROUND(SAFE_CAST(param_value as BIGNUMERIC), 0), NULL) AS `A118617`,
     IF(param_id = 11, ROUND(SAFE_CAST(param_value as BIGNUMERIC), 0), NULL) AS `A118618`,
     IF(param_id = 12, SAFE_CAST(param_value as BIGNUMERIC), NULL) AS `A118619`
    FROM ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param_2
    WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
     AND deleted_fg = 0
    QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY CAST(client_id AS STRING), CAST(param_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t1_2
  GROUP BY client_id) AS pa ON PVP.client_id /* ## CROSS JOIN new ClientItemDay View */ = pa.client_id
 INNER JOIN ldl_p_lew_mart_pit_onprem.v_pit_item_client_day_hist_2 AS ITM ON PVP.client_id = ITM.client_id AND PVP.item_sid
     = ITM.item_sid AND PVP.assigned_pv_start_dt = ITM.dwh_cal_dt;
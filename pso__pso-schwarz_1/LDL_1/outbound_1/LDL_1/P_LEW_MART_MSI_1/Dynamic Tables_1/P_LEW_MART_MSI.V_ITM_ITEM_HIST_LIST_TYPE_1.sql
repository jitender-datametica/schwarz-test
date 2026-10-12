
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_itm_item_hist_list_type_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT ITM.client_id,
 ITM.item_sid AS item_id,
  CASE
  WHEN ITM.dat_rec_start < vat.dat_rec_start
  THEN vat.dat_rec_start
  ELSE ITM.dat_rec_start
  END AS dat_rec_start,
  CASE
  WHEN ITM.dat_rec_end > vat.dat_rec_end
  THEN vat.dat_rec_end
  ELSE ITM.dat_rec_end
  END AS dat_rec_end,
 ITM.dat_valid_from,
 ITM.add_docs_fg,
 ITM.additions,
 ITM.age_fg,
 ITM.beverage_tax,
 ITM.brand_name,
 ITM.buyer_id,
 ITM.buyer_name,
 COALESCE(ITM.buying_list_type_id, - 1) AS buying_list_type_id,
  CASE
  WHEN ITM.buying_list_type_id IS NULL
  THEN 'Dummy_1-Artikelart'
  ELSE ITM.buying_list_type_desc
  END AS buying_list_type_desc,
 ITM.buying_list_orderset_nr,
 ITM.qty_min_piece_ordering,
 ITM.buyer_name_int,
 ITM.contract_country_cd,
 ITM.case_dd,
 ITM.case_depth,
 ITM.case_euro,
 ITM.case_layer,
 ITM.case_plu_fg,
 ITM.case_height,
 ITM.case_size,
 ITM.case_size_dec,
 ITM.case_volume,
 ITM.case_weight,
 ITM.case_width,
 ITM.commodity_cd,
 ITM.cont_deposit_item_nr,
 ITM.consumption_tax_main_id,
 ITM.consumption_tax_sub_id,
 ITM.country_cd,
 ITM.dangerous_goods_fg,
 ITM.dat_adv,
 ITM.dat_delisting,
 ITM.dat_listing,
 ITM.dat_min_shelflifetest_fg,
 ITM.delisting_fg,
 ITM.delivery_temp,
 ITM.val_deposit,
 ITM.direct_delete_mde_fg,
 ITM.discount_fg,
 ITM.dualsystem_fg,
 ITM.dur_shelflife_wh,
 ITM.dur_shelflife_cust,
 ITM.dur_shelflife_store,
 ROUND(CAST(TRUNC(CAST(ITM.dur_shelflife_wh AS BIGNUMERIC)) AS BIGNUMERIC), 0) AS dur_shelflife_timeunits_wh,
  CASE
  WHEN ITM.period_id_shelflife_wh IN (1, 2, 3)
  THEN ROUND(CAST(TRUNC(CAST(ITM.dur_shelflife_wh AS BIGNUMERIC)) AS BIGNUMERIC), 0) * ITM.factor_period_wh
  ELSE ROUND(CAST(TRUNC(CAST(ITM.dur_shelflife_wh AS BIGNUMERIC)) AS BIGNUMERIC), 0)
  END AS dur_shelflife_day_wh,
 ROUND(CAST(TRUNC(CAST(ITM.dur_shelflife_cust AS BIGNUMERIC)) AS BIGNUMERIC), 0) AS dur_shelflife_timeunits_cust,
  CASE
  WHEN ITM.period_id_shelflife_cust IN (1, 2, 3)
  THEN ROUND(CAST(TRUNC(CAST(ITM.dur_shelflife_cust AS BIGNUMERIC)) AS BIGNUMERIC), 0) * ITM.factor_period_cust
  ELSE ROUND(CAST(TRUNC(CAST(ITM.dur_shelflife_cust AS BIGNUMERIC)) AS BIGNUMERIC), 0)
  END AS dur_shelflife_day_cust,
 ROUND(CAST(TRUNC(CAST(ITM.dur_shelflife_store AS BIGNUMERIC)) AS BIGNUMERIC), 0) AS dur_shelflife_timeunits_store,
  CASE
  WHEN ITM.period_id_shelflife_store IN (1, 2, 3)
  THEN ROUND(CAST(TRUNC(CAST(ITM.dur_shelflife_store AS BIGNUMERIC)) AS BIGNUMERIC), 0) * ITM.factor_period_store
  ELSE ROUND(CAST(TRUNC(CAST(ITM.dur_shelflife_store AS BIGNUMERIC)) AS BIGNUMERIC), 0)
  END AS dur_shelflife_day_store,
 ITM.factor_period_cust,
 ITM.factor_period_store,
 ITM.factor_period_wh,
 ITM.food_fg,
 ITM.forwarding_item_nr,
 ITM.int_subitemgroup_id,
 ITM.item_familygroup_id,
 ITM.item_parts,
 ITM.item_parts_cd,
 ITM.item_plu_nr,
 ITM.item_short_desc_1,
 ITM.item_short_desc_2,
 ITM.item_text_1,
 ITM.item_text_2,
 ITM.item_text_3,
 ITM.item_short_desc_3,
 ITM.item_version,
 ITM.lidl_buying_country_cd,
 ITM.listing_fg,
 ITM.logistic_unit_cd,
 ITM.max_receive_temp,
 ITM.mdessp_fg,
 ITM.minus_fg,
 ITM.min_case_layer,
 ITM.min_case_dd,
 ITM.min_case_euro,
 ITM.min_case_orderunit,
 ITM.min_receive_temp,
 ITM.net_piece_weight,
 ITM.net_case_weight,
 ITM.order_area_cd,
 ITM.orig_item_nr_int,
 ITM.package_qty,
 ITM.packing,
 ITM.pct_discount,
 ITM.pct_consumption_tax,
 ITM.period_id_shelflife_cust,
 ITM.period_id_shelflife_store,
 ITM.period_id_shelflife_wh,
 ITM.piece_depth,
 ITM.piece_height,
 ITM.piece_width,
 ITM.piece_volume,
 ITM.piece_weight,
 ITM.piece_net_weight_kg_meas AS piece_net_weight,
 ITM.poster_fg,
 ITM.price_sign_fg,
 ITM.price_strip_fg,
 ITM.qty_consumption_tax_add,
 ITM.res_selltime,
 ITM.reusable_fg,
 ITM.scale_fg,
 ITM.season_fg,
 ITM.smallest_orderunit,
 ITM.smallest_unit,
 ITM.stock_capacity,
 ITM.status_id_hq,
 ITM.subitemgroup_id,
 ITM.tax_refund_fg,
 ITM.taxation,
 ITM.type_cd,
 ITM.type_receive_temp_fg,
 ITM.unitsize,
 ITM.val_consumption_tax,
 ITM.vat_id,
 ITM.wallow_nr,
 ITM.weight,
 ITM.weight_item_fg,
 ITM.write_off,
 ITM.wg_fg,
 ITM.packagetype_desc,
 COALESCE(ITM.item_actiongroup_id, - 1) AS item_actiongroup_id,
 COALESCE(ITM.item_sub_actiongroup_id, - 1) AS item_sub_actiongroup_id,
 COALESCE(REFLIST.listing_type_id, - 1) AS listing_type_id,
 COALESCE(REFLIST.brand_type_id, - 1) AS brand_type_id,
 COALESCE(REFLIST.buying_list_type_group_id, - 1) AS buying_list_type_group_id,
 COALESCE(REFLIST.listing_type_group_id, - 1) AS listing_type_group_id,
 COALESCE(REFLIST.brand_type_group_id, - 1) AS brand_type_group_id,
 vat.pct_vat
FROM ldl_p_lew_core_ac.v_wawi_itm_item_1 AS ITM
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_1 AS REFLIST ON ITM.buying_list_type_id = REFLIST.buying_list_type_id
    AND ITM.client_id = REFLIST.language_id
 LEFT JOIN (SELECT client_id,
   vat_id,
   pct_vat,
   DATE_ADD(min_date, INTERVAL 1 DAY) AS dat_rec_start,
    CASE
    WHEN end_date = DATE '2200-01-01'
    THEN DATE '9999-12-31'
    ELSE end_date
    END AS dat_rec_end
  FROM (SELECT client_id,
      vat_id,
      pct_vat,
        CAST(MIN(start_date) AS STRING) || ' , ' || CAST(MAX(end_date) AS STRING) AS validity_1,
      MIN(start_date) AS min_date,
      MAX(end_date) AS end_date
     FROM (SELECT client_id,
        vat_id,
        pct_vat,
        SUM(flag) OVER (PARTITION BY CAST(client_id AS STRING), CAST(vat_id AS STRING), CAST(pct_vat AS STRING) ORDER BY
           start_date IS NULL, start_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS groupid,
        end_date,
        start_date
       FROM (SELECT dat_rec_end AS end_date,
          client_id,
          vat_id,
          pct_vat,
           CASE
           WHEN DATE_ADD(DATE_SUB(MIN(dat_rec_start), INTERVAL 1 DAY), INTERVAL - 1 DAY) <= (LAG(dat_rec_end) OVER (PARTITION BY CAST(client_id AS STRING)
                , CAST(vat_id AS STRING), CAST(pct_vat AS STRING) ORDER BY DATE_SUB(MIN(dat_rec_start), INTERVAL 1 DAY)
                IS NULL, DATE_SUB(MIN(dat_rec_start), INTERVAL 1 DAY), dat_rec_end IS NULL, dat_rec_end))
           THEN 0
           ELSE 1
           END AS flag,
          DATE_SUB(MIN(dat_rec_start), INTERVAL 1 DAY) AS start_date
         FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_1
         GROUP BY client_id,
          vat_id,
          pct_vat,
          end_date) AS t1_1) AS T
     GROUP BY client_id,
      vat_id,
      pct_vat,
      groupid
     UNION DISTINCT
     SELECT client_id,
      vat_id,
      CAST(NULL AS NUMERIC) AS pct_vat,
        CAST(DATE_SUB(PARSE_DATE('%F', '1900-01-01'), INTERVAL 1 DAY) AS STRING) || ' , ' || CAST(DATE_SUB(MIN(dat_rec_start), INTERVAL 1 DAY) AS STRING)
        AS validity_1,
      DATE_SUB(PARSE_DATE('%F', '1900-01-01'), INTERVAL 1 DAY) AS min_date,
      DATE_SUB(MIN(dat_rec_start), INTERVAL 1 DAY) AS end_date
     FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_1
     GROUP BY client_id,
      vat_id
     HAVING MIN(dat_rec_start) > DATE '1900-01-01') AS td) AS vat ON ITM.client_id = vat.client_id AND ITM.vat_id = vat
     .vat_id AND ITM.dat_rec_start <= vat.dat_rec_end AND ITM.dat_rec_end >= vat.dat_rec_start;


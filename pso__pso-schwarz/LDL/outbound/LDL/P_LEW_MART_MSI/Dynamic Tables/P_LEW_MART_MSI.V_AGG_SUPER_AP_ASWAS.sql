
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_agg_super_ap_aswas
 AS
-- Bei Zeitueberschneidungen wird der aktuellste Satz genommen.
 SELECT A.client_id,
 WH.src_wh_id AS wh_id,
 item.item_sid AS item_id,
 A.dat_adv,
 A.orig_promotion_domain_nr,
 A.dat_adv_desc,
 AGG.qty_sales_dat_adv,
 AGG.qty_sales_period1,
 AGG.qty_sales_period2,
 AGG.qty_sales_dat_adv_end,
 AGG.qty_del_dat_behind_del,
  AGG.val_retail_ejr / CRY.rate_currency_exchange AS val_retail_ejr,
 AGG.qty_return_period2,
 AGG.qty_sales_period2_test,
 AGG.qty_del_dat_behind_del_test,
  AGG.val_retail_ejr_total / CRY.rate_currency_exchange AS val_retail_ejr_total,
  AGG.val_retail_net_ejr_total / CRY.rate_currency_exchange AS val_retail_net_ejr_total,
  AGG.val_pricechange / CRY.rate_currency_exchange AS val_pricechange,
  AGG.val_pricechange_net / CRY.rate_currency_exchange AS val_pricechange_net,
  AGG.val_pricediff_pc / CRY.rate_currency_exchange AS val_pricediff_pc,
  AGG.val_pricediff_net_pc / CRY.rate_currency_exchange AS val_pricediff_net_pc,
  AGG.val_pc_dat_ext / CRY.rate_currency_exchange AS val_pc_dat_ext,
  AGG.val_net_pc_dat_ext / CRY.rate_currency_exchange AS val_net_pc_dat_ext,
  AGG.val_pricediff_pc_dat_ext / CRY.rate_currency_exchange AS val_pricediff_pc_dat_ext,
  AGG.val_pricediff_net_pc_dat_ext / CRY.rate_currency_exchange AS val_pricediff_net_pc_dat_ext,
  AGG.val_writeoff / CRY.rate_currency_exchange AS val_writeoff,
  AGG.val_writeoff_net / CRY.rate_currency_exchange AS val_writeoff_net,
  AGG.val_pricediff_wo / CRY.rate_currency_exchange AS val_pricediff_wo,
  AGG.val_pricediff_net_wo / CRY.rate_currency_exchange AS val_pricediff_net_wo,
  AGG.val_diff_inv / CRY.rate_currency_exchange AS val_diff_inv,
  AGG.val_diff_net_inv / CRY.rate_currency_exchange AS val_diff_net_inv,
  AGG.val_writeoff_zero / CRY.rate_currency_exchange AS val_writeoff_zero,
  AGG.val_writeoff_zero_net / CRY.rate_currency_exchange AS val_writeoff_zero_net,
  AGG.price_buying_sp_condition / CRY.rate_currency_exchange AS price_buying_sp_condition,
  AGG.val_retail_net_ejr / CRY.rate_currency_exchange AS val_retail_net_ejr,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_s_ap AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON A.client_id = WH.client_id AND A.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
 INNER JOIN (SELECT I.client_id,
   I.item_sid,
   ROUND(SAFE_CAST(COALESCE(I.src_orig_item_nr, I.config_item_cd, I.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
   COALESCE(I.src_dat_valid_from, MAX(I.src_dat_valid_from) OVER (PARTITION BY CAST(I.client_id AS STRING), CAST(COALESCE(I.item_sid_config, I.item_sid) AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS dat_valid_from,
   IH.dwh_valid_to
  FROM ldl_p_lew_core_ac.v_item AS I
   INNER JOIN ldl_p_lew_core_ac.v_item_hist AS IH ON I.client_id = IH.client_id AND I.item_sid = IH.item_sid AND IH.deleted_fg
      = 0
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(I.client_id AS STRING), CAST(I.item_sid AS STRING)
      ORDER BY IH.dwh_valid_to IS NULL, IH.dwh_valid_to)) = 1) AS item ON A.client_id = item.client_id AND A.orig_item_nr
     = item.orig_item_nr AND A.dat_adv BETWEEN item.dat_valid_from AND item.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON A.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 LEFT JOIN ldl_p_lew_mart_msi.t_agg_super_ap_aswas AS AGG ON A.client_id = AGG.client_id AND WH.src_wh_id = AGG.wh_id
   AND item.item_sid = AGG.item_sid AND A.dat_adv = AGG.dat_adv
WHERE CURRENT_DATE BETWEEN A.dat_rec_start AND A.dat_rec_end
  -- only one row per key and item_sid should be returned. dat_rec_start cannot be used to determine one single row per key

  -- as there may be new case sizes for an orig_item_nr with a dat_rec_start later than the dat_adv

QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.wh_loc_sid AS STRING), CAST(item.item_sid AS STRING)
      , A.dat_adv, CRY.currency_iso_cd ORDER BY item.dwh_valid_to IS NULL, item.dwh_valid_to)) = 1;
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_discount_ejr (
  client_id, 
  store_id, 
  item_id, 
  discount_id, 
  dat_calendar,
  discount_pct, 
  src_discount_nr, 
  listing_type_id_hist, 
  buying_list_type_id_hist, 
  src_posart, 
  discount_descr,
  first_appearance_dt, 
  lidlplus_coupon_pattern_fg, 
  currency_iso_cd, 
  val_discount_net_ejr, 
  val_discount_hq_net_ejr,
  val_discount_base_net_ejr, 
  qty_discount_pos_ejr, 
  qty_discount_hq_ejr
) AS 
SELECT 
  RCP.client_id,
  store_id,
  item_id,
  discount_sid AS discount_id,
  dat_formdate AS dat_calendar,
  src_discount_pct AS discount_pct,
  src_discount_nr,
  COALESCE(listing_type_id, -1) AS listing_type_id_hist,
  COALESCE(ITMW.buying_list_type_id, -1) AS buying_list_type_id_hist,
  src_posart,
  discount_descr,
  first_appearance_dt,
  lidlplus_coupon_pattern_fg,
  currency_iso_cd,
  val_discount_net_ejr,
  val_discount_hq_net_ejr,
  val_discount_base_net_ejr,
  qty_discount_pos_ejr,
  qty_discount_hq_ejr
FROM (
  SELECT 
    R.client_id,
    R.loc_sid AS store_id,
    R.item_sid AS item_id,
    R.discount_sid AS discount_id,
    R.dwh_cal_dt AS dat_formdate,
    COALESCE(100 / CASE
      WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0 THEN NULL
      ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
      END, 1) AS pct_factor_dec_vat_ejr,
    CASE
      WHEN R.discount_sid IS NOT NULL AND R.discount_weight_qty <> 0
      THEN CAST(R.discount_val * COALESCE(100 / CASE
            WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0 THEN NULL
            ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
            END, 1) / CRY.rate_currency_exchange AS NUMERIC)
      ELSE 0
    END AS val_discount_net_ejr,
    CASE
      WHEN R.discount_sid IS NOT NULL AND R.discount_piece_qty <> 0
      THEN CAST(R.discount_val * COALESCE(100 / CASE
            WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0 THEN NULL
            ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
            END, 1) / CRY.rate_currency_exchange AS NUMERIC)
      ELSE 0
    END AS val_discount_hq_net_ejr,
    CAST(R.discount_base_val * COALESCE(100 / CASE
          WHEN CAST(R.vat_pct_val AS NUMERIC) + 100 = 0 THEN NULL
          ELSE CAST(R.vat_pct_val AS NUMERIC) + 100
          END, 1) / CRY.rate_currency_exchange AS NUMERIC) AS val_discount_base_net_ejr,
    R.discount_weight_qty AS qty_discount_pos_ejr,
    R.discount_piece_qty AS qty_discount_hq_ejr,
    CRY.currency_iso_cd
  FROM ldl_p_lew_core_ac.v_pos_receiptline AS R
  INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY 
    ON R.client_id = CRY.client_id 
    AND R.dwh_cal_dt BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
  WHERE R.turnover_relevant_fg = 1
) AS RCP
LEFT JOIN ldl_p_lew_core_ac.v_pos_discount AS DIS 
  ON RCP.client_id = DIS.client_id 
  AND RCP.discount_id = DIS.discount_sid
INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country AS LAND 
  ON RCP.client_id = LAND.country_id
LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item AS ITMW 
  ON RCP.client_id = ITMW.client_id 
  AND RCP.item_id = ITMW.item_sid
  AND RCP.dat_formdate BETWEEN ITMW.dat_rec_start AND ITMW.dat_rec_end
LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_itm_list_type AS ITM_LIST 
  ON ITMW.client_id = ITM_LIST.language_id 
  AND ITMW.buying_list_type_id = ITM_LIST.buying_list_type_id
WHERE ROUND(SAFE_CAST(DIS.src_discount_nr AS BIGNUMERIC), 0) IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  AND DIS.src_discount_pct IS NOT NULL;
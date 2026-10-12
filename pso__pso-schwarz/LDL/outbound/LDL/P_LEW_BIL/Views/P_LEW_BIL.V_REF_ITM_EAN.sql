CREATE OR REPLACE VIEW ldl_p_lew_bil.v_ref_itm_ean AS SELECT I.client_id,
 WH.loc_sid_wh,
 WH.src_wh_id AS wh_id,
 I.item_sid,
 ROUND(CAST(COALESCE(I.src_orig_item_nr, I.config_item_cd, I.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
 IUOMH.gtin AS gtin_input_cd,
 ROUND(CAST(IUOMH.gtin AS BIGNUMERIC), 0) AS barcode,
  CASE
  WHEN IUOMH.conv_to_base_numerator <> 0 AND IUOMH.conv_to_base_denominator <> 0
  THEN IUOMH.conv_to_base_numerator / ROUND(CAST(IUOMH.conv_to_base_denominator AS NUMERIC), 3)
  ELSE 1
  END AS case_factor_ejr,
 IUOMH.dwh_valid_from,
 IUOMH.dwh_valid_to
FROM ldl_p_lew_core_ac.v_item AS I
 INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement AS IUOM ON I.client_id = IUOM.client_id AND I.item_sid = IUOM.item_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_hist AS IUOMH ON IUOM.client_id = IUOMH.client_id AND IUOM.item_sid
     = IUOMH.item_sid AND IUOM.uom_sid = IUOMH.uom_sid
 INNER JOIN ldl_p_lew_bil.v_warehouse AS WH ON IUOMH.client_id = WH.client_id AND WH.active_fg = 1 AND WH.dwh_actual_fg
   = 1
 INNER JOIN ldl_p_lew_core_ac.v_country AS CTRY ON WH.global_loc_ctry_cd = CTRY.src_country_lidl_cd
 INNER JOIN ldl_p_lew_core_ac.v_client AS CL ON WH.client_id = CL.client_id AND CTRY.country_sid = CL.country_sid
WHERE ROUND(SAFE_CAST(I.log_var_cd AS BIGNUMERIC), 0) = 2
 AND (COALESCE(IUOM.log_var_cd, '@') <> '2' OR LENGTH(IUOM.uom_cd) > 2)
 AND IUOMH.dwh_valid_to >= IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 12 MONTH)
    ), DATE_ADD(CURRENT_DATE, INTERVAL - 12 MONTH))
 AND ROUND(CAST(IUOMH.gtin AS BIGNUMERIC), 0) <> ROUND(CAST(COALESCE(I.src_orig_item_nr, I.config_item_cd, I.src_matnr) AS BIGNUMERIC)
   , 0)
 AND WH.bges_active_fg = 1
 AND ROUND(SAFE_CAST(IUOMH.gtin AS BIGNUMERIC), 0) IS NOT NULL
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(I.client_id AS STRING), WH.src_wh_id, CAST(barcode AS STRING) ORDER BY
      IUOMH.dwh_valid_from IS NULL, IUOMH.dwh_valid_from, case_factor_ejr IS NULL, case_factor_ejr, I.item_sid IS NULL,
      I.item_sid)) = 1;
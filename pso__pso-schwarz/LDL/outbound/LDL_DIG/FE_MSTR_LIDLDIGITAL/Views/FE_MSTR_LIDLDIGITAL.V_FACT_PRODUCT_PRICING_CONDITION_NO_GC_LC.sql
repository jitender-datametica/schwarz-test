CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_product_pricing_condition_no_gc_lc AS WITH CTE AS (SELECT
   PPC_FACT.wshop_cd,
   IFNULL(PPC_FACT.prod_variant_sid, -1) AS prod_variant_sid,
   TAX_DIM.tax_class_pct,
    CASE
    WHEN PPC_FACT.price_type_cd = 'VKP'
    THEN PPC_FACT.curr_cd
    ELSE NULL
    END AS vkp_curr_cd,
    CASE
    WHEN PPC_FACT.price_type_cd = 'VKP'
    THEN PPC_FACT.price_val
    ELSE NULL
    END AS vkp_price_gross_local_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'VKP'
    THEN PPC_FACT.price_val / CER_FACT.exchange_rate
    ELSE NULL
    END AS vkp_price_gross_eur_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'VKP'
    THEN CASE
      WHEN PPC_FACT.price_type_cd = 'VKP'
      THEN PPC_FACT.price_val
      ELSE NULL
      END / (1 + TAX_DIM.tax_class_pct)
    ELSE NULL
    END AS vkp_price_net_local_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'VKP'
    THEN CASE
      WHEN PPC_FACT.price_type_cd = 'VKP'
      THEN PPC_FACT.price_val / CER_FACT.exchange_rate
      ELSE NULL
      END / (1 + TAX_DIM.tax_class_pct)
    ELSE NULL
    END AS vkp_price_net_eur_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'AKP'
    THEN PPC_FACT.curr_cd
    ELSE NULL
    END AS akp_curr_cd,
    CASE
    WHEN PPC_FACT.price_type_cd = 'AKP'
    THEN PPC_FACT.price_val
    ELSE NULL
    END AS akp_price_gross_local_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'AKP'
    THEN PPC_FACT.price_val / CER_FACT.exchange_rate
    ELSE NULL
    END AS akp_price_gross_eur_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'AKP'
    THEN CASE
      WHEN PPC_FACT.price_type_cd = 'AKP'
      THEN PPC_FACT.price_val
      ELSE NULL
      END / (1 + TAX_DIM.tax_class_pct)
    ELSE NULL
    END AS akp_price_net_local_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'AKP'
    THEN CASE
      WHEN PPC_FACT.price_type_cd = 'AKP'
      THEN PPC_FACT.price_val / CER_FACT.exchange_rate
      ELSE NULL
      END / (1 + TAX_DIM.tax_class_pct)
    ELSE NULL
    END AS akp_price_net_eur_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'UVP'
    THEN PPC_FACT.curr_cd
    ELSE NULL
    END AS uvp_curr_cd,
    CASE
    WHEN PPC_FACT.price_type_cd = 'UVP'
    THEN PPC_FACT.price_val
    ELSE NULL
    END AS uvp_price_gross_local_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'UVP'
    THEN PPC_FACT.price_val / CER_FACT.exchange_rate
    ELSE NULL
    END AS uvp_price_gross_eur_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'STP'
    THEN PPC_FACT.curr_cd
    ELSE NULL
    END AS stp_curr_cd,
    CASE
    WHEN PPC_FACT.price_type_cd = 'STP'
    THEN PPC_FACT.price_val
    ELSE NULL
    END AS stp_price_gross_local_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'STP'
    THEN PPC_FACT.price_val / CER_FACT.exchange_rate
    ELSE NULL
    END AS stp_price_gross_eur_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'VKZ1'
    THEN PPC_FACT.curr_cd
    ELSE NULL
    END AS vkz1_curr_cd,
    CASE
    WHEN PPC_FACT.price_type_cd = 'VKZ1'
    THEN PPC_FACT.price_val
    ELSE NULL
    END AS vkz1_price_gross_local_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'VKZ1'
    THEN PPC_FACT.price_val / CER_FACT.exchange_rate
    ELSE NULL
    END AS vkz1_price_gross_eur_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'VKZ2'
    THEN PPC_FACT.curr_cd
    ELSE NULL
    END AS vkz2_curr_cd,
    CASE
    WHEN PPC_FACT.price_type_cd = 'VKZ2'
    THEN PPC_FACT.price_val
    ELSE NULL
    END AS vkz2_price_gross_local_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'VKZ2'
    THEN PPC_FACT.price_val / CER_FACT.exchange_rate
    ELSE NULL
    END AS vkz2_price_gross_eur_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'IVP'
    THEN PPC_FACT.curr_cd
    ELSE NULL
    END AS ivp_curr_cd,
    CASE
    WHEN PPC_FACT.price_type_cd = 'IVP'
    THEN PPC_FACT.price_val
    ELSE NULL
    END AS ivp_price_gross_local_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'IVP'
    THEN PPC_FACT.price_val / CER_FACT.exchange_rate
    ELSE NULL
    END AS ivp_price_gross_eur_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'ZVP'
    THEN PPC_FACT.curr_cd
    ELSE NULL
    END AS zvp_curr_cd,
    CASE
    WHEN PPC_FACT.price_type_cd = 'ZVP'
    THEN PPC_FACT.price_val
    ELSE NULL
    END AS zvp_price_gross_local_val,
    CASE
    WHEN PPC_FACT.price_type_cd = 'ZVP'
    THEN PPC_FACT.price_val / CER_FACT.exchange_rate
    ELSE NULL
    END AS zvp_price_gross_eur_val
  FROM ldl_dig_lec_share.v_fact_product_pricing_condition AS PPC_FACT
   INNER JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate AS CER_FACT ON PPC_FACT.curr_cd = CER_FACT.from_curr_cd
     AND CER_FACT.to_curr_cd = 'EUR' AND CER_FACT.active_fg
   INNER JOIN ldl_dig_lec_share.v_dim_currency_exchange_rate_type AS CERT ON CER_FACT.curr_exchange_rate_type_cd = CERT
     .curr_exchange_rate_type_cd AND CERT.is_general_used_fg
   INNER JOIN ldl_dig_lec_share.v_rel_product_variant_regional AS PVR_REL ON PPC_FACT.wshop_cd = PVR_REL.wshop_cd AND
      PPC_FACT.prod_variant_sid = PVR_REL.prod_variant_sid AND PVR_REL.dwh_valid_fg
   INNER JOIN ldl_dig_lec_share.v_dim_tax_class AS TAX_DIM ON PVR_REL.tax_class_cd = TAX_DIM.tax_class_cd AND PPC_FACT.wshop_cd
       = TAX_DIM.wshop_cd AND TAX_DIM.active_fg
  WHERE CURRENT_TIMESTAMP() BETWEEN PPC_FACT.active_from_tmsp AND PPC_FACT.active_to_tmsp) (SELECT wshop_cd,
   prod_variant_sid,
   MAX(tax_class_pct) AS tax_class_pct,
   CAST(NULLIF(STRING_AGG(vkp_curr_cd, ''), '') AS STRING) AS vkp_curr_cd,
   MAX(vkp_price_gross_local_val) AS vkp_price_gross_local_val,
   MAX(vkp_price_gross_eur_val) AS vkp_price_gross_eur_val,
   MAX(vkp_price_net_local_val) AS vkp_price_net_local_val,
   MAX(vkp_price_net_eur_val) AS vkp_price_net_eur_val,
   CAST(NULLIF(STRING_AGG(akp_curr_cd, ''), '') AS STRING) AS akp_curr_cd,
   MAX(akp_price_gross_local_val) AS akp_price_gross_local_val,
   MAX(akp_price_gross_eur_val) AS akp_price_gross_eur_val,
   MAX(akp_price_net_local_val) AS akp_price_net_local_val,
   MAX(akp_price_net_eur_val) AS akp_price_net_eur_val,
   CAST(NULLIF(STRING_AGG(uvp_curr_cd, ''), '') AS STRING) AS uvp_curr_cd,
   MAX(uvp_price_gross_local_val) AS uvp_price_gross_local_val,
   MAX(uvp_price_gross_eur_val) AS uvp_price_gross_eur_val,
   CAST(NULLIF(STRING_AGG(stp_curr_cd, ''), '') AS STRING) AS stp_curr_cd,
   MAX(stp_price_gross_local_val) AS stp_price_gross_local_val,
   MAX(stp_price_gross_eur_val) AS stp_price_gross_eur_val,
   CAST(NULLIF(STRING_AGG(vkz1_curr_cd, ''), '') AS STRING) AS vkz1_curr_cd,
   MAX(vkz1_price_gross_local_val) AS vkz1_price_gross_local_val,
   MAX(vkz1_price_gross_eur_val) AS vkz1_price_gross_eur_val,
   CAST(NULLIF(STRING_AGG(vkz2_curr_cd, ''), '') AS STRING) AS vkz2_curr_cd,
   MAX(vkz2_price_gross_local_val) AS vkz2_price_gross_local_val,
   MAX(vkz2_price_gross_eur_val) AS vkz2_price_gross_eur_val,
   CAST(NULLIF(STRING_AGG(ivp_curr_cd, ''), '') AS STRING) AS ivp_curr_cd,
   MAX(ivp_price_gross_local_val) AS ivp_price_gross_local_val,
   MAX(ivp_price_gross_eur_val) AS ivp_price_gross_eur_val,
   CAST(NULLIF(STRING_AGG(zvp_curr_cd, ''), '') AS STRING) AS zvp_curr_cd,
   MAX(zvp_price_gross_local_val) AS zvp_price_gross_local_val,
   MAX(zvp_price_gross_eur_val) AS zvp_price_gross_eur_val
  FROM CTE
  GROUP BY wshop_cd,
   prod_variant_sid);
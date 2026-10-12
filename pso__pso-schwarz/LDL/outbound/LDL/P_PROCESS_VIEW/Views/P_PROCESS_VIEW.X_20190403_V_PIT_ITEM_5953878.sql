CREATE OR REPLACE VIEW ldl_p_process_view.x_20190403_v_pit_item_5953878 AS SELECT ITM.client_id,
 ITM.item_sid,
 ITM.src_orig_item_nr AS orig_item_nr,
 ITM.item_name AS item_descr,
  CASE
  WHEN CTR.src_country_lidl_cd = 'AT'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_at,
  CASE
  WHEN CTR.src_country_lidl_cd = 'BE'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_be,
  CASE
  WHEN CTR.src_country_lidl_cd = 'BG'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_bg,
  CASE
  WHEN CTR.src_country_lidl_cd = 'CH'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_ch,
  CASE
  WHEN CTR.src_country_lidl_cd = 'CS'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_cs,
  CASE
  WHEN CTR.src_country_lidl_cd = 'CY'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_cy,
  CASE
  WHEN CTR.src_country_lidl_cd = 'CZ'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_cz,
  CASE
  WHEN CTR.src_country_lidl_cd = 'DE'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_de,
  CASE
  WHEN CTR.src_country_lidl_cd = 'DK'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_dk,
  CASE
  WHEN CTR.src_country_lidl_cd = 'ES'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_es,
  CASE
  WHEN CTR.src_country_lidl_cd = 'FI'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_fi,
  CASE
  WHEN CTR.src_country_lidl_cd = 'FR'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_fr,
  CASE
  WHEN CTR.src_country_lidl_cd = 'GB'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_gb,
  CASE
  WHEN CTR.src_country_lidl_cd = 'GR'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_gr,
  CASE
  WHEN CTR.src_country_lidl_cd = 'HR'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_hr,
  CASE
  WHEN CTR.src_country_lidl_cd = 'HU'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_hu,
  CASE
  WHEN CTR.src_country_lidl_cd = 'IE'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_ie,
  CASE
  WHEN CTR.src_country_lidl_cd = 'IT'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_it,
  CASE
  WHEN CTR.src_country_lidl_cd = 'LT'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_lt,
  CASE
  WHEN CTR.src_country_lidl_cd = 'MT'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_mt,
  CASE
  WHEN CTR.src_country_lidl_cd = 'NI'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_ni,
  CASE
  WHEN CTR.src_country_lidl_cd = 'NL'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_nl,
  CASE
  WHEN CTR.src_country_lidl_cd = 'PL'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_pl,
  CASE
  WHEN CTR.src_country_lidl_cd = 'PT'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_pt,
  CASE
  WHEN CTR.src_country_lidl_cd = 'RO'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_ro,
  CASE
  WHEN CTR.src_country_lidl_cd = 'RS'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_rs,
  CASE
  WHEN CTR.src_country_lidl_cd = 'SE'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_se,
  CASE
  WHEN CTR.src_country_lidl_cd = 'SI'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_si,
  CASE
  WHEN CTR.src_country_lidl_cd = 'SK'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_sk,
  CASE
  WHEN CTR.src_country_lidl_cd = 'US'
  THEN COALESCE(DSC.item_descr, ITM.item_name)
  ELSE NULL
  END AS item_descr_us
FROM ldl_p_lew_core_ac.v_item AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_country AS CTR ON ITM.client_id = CTR.country_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_descr AS DSC ON ITM.client_id = DSC.client_id AND ITM.item_sid = DSC.item_sid AND
   CTR.lang_sid = DSC.lang_sid
UNION ALL
SELECT country_sid,
 - 2 AS dm__operand1,
 'TOT' AS dm__operand2,
 'TOT' AS dm__operand3,
  CASE
  WHEN src_country_lidl_cd = 'AT'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_at,
  CASE
  WHEN src_country_lidl_cd = 'BE'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_be,
  CASE
  WHEN src_country_lidl_cd = 'BG'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_bg,
  CASE
  WHEN src_country_lidl_cd = 'CH'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_ch,
  CASE
  WHEN src_country_lidl_cd = 'CS'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_cs,
  CASE
  WHEN src_country_lidl_cd = 'CY'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_cy,
  CASE
  WHEN src_country_lidl_cd = 'CZ'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_cz,
  CASE
  WHEN src_country_lidl_cd = 'DE'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_de,
  CASE
  WHEN src_country_lidl_cd = 'DK'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_dk,
  CASE
  WHEN src_country_lidl_cd = 'ES'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_es,
  CASE
  WHEN src_country_lidl_cd = 'FI'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_fi,
  CASE
  WHEN src_country_lidl_cd = 'FR'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_fr,
  CASE
  WHEN src_country_lidl_cd = 'GB'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_gb,
  CASE
  WHEN src_country_lidl_cd = 'GR'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_gr,
  CASE
  WHEN src_country_lidl_cd = 'HR'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_hr,
  CASE
  WHEN src_country_lidl_cd = 'HU'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_hu,
  CASE
  WHEN src_country_lidl_cd = 'IE'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_ie,
  CASE
  WHEN src_country_lidl_cd = 'IT'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_it,
  CASE
  WHEN src_country_lidl_cd = 'LT'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_lt,
  CASE
  WHEN src_country_lidl_cd = 'MT'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_mt,
  CASE
  WHEN src_country_lidl_cd = 'NI'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_ni,
  CASE
  WHEN src_country_lidl_cd = 'NL'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_nl,
  CASE
  WHEN src_country_lidl_cd = 'PL'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_pl,
  CASE
  WHEN src_country_lidl_cd = 'PT'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_pt,
  CASE
  WHEN src_country_lidl_cd = 'RO'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_ro,
  CASE
  WHEN src_country_lidl_cd = 'RS'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_rs,
  CASE
  WHEN src_country_lidl_cd = 'SE'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_se,
  CASE
  WHEN src_country_lidl_cd = 'SI'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_si,
  CASE
  WHEN src_country_lidl_cd = 'SK'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_sk,
  CASE
  WHEN src_country_lidl_cd = 'US'
  THEN 'TOT'
  ELSE NULL
  END AS item_descr_us
FROM ldl_p_lew_core_ac.v_country;
CREATE OR REPLACE VIEW P_PROCESS_VIEW.X_20190403_V_PIT_ITEM_5953878_2 as
   SELECT
     itm.client_id,
   itm.item_sid,
   itm.src_orig_item_nr                      AS orig_item_nr,
   itm.item_name                             AS item_descr,
   CASE WHEN ctr.src_country_lidl_cd = 'AT' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_AT,
   CASE WHEN ctr.src_country_lidl_cd = 'BE' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_BE,
   CASE WHEN ctr.src_country_lidl_cd = 'BG' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_BG,
   CASE WHEN ctr.src_country_lidl_cd = 'CH' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_CH,
   CASE WHEN ctr.src_country_lidl_cd = 'CS' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_CS,
   CASE WHEN ctr.src_country_lidl_cd = 'CY' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_CY,
   CASE WHEN ctr.src_country_lidl_cd = 'CZ' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_CZ,
   CASE WHEN ctr.src_country_lidl_cd = 'DE' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_DE,
   CASE WHEN ctr.src_country_lidl_cd = 'DK' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_DK,
   CASE WHEN ctr.src_country_lidl_cd = 'ES' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_ES,
   CASE WHEN ctr.src_country_lidl_cd = 'FI' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_FI,
   CASE WHEN ctr.src_country_lidl_cd = 'FR' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_FR,
   CASE WHEN ctr.src_country_lidl_cd = 'GB' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_GB,
   CASE WHEN ctr.src_country_lidl_cd = 'GR' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_GR,
   CASE WHEN ctr.src_country_lidl_cd = 'HR' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_HR,
   CASE WHEN ctr.src_country_lidl_cd = 'HU' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_HU,
   CASE WHEN ctr.src_country_lidl_cd = 'IE' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_IE,
   CASE WHEN ctr.src_country_lidl_cd = 'IT' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_IT,
   CASE WHEN ctr.src_country_lidl_cd = 'LT' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_LT,
   CASE WHEN ctr.src_country_lidl_cd = 'MT' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_MT,
   CASE WHEN ctr.src_country_lidl_cd = 'NI' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_NI,
   CASE WHEN ctr.src_country_lidl_cd = 'NL' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_NL,
   CASE WHEN ctr.src_country_lidl_cd = 'PL' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_PL,
   CASE WHEN ctr.src_country_lidl_cd = 'PT' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_PT,
   CASE WHEN ctr.src_country_lidl_cd = 'RO' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_RO,
   CASE WHEN ctr.src_country_lidl_cd = 'RS_2' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_RS,
   CASE WHEN ctr.src_country_lidl_cd = 'SE' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_SE,
   CASE WHEN ctr.src_country_lidl_cd = 'SI' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_SI,
   CASE WHEN ctr.src_country_lidl_cd = 'SK' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_SK,
   CASE WHEN ctr.src_country_lidl_cd = 'US' THEN COALESCE(dsc.item_descr, itm.item_name) ELSE NULL END AS item_descr_US
  FROM  p_lew_core_ac.v_item_2 AS itm
   INNER JOIN  p_lew_core_ac.v_country_2 AS ctr
   ON  itm.client_id = ctr.country_sid
   LEFT JOIN  p_lew_core_ac.v_item_descr_2 AS dsc
   ON  itm.client_id = dsc.client_id
   AND itm.item_sid  = dsc.item_sid
   AND ctr.lang_sid  = dsc.lang_sid

   UNION ALL

   SELECT
     country_sid,
   -2,
   'TOT',
   'TOT',
   CASE WHEN src_country_lidl_cd = 'AT' THEN 'TOT' ELSE NULL END AS item_descr_AT,
   CASE WHEN src_country_lidl_cd = 'BE' THEN 'TOT' ELSE NULL END AS item_descr_BE,
   CASE WHEN src_country_lidl_cd = 'BG' THEN 'TOT' ELSE NULL END AS item_descr_BG,
   CASE WHEN src_country_lidl_cd = 'CH' THEN 'TOT' ELSE NULL END AS item_descr_CH,
   CASE WHEN src_country_lidl_cd = 'CS' THEN 'TOT' ELSE NULL END AS item_descr_CS,
   CASE WHEN src_country_lidl_cd = 'CY' THEN 'TOT' ELSE NULL END AS item_descr_CY,
   CASE WHEN src_country_lidl_cd = 'CZ' THEN 'TOT' ELSE NULL END AS item_descr_CZ,
   CASE WHEN src_country_lidl_cd = 'DE' THEN 'TOT' ELSE NULL END AS item_descr_DE,
   CASE WHEN src_country_lidl_cd = 'DK' THEN 'TOT' ELSE NULL END AS item_descr_DK,
   CASE WHEN src_country_lidl_cd = 'ES' THEN 'TOT' ELSE NULL END AS item_descr_ES,
   CASE WHEN src_country_lidl_cd = 'FI' THEN 'TOT' ELSE NULL END AS item_descr_FI,
   CASE WHEN src_country_lidl_cd = 'FR' THEN 'TOT' ELSE NULL END AS item_descr_FR,
   CASE WHEN src_country_lidl_cd = 'GB' THEN 'TOT' ELSE NULL END AS item_descr_GB,
   CASE WHEN src_country_lidl_cd = 'GR' THEN 'TOT' ELSE NULL END AS item_descr_GR,
   CASE WHEN src_country_lidl_cd = 'HR' THEN 'TOT' ELSE NULL END AS item_descr_HR,
   CASE WHEN src_country_lidl_cd = 'HU' THEN 'TOT' ELSE NULL END AS item_descr_HU,
   CASE WHEN src_country_lidl_cd = 'IE' THEN 'TOT' ELSE NULL END AS item_descr_IE,
   CASE WHEN src_country_lidl_cd = 'IT' THEN 'TOT' ELSE NULL END AS item_descr_IT,
   CASE WHEN src_country_lidl_cd = 'LT' THEN 'TOT' ELSE NULL END AS item_descr_LT,
   CASE WHEN src_country_lidl_cd = 'MT' THEN 'TOT' ELSE NULL END AS item_descr_MT,
   CASE WHEN src_country_lidl_cd = 'NI' THEN 'TOT' ELSE NULL END AS item_descr_NI,
   CASE WHEN src_country_lidl_cd = 'NL' THEN 'TOT' ELSE NULL END AS item_descr_NL,
   CASE WHEN src_country_lidl_cd = 'PL' THEN 'TOT' ELSE NULL END AS item_descr_PL,
   CASE WHEN src_country_lidl_cd = 'PT' THEN 'TOT' ELSE NULL END AS item_descr_PT,
   CASE WHEN src_country_lidl_cd = 'RO' THEN 'TOT' ELSE NULL END AS item_descr_RO,
   CASE WHEN src_country_lidl_cd = 'RS_2' THEN 'TOT' ELSE NULL END AS item_descr_RS,
   CASE WHEN src_country_lidl_cd = 'SE' THEN 'TOT' ELSE NULL END AS item_descr_SE,
   CASE WHEN src_country_lidl_cd = 'SI' THEN 'TOT' ELSE NULL END AS item_descr_SI,
   CASE WHEN src_country_lidl_cd = 'SK' THEN 'TOT' ELSE NULL END AS item_descr_SK,
   CASE WHEN src_country_lidl_cd = 'US' THEN 'TOT' ELSE NULL END AS item_descr_US
  FROM  p_lew_core_ac.v_country_2
;
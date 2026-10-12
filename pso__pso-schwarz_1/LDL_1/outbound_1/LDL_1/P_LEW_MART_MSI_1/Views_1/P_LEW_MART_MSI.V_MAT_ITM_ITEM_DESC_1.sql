CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_itm_item_desc_1 (client_id, item_id, orig_item_nr, item_desc_at,
item_desc_be, item_desc_bg, item_desc_ch, item_desc_cy, item_desc_cz, item_desc, item_desc_dk, item_desc_ee,
item_desc_es, item_desc_fi, item_desc_fr, item_desc_gb, item_desc_gr, item_desc_hr, item_desc_hu, item_desc_ie,
item_desc_it, item_desc_lt, item_desc_lv, item_desc_ni, item_desc_nl, item_desc_de, item_desc_pl, item_desc_pt,
item_desc_ro, item_desc_se, item_desc_si, item_desc_sk, item_desc_cs, item_desc_mt, item_desc_us, item_desc_rs) AS
SELECT ITM.client_id,
 ITM.item_sid AS item_id,
 ROUND(CAST(COALESCE(ITM_S.src_matnr, ITM.src_matnr, ITM.src_orig_item_nr) AS BIGNUMERIC), 0) AS orig_item_nr,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'AT'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_at,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'BE'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_be,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'BG'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_bg,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'CH'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_ch,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'CY'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_cy,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'CZ'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_cz,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'INTEGER '
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'DK'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_dk,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'EE'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_ee,
 MAX(CASE
   WHEN LANG.language_iso_cd IN ('ES', 'CS')
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_es,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'FI'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_fi,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'FR'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_fr,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'GB'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_gb,
 MAX(CASE
   WHEN LANG.language_iso_cd IN ('GR', 'CY')
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_gr,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'HR'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_hr,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'HU'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_hu,
 MAX(CASE
   WHEN LANG.language_iso_cd IN ('IE', 'NI')
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_ie,
 MAX(CASE
   WHEN LANG.language_iso_cd IN ('IT', 'MT')
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_it,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'LT'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_lt,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'LV'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_lv,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'NI'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_ni,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'NL'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_nl,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'DE'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_de,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'PL'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_pl,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'PT'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_pt,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'RO'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_ro,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'SE'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_se,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'SI'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_si,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'SK'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_sk,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'CS'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_cs,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'MT'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_mt,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'US'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_us,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'RS_1'
   THEN COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr)
   ELSE NULL
   END) AS item_desc_rs
FROM ldl_p_lew_core_ac.v_item_1 AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLI ON ITM.client_id = CLI.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country_1 AS CTRY ON CLI.country_sid = CTRY.country_sid OR CTRY.src_country_lidl_cd =
   'INTEGER '
 INNER JOIN ldl_p_lew_core_ac.v_report_language_1 AS RLANG ON CTRY.lang_sid = RLANG.lang_sid
 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras_1 AS LANG ON TRIM(LANG.sap_lang_cd) = TRIM(RLANG.iso_cd) AND TRIM(CTRY.src_country_lidl_cd
    ) = TRIM(LANG.language_iso_cd)
 LEFT JOIN ldl_p_lew_core_ac.v_item_descr_1 AS DESCR ON ITM.client_id = DESCR.client_id AND ITM.item_sid = DESCR.item_sid
  AND RLANG.lang_sid = DESCR.lang_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_descr_1 AS DESCR_STIFTUNG ON ITM.client_id = DESCR_STIFTUNG.client_id AND ITM.item_sid
     = DESCR_STIFTUNG.item_sid AND DESCR_STIFTUNG.lang_cd = '@'
 LEFT JOIN ldl_p_lew_core_ac.v_item_1 AS ITM_S ON ITM.client_id = ITM_S.client_id AND ITM.item_sid_config = ITM_S.item_sid
   
 LEFT JOIN ldl_p_lew_core_ac.v_item_descr_1 AS DESCR_SAMMEL ON ITM.client_id = DESCR_SAMMEL.client_id AND ITM_S.item_sid =
    DESCR_SAMMEL.item_sid AND RLANG.lang_sid = DESCR_SAMMEL.lang_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_descr_1 AS DESCR_STIFTUNG_SAMMEL ON ITM.client_id = DESCR_STIFTUNG_SAMMEL.client_id
   AND ITM_S.item_sid = DESCR_STIFTUNG_SAMMEL.item_sid AND DESCR_STIFTUNG_SAMMEL.lang_cd = '@'
GROUP BY ITM.client_id,
 item_id,
 orig_item_nr;
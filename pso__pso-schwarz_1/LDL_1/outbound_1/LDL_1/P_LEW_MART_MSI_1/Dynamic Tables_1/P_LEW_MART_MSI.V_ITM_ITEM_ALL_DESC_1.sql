CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_itm_item_all_desc_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT ITM.client_id,
 ITM.item_sid AS item_id,
 D.item_descr AS item_desc,
 CAST(COALESCE(ROUND(SAFE_CAST(ITM.config_item_cd AS BIGNUMERIC), 0), CASE
    WHEN ITM.item_sid < 0
    THEN ITM.item_sid
    ELSE COALESCE(ROUND(CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0), ITM.item_sid)
    END) AS BIGNUMERIC) AS orig_item_nr,
 LANG.language_id
FROM ldl_p_lew_core_ac.v_item_1 AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_item_descr_1 AS D ON ITM.client_id = D.client_id AND ITM.item_sid = D.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLI ON ITM.client_id = CLI.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country_1 AS CTRY ON CLI.country_sid = CTRY.country_sid OR CTRY.src_country_lidl_cd =
   'INTEGER '
 INNER JOIN ldl_p_lew_core_ac.v_report_language_1 AS RLANG ON D.lang_sid = RLANG.lang_sid
 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras_1 AS LANG ON TRIM(LANG.sap_lang_cd) = TRIM(RLANG.iso_cd) AND TRIM(CTRY.src_country_lidl_cd
    ) = TRIM(LANG.language_iso_cd);
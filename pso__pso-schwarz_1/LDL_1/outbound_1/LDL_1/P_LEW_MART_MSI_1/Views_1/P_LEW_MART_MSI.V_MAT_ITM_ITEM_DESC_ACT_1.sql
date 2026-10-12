CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_itm_item_desc_act_1 (client_id, item_id, item_desc, orig_item_nr,
language_id) AS SELECT ITM.client_id,
 ITM.item_sid AS item_id,
 COALESCE(DESCR.item_descr, DESCR_STIFTUNG.item_descr) AS item_desc,
 ROUND(CAST(COALESCE(ITM_S.src_matnr, ITM.src_matnr, ITM.src_orig_item_nr) AS BIGNUMERIC), 0) AS orig_item_nr,
 LANG.language_id
FROM ldl_p_lew_core_ac.v_item_1 AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLI ON ITM.client_id = CLI.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country_1 AS CTRY ON CLI.country_sid = CTRY.country_sid OR CTRY.src_country_lidl_cd =
   'INTEGER '
 INNER JOIN ldl_p_lew_core_ac.v_report_language_1 AS RLANG ON CTRY.lang_sid = RLANG.lang_sid
 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras_1 AS LANG ON TRIM(LANG.sap_lang_cd) = TRIM(RLANG.iso_cd) AND TRIM(CTRY.src_country_lidl_cd
    ) = TRIM(LANG.language_iso_cd)
 LEFT JOIN ldl_p_lew_core_ac.v_item_1 AS ITM_S ON ITM.client_id = ITM_S.client_id AND ITM.item_sid_config = ITM_S.item_sid
   
 LEFT JOIN ldl_p_lew_core_ac.v_item_descr_1 AS DESCR ON ITM.client_id = DESCR.client_id AND COALESCE(ITM_S.item_sid, ITM.item_sid
     ) = DESCR.item_sid AND RLANG.lang_sid = DESCR.lang_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_descr_1 AS DESCR_STIFTUNG ON ITM.client_id = DESCR_STIFTUNG.client_id AND COALESCE(ITM_S
     .item_sid, ITM.item_sid) = DESCR_STIFTUNG.item_sid AND DESCR_STIFTUNG.lang_cd = '@';
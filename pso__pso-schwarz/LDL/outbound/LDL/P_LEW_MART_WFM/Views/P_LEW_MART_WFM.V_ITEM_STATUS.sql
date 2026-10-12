CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_status (src_country_lidl_cd, item_status, item_status_desc, language_id
) AS SELECT CNTRY.src_country_lidl_cd,
 ITM_STAT.item_status,
 ITM_STAT.item_status_desc,
 ITM_STAT.language_id
FROM ldl_p_lew_core_ac.v_wawi_ref_item_status AS ITM_STAT
 INNER JOIN ldl_p_lew_core_ac.v_country AS CNTRY ON ITM_STAT.client_id = CNTRY.country_sid
WHERE ITM_STAT.language_id = ITM_STAT.client_id
 AND CNTRY.src_country_lidl_cd <> 'INTEGER ';
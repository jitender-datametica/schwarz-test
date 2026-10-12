CREATE OR REPLACE VIEW ldl_p_lew_process.v_brand_elwis_1 AS SELECT item_sid_config,
 MIN(brand_1) AS brand_1
FROM (SELECT CORE_ITEM.item_sid_config,
    WAWI.brand_1
   FROM ldl_p_lew_core_ac.v_item_1 AS CORE_ITEM
    LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_1 AS WAWI ON CORE_ITEM.client_id = WAWI.client_id AND CORE_ITEM.item_sid
       = WAWI.item_sid
   WHERE CORE_ITEM.src_matnr IS NOT NULL
    AND COALESCE(CAST(CORE_ITEM.log_var_cd AS BIGNUMERIC), 4) IN (2, 3)
    AND WAWI.brand_1 IS NOT NULL
   UNION ALL
   SELECT ELWIS_MAIN_ITEM.item_sid,
    WAWI.brand_1
   FROM ldl_p_lew_core_ac.v_item_1 AS ELWIS_MAIN_ITEM
    LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_1 AS WAWI ON ELWIS_MAIN_ITEM.client_id = WAWI.client_id AND
      ELWIS_MAIN_ITEM.item_sid = WAWI.item_sid
   WHERE ELWIS_MAIN_ITEM.src_matnr IS NOT NULL
    AND COALESCE(CAST(ELWIS_MAIN_ITEM.log_var_cd AS BIGNUMERIC), 4) = 1
    AND WAWI.brand_1 IS NOT NULL) AS t
GROUP BY item_sid_config;
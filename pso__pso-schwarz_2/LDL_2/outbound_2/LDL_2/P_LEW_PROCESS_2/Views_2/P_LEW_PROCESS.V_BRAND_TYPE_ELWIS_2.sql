CREATE OR REPLACE VIEW ldl_p_lew_process.v_brand_type_elwis_2 AS SELECT item_sid_config,
 MIN(brand_type_mark) AS brand_type_cd
FROM (SELECT CORE_ITEM.item_sid_config,
    dim_brand_type.brand_type_desc AS brand_type_mark
   FROM ldl_p_lew_core_ac.v_item_2 AS CORE_ITEM
    LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS WAWI ON CORE_ITEM.client_id = WAWI.client_id AND CORE_ITEM.item_sid
       = WAWI.item_sid
    LEFT JOIN (SELECT DISTINCT brand_type_id,
      brand_type_desc
     FROM ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_2
     WHERE language_id = 23) AS dim_brand_type ON WAWI.brand_type_id = dim_brand_type.brand_type_id
   WHERE CORE_ITEM.src_matnr IS NOT NULL
    AND COALESCE(CAST(CORE_ITEM.log_var_cd AS BIGNUMERIC), 4) IN (2, 3)
    AND dim_brand_type.brand_type_desc IS NOT NULL
   UNION ALL
   SELECT ELWIS_MAIN_ITEM.item_sid,
    dim_brand_type.brand_type_desc AS brand_type_mark
   FROM ldl_p_lew_core_ac.v_item_2 AS ELWIS_MAIN_ITEM
    LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS WAWI ON ELWIS_MAIN_ITEM.client_id = WAWI.client_id AND
      ELWIS_MAIN_ITEM.item_sid = WAWI.item_sid
    LEFT JOIN (SELECT DISTINCT brand_type_id,
      brand_type_desc
     FROM ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_2
     WHERE language_id = 23) AS dim_brand_type ON WAWI.brand_type_id = dim_brand_type.brand_type_id
   WHERE ELWIS_MAIN_ITEM.src_matnr IS NOT NULL
    AND COALESCE(CAST(ELWIS_MAIN_ITEM.log_var_cd AS BIGNUMERIC), 4) = 1
    AND dim_brand_type.brand_type_desc IS NOT NULL) AS t
GROUP BY item_sid_config;
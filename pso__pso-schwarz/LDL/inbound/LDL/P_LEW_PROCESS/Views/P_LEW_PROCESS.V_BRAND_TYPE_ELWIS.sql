CREATE OR REPLACE VIEW P_LEW_PROCESS.V_BRAND_TYPE_ELWIS
AS
   SELECT
        t.item_sid_config,
   MIN(t.brand_type_mark) AS brand_type_cd
   FROM (SELECT core_item.item_sid_config,
   dim_brand_type.brand_type_desc as brand_type_mark
         FROM p_lew_core_ac.v_item core_item
   LEFT JOIN p_lew_core_ac.v_wawi_itm_item_act wawi
   ON wawi.client_id = core_item.client_id
   AND wawi.item_sid = core_item.item_sid
   LEFT JOIN (SELECT DISTINCT brand_type_id,
   brand_type_desc
                    FROM p_lew_core_ac.v_wawi_ref_itm_list_type
                    WHERE language_id=23) dim_brand_type
   ON wawi.brand_type_id = dim_brand_type.brand_type_id
   WHERE core_item.src_matnr IS NOT NULL
   AND COALESCE(core_item.log_var_cd,4) IN (2, 3)
   AND TRY_CAST(COALESCE(core_item.src_orig_item_nr,core_item.config_item_cd,core_item.src_matnr) AS DECIMAL(18,0)) IS NOT NULL
   AND brand_type_mark IS NOT NULL
UNION ALL
   SELECT elwis_main_item.item_sid,
   dim_brand_type.brand_type_desc as brand_type_mark
         FROM p_lew_core_ac.v_item elwis_main_item
   LEFT JOIN p_lew_core_ac.v_wawi_itm_item_act wawi
   ON wawi.client_id = elwis_main_item.client_id
   AND wawi.item_sid = elwis_main_item.item_sid
   LEFT JOIN (SELECT DISTINCT brand_type_id,
   brand_type_desc
                    FROM p_lew_core_ac.v_wawi_ref_itm_list_type
                    WHERE language_id=23) dim_brand_type
   ON wawi.brand_type_id = dim_brand_type.brand_type_id
   WHERE elwis_main_item.src_matnr IS NOT NULL
   AND COALESCE(elwis_main_item.log_var_cd,4) = 1
   AND TRY_CAST(COALESCE(elwis_main_item.src_orig_item_nr,elwis_main_item.config_item_cd,elwis_main_item.src_matnr) AS DECIMAL(18,0)) IS NOT NULL
   AND brand_type_mark IS NOT NULL
) t
GROUP BY t.item_sid_config;
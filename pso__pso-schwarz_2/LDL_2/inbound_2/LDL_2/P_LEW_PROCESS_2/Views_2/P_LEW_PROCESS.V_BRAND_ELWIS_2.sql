CREATE OR REPLACE VIEW P_LEW_PROCESS.V_BRAND_ELWIS_2
   AS
      SELECT
           t.item_sid_config,
      MIN(t.brand_2) AS brand_2
      FROM (SELECT core_item.item_sid_config,
      wawi.brand_2 as brand_2
            FROM p_lew_core_ac.v_item_2 core_item
      LEFT JOIN p_lew_core_ac.v_wawi_itm_item_act_2 wawi
      ON wawi.client_id = core_item.client_id
      AND wawi.item_sid = core_item.item_sid
     WHERE core_item.src_matnr IS NOT NULL
     AND COALESCE(core_item.log_var_cd,4) IN (2, 3)
     AND TRY_CAST(COALESCE(core_item.src_orig_item_nr,core_item.config_item_cd,core_item.src_matnr) AS DECIMAL(18,0)) IS NOT NULL
      AND brand_2 IS NOT NULL
UNION ALL
      SELECT elwis_main_item.item_sid,
      wawi.brand_2 as brand_2
            FROM p_lew_core_ac.v_item_2 elwis_main_item
      LEFT JOIN p_lew_core_ac.v_wawi_itm_item_act_2 wawi
      ON wawi.client_id = elwis_main_item.client_id
      AND wawi.item_sid = elwis_main_item.item_sid
     WHERE elwis_main_item.src_matnr IS NOT NULL
     AND COALESCE(elwis_main_item.log_var_cd,4) = 1
     AND TRY_CAST(COALESCE(elwis_main_item.src_orig_item_nr,elwis_main_item.config_item_cd,elwis_main_item.src_matnr) AS DECIMAL(18,0)) IS NOT NULL
      AND brand_2 IS NOT NULL
) t
GROUP BY t.item_sid_config;
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_campaign_info_wawi_2 AS SELECT DISTINCT ADV.client_id,
 CNTRY.src_country_lidl_cd AS country_2,
 LOC.src_wh_id AS wh_id,
 ITM.src_orig_item_nr AS orig_item_nr,
 ADV.price_retail_adv AS gross_price,
 ADV.price_retail_net_adv AS net_price,
 ADV.repeat_fg,
 ADV.dat_adv AS dat_adv_date,
 ADV.week_adv
FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_2 AS ADV
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC ON ADV.client_id = LOC.client_id AND ADV.wh_loc_sid = LOC.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS CNTRY ON LOC.client_id = CNTRY.country_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_2 AS ITM ON ADV.client_id = ITM.client_id AND ADV.item_sid = ITM.item_sid
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ADV.client_id AS STRING), CAST(LOC.src_wh_id AS STRING), ITM.src_orig_item_nr
      , ADV.dat_adv ORDER BY ADV.repeat_fg IS NULL, ADV.repeat_fg, ADV.price_retail_net_adv IS NULL, ADV.price_retail_net_adv
      , ADV.week_adv IS NULL, ADV.week_adv)) = 1;
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_campaign_info_sap AS
/* Anforderung von WFM: der Netto Wert soll aus dem Brutto-Wert berechnet werden */ SELECT ADV_APT.client_id,
 CNTRY.src_country_lidl_cd AS country,
 ADV_APT.wh_loc_sid,
 LOC.src_wh_id AS wh_id,
 ADV_APT.orig_item_nr,
 ADV_APT.dat_adv AS dat_adv_date,
  'KW ' || ADV_APT.dat_adv_desc AS week_adv,
 MAX(LOC_SALES_COND.cond_val_eff_calc) AS price_max_gross,
 MAX(CASE
   WHEN COALESCE(LOC_SALES_COND.tax_rate_calc, 0) = 0
   THEN LOC_SALES_COND.cond_val_eff_calc
   ELSE LOC_SALES_COND.cond_val_eff_calc / (1 + LOC_SALES_COND.tax_rate_calc / 100)
   END) AS price_max_net,
 MAX(CASE
   WHEN COALESCE(PROM_ITM_HIST.product_cond_mark, '-') IN ('U', 'W')
   THEN 1
   ELSE 0
   END) AS repeat_fg,
 MIN(PROM_ITM_HIST.prom_listing_type_mark) AS apt_list_type_cd,
 MAX(ADV_APT.timestamp_load) AS timestamp_load
FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_s_ap AS ADV_APT
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON ADV_APT.client_id = LOC.client_id AND ADV_APT.wh_loc_sid = LOC.loc_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_country AS CNTRY ON LOC.client_id = CNTRY.country_sid
 INNER JOIN ldl_p_lew_core_ac.v_item AS ITM ON ADV_APT.client_id = ITM.client_id AND ROUND(CAST(COALESCE(ITM.config_item_cd, ITM.src_matnr) AS BIGNUMERIC)
     , 0) = ADV_APT.orig_item_nr AND CAST(ITM.log_var_cd AS INTEGER) IN (1, 2, 3)
 INNER JOIN ldl_p_lew_core_ac.v_item_hist AS ITM_HIST ON ITM.client_id = ITM_HIST.client_id AND ITM.item_sid = ITM_HIST
    .item_sid AND ADV_APT.dat_adv BETWEEN ITM_HIST.dwh_valid_from AND ITM_HIST.dwh_valid_to
 INNER JOIN ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm AS LOC_SALES_COND ON ADV_APT.client_id = LOC_SALES_COND.client_id
       AND ADV_APT.wh_loc_sid = LOC_SALES_COND.loc_sid AND ITM_HIST.item_sid = LOC_SALES_COND.item_sid AND ITM_HIST.uom_sid_base
     = LOC_SALES_COND.uom_sid_cond AND ADV_APT.dat_adv BETWEEN LOC_SALES_COND.dwh_valid_from AND LOC_SALES_COND.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_promotion_item_hist AS PROM_ITM_HIST ON ITM_HIST.client_id = PROM_ITM_HIST.client_id AND
       ITM_HIST.item_sid = PROM_ITM_HIST.item_sid AND ITM_HIST.uom_sid_base = PROM_ITM_HIST.uom_sid_sales AND CAST(PROM_ITM_HIST.prom_listing_type_mark AS INTEGER)
     IN (1, 3) AND ADV_APT.dat_adv = PROM_ITM_HIST.sales_from_dt AND ADV_APT.dat_adv BETWEEN PROM_ITM_HIST.dwh_valid_from
   AND PROM_ITM_HIST.dwh_valid_to /* im DWH 1.0 wurde der  Zeitraum eingeschränkt */
WHERE ADV_APT.dat_adv BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 20 DAY) AND (DATE_ADD(CURRENT_DATE, INTERVAL 10 DAY))
GROUP BY ADV_APT.client_id,
 country,
 ADV_APT.wh_loc_sid,
 wh_id,
 ADV_APT.orig_item_nr,
 dat_adv_date,
 ADV_APT.dat_adv_desc;
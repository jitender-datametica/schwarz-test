CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_CAMPAIGN_INFO_SAP as
   SELECT  adv_apt.client_id                     AS client_id,
   cntry.src_country_lidl_cd             AS country,
   adv_apt.wh_loc_sid                    AS wh_loc_sid,
   loc.src_wh_id                         AS wh_id,
   adv_apt.orig_item_nr                  AS orig_item_nr,
   adv_apt.dat_adv                       AS dat_adv_date,
   'KW '|| adv_apt.dat_adv_desc          AS week_adv,
   MAX(loc_sales_cond.cond_val_eff_calc) AS price_max_gross,
   /* Anforderung von WFM: der Netto Wert soll aus dem Brutto-Wert berechnet werden */
   MAX(CASE COALESCE(loc_sales_cond.tax_rate_calc, 0)
       WHEN 0 THEN loc_sales_cond.cond_val_eff_calc
       ELSE (loc_sales_cond.cond_val_eff_calc/(1+ loc_sales_cond.tax_rate_calc/100))
   END) AS price_max_net,
   MAX(CASE WHEN COALESCE(prom_itm_hist.product_cond_mark, '-') IN ('U', 'W') THEN 1 ELSE 0 END) AS repeat_fg,
   MIN(prom_itm_hist.prom_listing_type_mark) AS apt_list_type_cd,
   MAX(adv_apt.timestamp_load)               AS timestamp_load
FROM p_lew_core_ac.v_wawi_adv_item_advertising_s_ap adv_apt
   INNER JOIN p_lew_core_ac.v_location AS loc
   ON loc.client_id = adv_apt.client_id
   AND loc.loc_sid = adv_apt.wh_loc_sid
   INNER JOIN p_lew_core_ac.v_country AS cntry
   ON loc.client_id = cntry.country_sid
   INNER JOIN p_lew_core_ac.v_item AS itm
   ON itm.client_id       = adv_apt.client_id
   AND CAST(COALESCE(itm.config_item_cd, itm.src_matnr) AS DECIMAL(18,0)) = adv_apt.orig_item_nr
   AND itm.log_var_cd IN (1,2,3)
   INNER JOIN p_lew_core_ac.v_item_hist AS itm_hist
   ON itm_hist.client_id   = itm.client_id
   AND itm_hist.item_sid    = itm.item_sid
   AND adv_apt.dat_adv BETWEEN itm_hist.dwh_valid_from AND itm_hist.dwh_valid_to
   INNER JOIN p_lew_bil_ac.v_item_loc_sales_cond_denorm AS loc_sales_cond
   ON loc_sales_cond.client_id  = adv_apt.client_id
   AND loc_sales_cond.loc_sid      = adv_apt.wh_loc_sid
   AND loc_sales_cond.item_sid     = itm_hist.item_sid
   AND loc_sales_cond.uom_sid_cond = itm_hist.uom_sid_base
   AND adv_apt.dat_adv BETWEEN loc_sales_cond.dwh_valid_from AND loc_sales_cond.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_promotion_item_hist AS prom_itm_hist
   ON prom_itm_hist.client_id = itm_hist.client_id
   AND prom_itm_hist.item_sid = itm_hist.item_sid
   AND prom_itm_hist.uom_sid_sales = itm_hist.uom_sid_base
   AND prom_itm_hist.prom_listing_type_mark in (1,3)
   AND prom_itm_hist.sales_from_dt = adv_apt.dat_adv
   AND adv_apt.dat_adv BETWEEN prom_itm_hist.dwh_valid_from AND prom_itm_hist.dwh_valid_to

 /*im DWH 1.0 wurde der  Zeitraum eingeschränkt*/
 WHERE adv_apt.dat_adv BETWEEN CURRENT_DATE - 20 AND CURRENT_DATE + 10

 GROUP BY adv_apt.client_id
         ,cntry.src_country_lidl_cd
         ,adv_apt.wh_loc_sid
         ,loc.src_wh_id
         ,adv_apt.orig_item_nr
         ,adv_apt.dat_adv
         ,adv_apt.dat_adv_desc

;
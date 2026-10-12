/* Werbetermine zu Artikel_2 */ /* APT advertising items */
/* Anforderung von WFM: der Netto Wert soll aus dem Brutto-Wert berechnet werden */ /* WaWi advertising items */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_campaign_info_2 AS SELECT client_id,
 country_lidl_cd,
 wh_id,
 item_2,
 dat_adv_date,
 week_adv,
 gross_price,
 net_price,
 repeat_fg,
 apt_list_type_cd,
 dat_dayend,
 load_id
FROM (SELECT apt_adv.client_id,
   apt_adv.country_lidl_cd,
   apt_adv.wh_id,
   apt_adv.item_2,
   apt_adv.dat_adv_date,
   apt_adv.week_adv,
   apt_adv.gross_price,
   apt_adv.net_price,
   apt_adv.repeat_fg,
   apt_adv.apt_list_type_cd,
   apt_adv.dat_dayend,
   apt_adv.load_id,
   adp_adv.client_id AS flag
  FROM (SELECT ADV_APT.client_id,
     CNTRY.src_country_lidl_cd AS country_lidl_cd,
     LOC.src_wh_id AS wh_id,
     CAST(ADV_APT.orig_item_nr AS BIGNUMERIC) AS item_2,
     ADV_APT.dat_adv AS dat_adv_date,
      'KW ' || ADV_APT.dat_adv_desc AS week_adv,
     MAX(LOC_SALES_COND.cond_val_eff_calc) AS gross_price,
     MAX(CASE
       WHEN COALESCE(LOC_SALES_COND.tax_rate_calc, 0) = 0
       THEN LOC_SALES_COND.cond_val_eff_calc
       ELSE LOC_SALES_COND.cond_val_eff_calc / (1 + LOC_SALES_COND.tax_rate_calc / 100)
       END) AS net_price,
     MAX(CASE
       WHEN COALESCE(PROM_ITM_HIST.product_cond_mark, '-') IN ('U', 'W')
       THEN 1
       ELSE 0
       END) AS repeat_fg,
     MIN(PROM_ITM_HIST.prom_listing_type_mark) AS apt_list_type_cd,
     DATE(NULL) AS dat_dayend,
     CAST(NULL AS BIGNUMERIC) AS load_id
    FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_s_ap_2 AS ADV_APT
     INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC ON ADV_APT.client_id = LOC.client_id AND ADV_APT.wh_loc_sid = LOC.loc_sid
       
     INNER JOIN ldl_p_lew_core_ac.v_country_2 AS CNTRY ON LOC.client_id = CNTRY.country_sid
     INNER JOIN ldl_p_lew_core_ac.v_item_2 AS ITM ON ADV_APT.client_id = ITM.client_id AND ROUND(SAFE_CAST(COALESCE(ITM.config_item_cd
           , ITM.src_matnr) AS BIGNUMERIC), 0) = ADV_APT.orig_item_nr AND CAST(ITM.log_var_cd AS INTEGER) IN (1, 2, 3)
     INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS ITM_HIST ON ITM.client_id = ITM_HIST.client_id AND ITM.item_sid =
        ITM_HIST.item_sid AND ADV_APT.dat_adv BETWEEN ITM_HIST.dwh_valid_from AND ITM_HIST.dwh_valid_to
     INNER JOIN ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm_2 AS LOC_SALES_COND ON ADV_APT.client_id = LOC_SALES_COND.client_id
           AND ADV_APT.wh_loc_sid = LOC_SALES_COND.loc_sid AND ITM_HIST.item_sid = LOC_SALES_COND.item_sid AND ITM_HIST
        .uom_sid_base = LOC_SALES_COND.uom_sid_cond AND ADV_APT.dat_adv BETWEEN LOC_SALES_COND.dwh_valid_from AND
       LOC_SALES_COND.dwh_valid_to
     INNER JOIN ldl_p_lew_core_ac.v_promotion_item_hist_2 AS PROM_ITM_HIST ON ITM_HIST.client_id = PROM_ITM_HIST.client_id
            AND ITM_HIST.item_sid = PROM_ITM_HIST.item_sid AND ITM_HIST.uom_sid_base = PROM_ITM_HIST.uom_sid_sales AND CAST(PROM_ITM_HIST.prom_listing_type_mark AS INTEGER)
         IN (1, 3) AND ADV_APT.dat_adv = PROM_ITM_HIST.sales_from_dt AND ADV_APT.dat_adv BETWEEN PROM_ITM_HIST.dwh_valid_from
       AND PROM_ITM_HIST.dwh_valid_to /* im DWH 1.0 wurde der  Zeitraum eingeschränkt */
    WHERE ADV_APT.dat_adv BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 20 DAY) AND (DATE_ADD(CURRENT_DATE, INTERVAL 10 DAY))
    GROUP BY ADV_APT.client_id,
     country_lidl_cd,
     ADV_APT.wh_loc_sid,
     wh_id,
     ADV_APT.orig_item_nr,
     dat_adv_date,
     ADV_APT.dat_adv_desc) AS apt_adv
   LEFT JOIN (SELECT DISTINCT CAMP_HIST.client_id,
     CAMP_HIST.campaign_start_dt,
     CAMP_HIST.campaign_end_dt,
     ROUND(SAFE_CAST(COALESCE(ITEM0.config_item_cd, ITEM0.src_matnr) AS BIGNUMERIC), 0) AS item_2
    FROM ldl_p_lew_core_ac.v_campaign_hist_2 AS CAMP_HIST
     INNER JOIN ldl_p_lew_core_ac.v_campaign_element_hist_2 AS CAMP_ELEM_HIST ON CAMP_HIST.client_id = CAMP_ELEM_HIST.client_id
        AND CAMP_HIST.campaign_sid /* Artikel_2 */ = CAMP_ELEM_HIST.campaign_sid
     INNER JOIN ldl_p_lew_core_ac.v_item_2 AS ITEM0 ON CAMP_ELEM_HIST.client_id = ITEM0.client_id AND CAMP_ELEM_HIST.item_sid
        = ITEM0.item_sid
    WHERE CAMP_HIST.campaign_start_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 20 DAY) AND (DATE_ADD(CURRENT_DATE,
        INTERVAL 10 DAY))
     AND CAMP_HIST.client_id = 33
     AND CURRENT_DATE BETWEEN CAMP_HIST.dwh_valid_from AND CAMP_HIST.dwh_valid_to
     AND CURRENT_DATE BETWEEN CAMP_ELEM_HIST.dwh_valid_from AND CAMP_ELEM_HIST.dwh_valid_to
     AND CAMP_HIST.deleted_fg = 0) AS adp_adv ON apt_adv.client_id = adp_adv.client_id AND apt_adv.dat_adv_date =
      adp_adv.campaign_start_dt AND apt_adv.item_2 = adp_adv.item_2) AS final_us
WHERE flag IS NOT NULL
UNION ALL
SELECT DISTINCT ADV.client_id,
 CNTRY.src_country_lidl_cd AS country_lidl_cd,
 LOC.src_wh_id AS wh_id,
 ROUND(SAFE_CAST(COALESCE(ITM.src_orig_item_nr, ITM.config_item_cd) AS BIGNUMERIC), 0) AS item_2,
 ADV.dat_adv AS dat_adv_date,
 ADV.week_adv,
 ADV.price_retail_adv AS gross_price,
 ADV.price_retail_net_adv AS net_price,
 ADV.repeat_fg,
 CAST(NULL AS STRING) AS apt_list_type_cd,
 ADV.dat_dayend,
 ADV.load_id
FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_2 AS ADV
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC ON ADV.client_id = LOC.client_id AND ADV.wh_loc_sid = LOC.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS CNTRY ON LOC.client_id = CNTRY.country_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_2 AS ITM ON ADV.client_id = ITM.client_id AND ADV.item_sid /* 29.05.2018 added */ =
   ITM.item_sid
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ADV.client_id AS STRING), CAST(LOC.src_wh_id AS STRING), ITM.src_orig_item_nr
      , ADV.dat_adv ORDER BY ADV.repeat_fg IS NULL, ADV.repeat_fg, ADV.price_retail_net_adv IS NULL, ADV.price_retail_net_adv
      , ADV.week_adv IS NULL, ADV.week_adv)) = 1;
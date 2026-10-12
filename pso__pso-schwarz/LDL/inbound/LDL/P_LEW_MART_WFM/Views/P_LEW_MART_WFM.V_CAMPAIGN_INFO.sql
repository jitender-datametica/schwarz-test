CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_CAMPAIGN_INFO AS
   /* APT advertising items */

SELECT
  client_id
, country_lidl_cd
, wh_id
, item
, dat_adv_date
, week_adv
, gross_price
, net_price
, repeat_fg
, apt_list_type_cd
, dat_dayend
, load_id
FROM (
SELECT apt_adv.*, adp_adv.client_id AS flag FROM (
   SELECT  
     adv_apt.client_id                     AS client_id
   , cntry.src_country_lidl_cd             AS country_lidl_cd
   , loc.src_wh_id                         AS wh_id
   , CAST(adv_apt.orig_item_nr AS INTEGER) AS item
   , adv_apt.dat_adv                       AS dat_adv_date
   , 'KW '|| adv_apt.dat_adv_desc          AS week_adv
   , MAX(loc_sales_cond.cond_val_eff_calc) AS gross_price
   /* Anforderung von WFM: der Netto Wert soll aus dem Brutto-Wert berechnet werden */
   , MAX(CASE COALESCE(loc_sales_cond.tax_rate_calc, 0)
       WHEN 0 THEN loc_sales_cond.cond_val_eff_calc
       ELSE (loc_sales_cond.cond_val_eff_calc/(1+ loc_sales_cond.tax_rate_calc/100))
   END) AS net_price
   , MAX(CASE WHEN COALESCE(prom_itm_hist.product_cond_mark, '-') IN ('U', 'W') THEN 1 ELSE 0 END) AS repeat_fg
   , MIN(prom_itm_hist.prom_listing_type_mark) AS apt_list_type_cd
   , CAST(NULL AS DATE)            AS dat_dayend
   , CAST(NULL AS INTEGER)                AS load_id
FROM p_lew_core_ac.v_wawi_adv_item_advertising_s_ap AS adv_apt
   INNER JOIN p_lew_core_ac.v_location AS loc
   ON loc.client_id = adv_apt.client_id
   AND loc.loc_sid = adv_apt.wh_loc_sid
   INNER JOIN p_lew_core_ac.v_country AS cntry
   ON loc.client_id = cntry.country_sid
   INNER JOIN p_lew_core_ac.v_item AS itm
   ON itm.client_id = adv_apt.client_id
   AND TRY_CAST(COALESCE(itm.config_item_cd, itm.src_matnr) AS DECIMAL(18,0)) = adv_apt.orig_item_nr
   AND itm.log_var_cd IN (1,2,3)
   INNER JOIN p_lew_core_ac.v_item_hist AS itm_hist
   ON itm_hist.client_id = itm.client_id
   AND itm_hist.item_sid = itm.item_sid
   AND adv_apt.dat_adv BETWEEN itm_hist.dwh_valid_from AND itm_hist.dwh_valid_to
   INNER JOIN p_lew_bil_ac.v_item_loc_sales_cond_denorm AS loc_sales_cond
   ON loc_sales_cond.client_id     = adv_apt.client_id
   AND loc_sales_cond.loc_sid      = adv_apt.wh_loc_sid
   AND loc_sales_cond.item_sid     = itm_hist.item_sid
   AND loc_sales_cond.uom_sid_cond = itm_hist.uom_sid_base
   AND adv_apt.dat_adv BETWEEN loc_sales_cond.dwh_valid_from AND loc_sales_cond.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_promotion_item_hist AS prom_itm_hist
   ON prom_itm_hist.client_id = itm_hist.client_id
   AND prom_itm_hist.item_sid = itm_hist.item_sid
   AND prom_itm_hist.uom_sid_sales = itm_hist.uom_sid_base
   AND prom_itm_hist.prom_listing_type_mark IN (1,3)
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
    ) AS apt_adv
  
  LEFT JOIN (
  SELECT DISTINCT
  camp_hist.client_id
, camp_hist.campaign_start_dt
, camp_hist.campaign_end_dt
, TRY_CAST(COALESCE(item.config_item_cd, item.src_matnr) AS DECIMAL(18,0)) AS item
FROM P_LEW_CORE_AC.V_CAMPAIGN_HIST AS camp_hist

/* Werbetermine zu Artikel */
INNER JOIN P_LEW_CORE_AC.V_CAMPAIGN_ELEMENT_HIST AS camp_elem_hist
ON camp_elem_hist.client_id = camp_hist.client_id
AND camp_elem_hist.campaign_sid = camp_hist.campaign_sid

/* Artikel */ 
INNER JOIN P_LEW_CORE_AC.V_ITEM AS item
ON camp_elem_hist.client_id = item.client_id
AND camp_elem_hist.item_sid = item.item_sid


WHERE camp_hist.campaign_start_dt BETWEEN CURRENT_DATE - 20 AND CURRENT_DATE + 10
AND camp_hist.client_id = 33
AND CURRENT_DATE BETWEEN camp_hist.dwh_valid_from AND camp_hist.dwh_valid_to
AND CURRENT_DATE BETWEEN camp_elem_hist.dwh_valid_from AND camp_elem_hist.dwh_valid_to
AND camp_hist.deleted_fg = 0
  
  ) AS adp_adv
  
  ON adp_adv.client_id = apt_adv.client_id
 AND adp_adv.campaign_start_dt = apt_adv.dat_adv_date
 AND adp_adv.item = apt_adv.item
 ) AS final_us

WHERE flag IS NOT NULL

 UNION ALL

 /* WaWi advertising items */

 SELECT DISTINCT
     adv.client_id             AS client_id
   , cntry.src_country_lidl_cd AS country_lidl_cd
   , loc.src_wh_id             AS wh_id
   , TRY_CAST(COALESCE(itm.src_orig_item_nr, itm.config_item_cd) AS INTEGER) AS item
   , adv.dat_adv               AS dat_adv_date
   , adv.week_adv              AS week_adv
   , adv.price_retail_adv      AS gross_price
   , adv.price_retail_net_adv  AS net_price
   , adv.repeat_fg             AS repeat_fg
   , CAST(NULL AS VARCHAR(20))   AS apt_list_type_cd
   , adv.dat_dayend            AS dat_dayend
   , adv.load_id               AS load_id
FROM p_lew_core_ac.v_wawi_adv_item_advertising adv
   INNER JOIN p_lew_core_ac.v_location loc
   ON loc.client_id = adv.client_id
   AND loc.loc_sid   = adv.wh_loc_sid
   INNER JOIN p_lew_core_ac.v_country cntry
   ON loc.client_id = cntry.country_sid
   INNER JOIN p_lew_core_ac.v_item itm
   ON itm.client_id = adv.client_id
   AND itm.item_sid  = adv.item_sid

 /* 29.05.2018 added */
 QUALIFY ROW_NUMBER() OVER(
  PARTITION BY adv.client_id, loc.src_wh_id, itm.src_orig_item_nr, adv.dat_adv
  ORDER BY adv.repeat_fg, adv.price_retail_net_adv DESC NULLS LAST, adv.week_adv ) = 1
;
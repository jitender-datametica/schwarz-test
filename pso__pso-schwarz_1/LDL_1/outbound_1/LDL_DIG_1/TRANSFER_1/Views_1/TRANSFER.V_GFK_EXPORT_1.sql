CREATE OR REPLACE VIEW ldl_dig_transfer.v_gfk_export_1 (webshop_cd, online, jahr, monat_1, kw, gs1_brick_ebene_1,
gs1_brick_ebene_2, gs1_brick_ebene_3, lieferantenummer, lieferatenname, artikelvariante, gtin_he, artikelbezeichnung,
marke, mark_und_bez, bestellmenge, vkp_brutto, bestellumsatz) AS SELECT COL.wshop_cd AS webshop_cd,
 'online' AS online,
 TCD.cy AS jahr,
 TCD.cy_month AS monat_1,
 TCW.cy_week_short_name AS kw,
 PBC.prod_gs1_lvl1_brick_descr AS gs1_brick_ebene_1,
 PBC.prod_gs1_lvl2_brick_descr AS gs1_brick_ebene_2,
 PBC.prod_gs1_lvl3_brick_descr AS gs1_brick_ebene_3,
 TDS.supplier_nr AS lieferantenummer,
 TDS.supplier_name AS lieferatenname,
 TPV.prod_variant_nr AS artikelvariante,
 TPV.main_ean_nr AS gtin_he,
 TPV.prod_variant_name AS artikelbezeichnung,
 TDB.brand_name AS marke,
   TDB.brand_name || ' ' || TPV.prod_variant_name AS mark_und_bez,
 SUM(COL.prod_qty) AS bestellmenge,
 ROUND(SUM(COL.prod_price_gross_local_val / CER.exchange_rate) / SUM(COL.prod_qty), 2) AS vkp_brutto,
 ROUND(SUM(COL.prod_price_gross_local_val / CER.exchange_rate), 2) AS bestellumsatz
FROM ldl_dig_core.t_fact_customer_order_line_1 AS COL
 INNER JOIN ldl_dig_core.t_rel_product_variant_regional_1 AS PVR ON COL.prod_variant_sid = PVR.prod_variant_sid AND COL.wshop_cd
     = PVR.wshop_cd AND PVR.dwh_valid_fg
 INNER JOIN ldl_dig_core.t_dim_product_variant_1 AS TPV ON PVR.prod_variant_sid = TPV.prod_variant_sid AND TPV.dwh_valid_fg
  
 INNER JOIN ldl_dig_core.t_fact_currency_exchange_rate_1 AS CER ON COL.curr_cd = CER.from_curr_cd AND DATE(COL.cust_order_dt
      ) BETWEEN CER.active_from_dt AND CER.active_to_dt AND CER.curr_exchange_rate_type_cd = 'F' AND CER.to_curr_cd =
   'EUR'
 INNER JOIN ldl_dig_core.t_dim_product_brick_code_1 AS PBC ON TPV.prod_brick_cd = PBC.prod_brick_cd AND PBC.dwh_valid_fg
 INNER JOIN ldl_dig_core.t_dim_supplier_1 AS TDS ON TPV.main_supplier_sid = TDS.supplier_sid AND TDS.dwh_valid_fg
 INNER JOIN ldl_dig_core.t_dim_cal_day_1 AS TCD ON COL.cust_order_dt = TCD.cal_dt
 INNER JOIN ldl_dig_core.t_dim_cal_week_1 AS TCW ON TCD.cy_week = TCW.cy_week
 INNER JOIN ldl_dig_core.t_dim_brand_1 AS TDB ON TPV.brand_sid = TDB.brand_sid AND TDB.dwh_valid_fg
WHERE TCD.cy_week_offset = -1
 AND COL.wshop_cd IN (SELECT parameter_value_char
   FROM ldl_dig_meta.t_report_parameter_1
   WHERE report = 'GFK_Export'
    AND parameter_type = 'filter'
    AND parameter_name = 'wshop_cd')
 AND TPV.prod_food_class_cd IN (SELECT parameter_value_char
   FROM ldl_dig_meta.t_report_parameter_1
   WHERE report = 'GFK_Export'
    AND parameter_type = 'filter'
    AND parameter_name = 'prod_food_class_cd')
 AND PBC.prod_gs1_lvl1_brick_cd IN (SELECT parameter_value_char
   FROM ldl_dig_meta.t_report_parameter_1
   WHERE report = 'GFK_Export'
    AND parameter_type = 'filter'
    AND parameter_name = 'prod_gs1_lvl1_brick_cd')
 AND TPV.prod_assortment_class_cd IN (SELECT parameter_value_char
   FROM ldl_dig_meta.t_report_parameter_1
   WHERE report = 'GFK_Export'
    AND parameter_type = 'filter'
    AND parameter_name = 'prod_assortment_class_cd')
 AND COL.is_part_of_bundle_pos_cnt_fg
 AND NOT COL.is_order_cancel_fg
GROUP BY webshop_cd,
 jahr,
 monat_1,
 kw,
 gs1_brick_ebene_1,
 gs1_brick_ebene_2,
 gs1_brick_ebene_3,
 lieferantenummer,
 lieferatenname,
 artikelvariante,
 gtin_he,
 artikelbezeichnung,
 marke;
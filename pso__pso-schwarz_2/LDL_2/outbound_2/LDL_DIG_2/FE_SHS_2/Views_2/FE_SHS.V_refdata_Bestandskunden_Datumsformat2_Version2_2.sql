CREATE OR REPLACE VIEW ldl_dig_fe_shs.v_refdata_bestandskunden_datumsformat2_version2_2 AS WITH CUST_INFO AS (SELECT CUST
   .cust_sid,
   CUST.cust_salutation AS salutation,
   CUST.cust_first_name AS firstname,
   CUST.cust_last_name AS lastname,
   CUST.cust_company_name AS companyname,
   CUST.cust_birth_dt AS dateofbirth,
   CUST.phone_nr AS phone,
   CUST.email,
   'N' AS flag_nur_lieferadresse,
   ADDR.street_name AS streetname,
   ADDR.house_nr AS streetnumber,
   ADDR.addr_suffix AS addresssuffix,
   ADDR.zip_cd AS zipcode,
   ADDR.city_name AS city,
   ADDR.country_name AS country_2,
    CASE
    WHEN CUST.cust_blocked_reason_cd <> ''
    THEN '1'
    ELSE ''
    END AS blocked,
   INST.max_cust_warn_status,
   INST.actual_max_cust_warn_status,
   INST.lastschrift_fin_order_create_dt,
   ORD.customer_first_order_date,
   ORD.customer_last_order_date,
   ORD.fl_channel_web_hist,
   ORD.fl_channel_ios_hist,
   ORD.fl_channel_android_hist,
   ORD.fl_different_delivery_address_hist,
   ORD.fl_cancel_order_hist,
   ORD.fl_invoce_payment_hist,
   ORD.fl_secure_payment_hist
  FROM ldl_dig_core.t_dim_customer_2 AS CUST
   INNER JOIN (SELECT OL.cust_sid,
     MIN(OL.cust_order_dt) AS customer_first_order_date,
     MAX(OL.cust_order_dt) AS customer_last_order_date,
     MAX(CASE
       WHEN SCHNL.sales_channel_type_descr = 'Web' AND OL.prod_price_gross_local_val > 0 AND OL.cust_order_dt > DATE_SUB(CURRENT_DATE
          ,INTERVAL 365 DAY)
       THEN 1
       ELSE 0
       END) AS fl_channel_web_hist,
     MAX(CASE
       WHEN SCHNL.sales_channel_type_descr = 'iOS' AND OL.prod_price_gross_local_val > 0 AND OL.cust_order_dt > DATE_SUB(CURRENT_DATE
          ,INTERVAL 365 DAY)
       THEN 1
       ELSE 0
       END) AS fl_channel_ios_hist,
     MAX(CASE
       WHEN SCHNL.sales_channel_type_descr = 'Android' AND OL.prod_price_gross_local_val > 0 AND OL.cust_order_dt >
         DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
       THEN 1
       ELSE 0
       END) AS fl_channel_android_hist,
     MAX(CASE
       WHEN OL.billing_addr_sid <> OL.delivery_addr_sid AND OL.prod_price_gross_local_val > 0 AND OL.cust_order_dt >
         DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
       THEN 1
       ELSE 0
       END) AS fl_different_delivery_address_hist,
     MAX(CASE
       WHEN OL.is_order_cancel_fg AND OL.prod_price_gross_local_val > 0 AND OL.cust_order_dt > DATE_SUB(CURRENT_DATE,
          INTERVAL 365 DAY)
       THEN 1
       ELSE 0
       END) AS fl_cancel_order_hist,
     MAX(CASE
       WHEN CAST(CPM.cust_paym_method_cd AS INTEGER) IN (9008, 9004) AND OL.prod_price_gross_local_val > 0 AND OL.cust_order_dt
          > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
       THEN 1
       ELSE 0
       END) AS fl_invoce_payment_hist,
     MAX(CASE
       WHEN CPM.is_secure_fg AND OL.prod_price_gross_local_val > 0 AND OL.cust_order_dt > DATE_SUB(CURRENT_DATE,
          INTERVAL 365 DAY)
       THEN 1
       ELSE 0
       END) AS fl_secure_payment_hist
    FROM ldl_dig_core.t_fact_customer_order_line_2 AS OL
     LEFT JOIN ldl_dig_core.t_dim_sales_channel_type_2 AS SCHNL ON OL.sales_channel_type_cd = SCHNL.sales_channel_type_cd
     LEFT JOIN ldl_dig_core.t_dim_customer_payment_method_2 AS CPM ON OL.cust_paym_method_cd = CPM.cust_paym_method_cd
    GROUP BY OL.cust_sid) AS ORD ON CUST.cust_sid = ORD.cust_sid
   LEFT JOIN ldl_dig_core.t_dim_address_2 AS ADDR ON CUST.cust_billing_addr_sid = ADDR.addr_sid AND ADDR.dwh_valid_fg
   LEFT JOIN (SELECT cust_sid,
     MAX(CASE
       WHEN fin_order_create_dt > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
       THEN install_warn_status_cd
       ELSE NULL
       END) AS max_cust_warn_status,
     MAX(CASE
       WHEN NOT is_settl_fg AND fin_order_create_dt > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
       THEN install_warn_status_cd
       ELSE NULL
       END) AS actual_max_cust_warn_status,
     DATE(MAX(CASE
        WHEN CAST(cust_paym_method_cd AS INTEGER) IN (9008, 9017, 9016)
        THEN fin_order_create_dt
        ELSE NULL
        END)) AS lastschrift_fin_order_create_dt
    FROM ldl_dig_core.t_fact_customer_order_installment_2
    WHERE dwh_valid_fg
    GROUP BY cust_sid) AS INST ON CUST.cust_sid = INST.cust_sid
  WHERE CUST.dwh_valid_fg
   AND ADDR.country_name IN (SELECT parameter_value_char
     FROM ldl_dig_meta.t_report_parameter_2
     WHERE report = 'FE_SHS'
      AND parameter_name = 'wshop_cd')), INSTALLMENT_INFO AS (SELECT DISTINCT COI.cust_sid,
   COI.cust_order_sid,
   COI.install_type_cd,
   COI.amt_paid_local_val,
   CPM0.is_secure_fg,
   COI.is_settl_fg,
   COI.cust_order_install_nr,
   COI.cust_order_install_pos_nr,
   COI.cust_order_install_part_pos_nr
  FROM ldl_dig_core.t_fact_customer_order_installment_2 AS COI
   INNER JOIN ldl_dig_core.t_fact_customer_order_line_2 AS COL ON COI.cust_order_sid = COL.cust_order_sid
   LEFT JOIN ldl_dig_core.t_dim_customer_payment_method_2 AS CPM0 ON COI.cust_paym_method_cd = CPM0.cust_paym_method_cd
  WHERE COI.fin_order_create_dt > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
   AND COI.install_type_cd IN ('RE_2', 'RL')
   AND COI.dwh_valid_fg
   AND COI.cust_order_sid IS NOT NULL
   AND COI.cust_sid IS NOT NULL
   AND COI.cust_order_install_nr IS NOT NULL), INVOCED_PAYM_INFO AS (SELECT cust_sid,
   COUNT(DISTINCT CASE
     WHEN is_secure_fg AND is_settl_fg
     THEN cust_order_sid
     ELSE NULL
     END) AS gp_anzahl_best_sza_12m,
   COUNT(DISTINCT CASE
     WHEN NOT is_secure_fg AND is_settl_fg
     THEN cust_order_sid
     ELSE NULL
     END) AS gp_anzahl_best_nsza_12m,
   SUM(CASE
     WHEN is_secure_fg AND is_settl_fg
     THEN amt_paid_local_val
     ELSE 0
     END) AS gp_volumen_best_sza_12m,
   SUM(CASE
     WHEN NOT is_secure_fg AND is_settl_fg
     THEN amt_paid_local_val
     ELSE 0
     END) AS gp_volumen_best_nsza_12m,
   SUM(CASE
     WHEN is_secure_fg AND NOT is_settl_fg
     THEN amt_paid_local_val
     ELSE 0
     END) AS gp_op_fakturiert_sza,
   SUM(CASE
     WHEN NOT is_secure_fg AND NOT is_settl_fg
     THEN amt_paid_local_val
     ELSE 0
     END) AS gp_op_fakturiert
  FROM INSTALLMENT_INFO
  GROUP BY cust_sid), RETURN_AMOUNT_INFO AS (SELECT cust_sid,
   SUM(prod_price_gross_local_val) AS prod_price_gross_local_val
  FROM ldl_dig_core.t_fact_customer_return_line_2
  WHERE cust_order_return_dt > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
  GROUP BY cust_sid), INVOCED_ONLY_PAYM_INFO AS (SELECT cust_sid,
   SUM(amt_paid_local_val) AS amt_paid_local_val
  FROM INSTALLMENT_INFO
  WHERE is_settl_fg
   AND install_type_cd = 'RE_2'
  GROUP BY cust_sid), NOT_INVOCED_PAYM_INFO AS (SELECT t28.cust_sid,
   SUM(CASE
     WHEN t28.is_secure_fg
     THEN IFNULL(t28.prod_price_gross_local_val, 0) + IFNULL(t28.delivery_paushal_gross_local_val, 0) + IFNULL(t28.delivery_cost_gross_local_val
           , 0) + IFNULL(t28.delivery_coupon_gross_local_val, 0) + IFNULL(t28.prod_coupon_gross_local_val, 0) + IFNULL(t28
        .delivery_paushal_coupon_gross_local_val, 0) - IFNULL(t31.amt_paid_local_val, 0)
     ELSE 0
     END) AS gp_op_nichtfakturiert_sza,
   SUM(CASE
     WHEN NOT t28.is_secure_fg
     THEN IFNULL(t28.prod_price_gross_local_val, 0) + IFNULL(t28.delivery_paushal_gross_local_val, 0) + IFNULL(t28.delivery_cost_gross_local_val
           , 0) + IFNULL(t28.delivery_coupon_gross_local_val, 0) + IFNULL(t28.prod_coupon_gross_local_val, 0) + IFNULL(t28
        .delivery_paushal_coupon_gross_local_val, 0) - IFNULL(t31.amt_paid_local_val, 0)
     ELSE 0
     END) AS gp_op_nichtfakturiert
  FROM (SELECT COL1.cust_sid,
     COL1.cust_order_sid,
     CPM2.is_secure_fg,
     SUM(COL1.prod_price_gross_local_val) AS prod_price_gross_local_val,
     SUM(COL1.delivery_paushal_gross_local_val) AS delivery_paushal_gross_local_val,
     SUM(COL1.delivery_cost_gross_local_val) AS delivery_cost_gross_local_val,
     SUM(COL1.delivery_coupon_gross_local_val) AS delivery_coupon_gross_local_val,
     SUM(COL1.prod_coupon_gross_local_val) AS prod_coupon_gross_local_val,
     SUM(COL1.delivery_paushal_coupon_gross_local_val) AS delivery_paushal_coupon_gross_local_val
    FROM ldl_dig_core.t_fact_customer_order_line_2 AS COL1
     LEFT JOIN ldl_dig_core.t_dim_customer_payment_method_2 AS CPM2 ON COL1.cust_paym_method_cd = CPM2.cust_paym_method_cd
      
    WHERE COL1.cust_order_dt > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
     AND COL1.is_part_of_bundle_pos_cnt_fg
    GROUP BY COL1.cust_order_sid,
     COL1.cust_sid,
     CPM2.is_secure_fg) AS t28
   LEFT JOIN (SELECT cust_sid,
     cust_order_sid,
     SUM(amt_paid_local_val) AS amt_paid_local_val
    FROM ldl_dig_core.t_fact_customer_order_installment_2
    WHERE dwh_valid_fg
     AND install_type_cd = 'RE_2'
    GROUP BY cust_order_sid,
     cust_sid) AS t31 ON t28.cust_order_sid = t31.cust_order_sid
  GROUP BY t28.cust_sid) (SELECT C.cust_sid AS debitor_org_mandant,
   C.salutation,
   C.firstname,
   C.lastname,
   C.companyname,
   C.dateofbirth,
   C.phone,
   C.email,
   'N' AS flag_nur_lieferadresse,
   C.streetname,
   C.streetnumber,
   C.addresssuffix,
   C.zipcode,
   C.city,
   C.country_2,
   C.blocked AS sperrmerkmal,
   C.max_cust_warn_status AS mahnstufe,
   PARSE_DATE('%F', SUBSTR(CAST(C.customer_first_order_date AS STRING), 1, 20)) AS datum_erste_bestellung,
   PARSE_DATE('%F', SUBSTR(CAST(C.customer_last_order_date AS STRING), 1, 20)) AS datum_letzte_bestellung,
   IPI.gp_anzahl_best_sza_12m,
   IPI.gp_anzahl_best_nsza_12m,
   PARSE_DATE('%F', SUBSTR(CAST(C.lastschrift_fin_order_create_dt AS STRING), 1, 20)) AS belegdatumletztelastschrift,
   IPI.gp_volumen_best_sza_12m,
   IPI.gp_volumen_best_nsza_12m,
   CEIL(IF(IOPI.amt_paid_local_val = 0, 0, SAFE_DIVIDE(RAI.prod_price_gross_local_val, IOPI.amt_paid_local_val)) * 100)
   AS gp_retouren_quote_prz_12m,
   IPI.gp_op_fakturiert_sza,
   IPI.gp_op_fakturiert,
   NIPM.gp_op_nichtfakturiert_sza,
   NIPM.gp_op_nichtfakturiert,
   C.fl_cancel_order_hist AS fl_stornoauftrag_hist,
   NULL AS fl_zahlweg_raten_hist,
   C.fl_invoce_payment_hist AS fl_zahlweg_rechnung_hist,
   C.fl_secure_payment_hist AS fl_zahlweg_sichere_za_hist,
   NULL AS fl_gesundheit_warenkorb_hist,
   NULL AS fl_haushalt_warenkorb_hist,
   NULL AS fl_hobby_warenkorb_hist,
   NULL AS fl_kinderwelt_warenkorb_hist,
   NULL AS fl_mode_warenkorb_hist,
   NULL AS fl_multimedia_warenkorb_hist,
   NULL AS fl_sport_warenkorb_hist,
   NULL AS fl_weinwelt_warenkorb_hist,
   NULL AS fl_baumarkt_warenkorb_hist,
   NULL AS fl_wohnen_warenkorb_hist,
   C.fl_channel_web_hist AS fl_kanal_web_hist,
   NULL AS fl_kanal_cic_hist,
   C.fl_channel_ios_hist AS fl_kanal_iphone_hist,
   C.fl_channel_android_hist AS fl_kanal_android_hist,
   C.fl_different_delivery_address_hist AS fl_abweichende_lieferadresse_hist,
   C.actual_max_cust_warn_status AS aktuell_hoechste_mahnstufe,
    CASE
    WHEN C.customer_last_order_date > DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
    THEN 'selber_monat'
    WHEN C.customer_last_order_date > DATE_SUB(CURRENT_DATE, INTERVAL 60 DAY)
    THEN 'letzter_monat'
    WHEN C.customer_last_order_date > DATE_SUB(CURRENT_DATE, INTERVAL 120 DAY)
    THEN 'zwei_bis_drei_monate'
    WHEN C.customer_last_order_date > DATE_SUB(CURRENT_DATE, INTERVAL 99999 DAY)
    THEN 'mehr_als_drei_monate'
    ELSE 'kein_kauf'
    END AS kl_letztkauf
  FROM CUST_INFO AS C
   LEFT JOIN INVOCED_PAYM_INFO AS IPI ON C.cust_sid = IPI.cust_sid
   LEFT JOIN RETURN_AMOUNT_INFO AS RAI ON C.cust_sid = RAI.cust_sid
   LEFT JOIN INVOCED_ONLY_PAYM_INFO AS IOPI ON C.cust_sid = IOPI.cust_sid
   LEFT JOIN NOT_INVOCED_PAYM_INFO AS NIPM ON C.cust_sid = NIPM.cust_sid
  WHERE C.actual_max_cust_warn_status > 0
   OR C.customer_last_order_date > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY));
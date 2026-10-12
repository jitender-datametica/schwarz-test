

-- VII. FACTS - Webshop stock information
 -- 
 -- V.2 - Generate Latest VKP values on product level

-- I. DIM - Article Master Data (regional)
 -- 
 -- "AVG Menge je Bestellung"
 -- 
 -- NL
 -- VII.1 - First ETL step

-- 
 -- 
 -- IV.3 - Generate returns data per prod_sid
 -- 
 -- Special case due to CZ logic
 -- 

-- II. FACTS - Sales_2 promotion target (Aktionsplanmengen)
 -- 
 -- 
 -- 
 -- III. FACTS - Sales_2 orders

-- VII.2 - Get stock data per product / wshop

-- 3. Calculate prod_qty and quotes of sold products for specified time ranges

-- 11. CROSS JOIN all data IN a Final view
 -- 
 -- Step 3 -> calculate the prod_qty per time range on product level

-- Basic for special case PL logic
 -- 
 -- 2. Generate Sales_2 Orders data per prod_sid
 -- 
 -- Others
 -- 

-- IV.2 - Second ETL step
 -- 
 -- 
 -- 
 -- VI.2 - Generate EKP values needed for final view on product level

-- Step 2 - Calculate the prod_qty per time range on variant level
 -- 
 -- 
 -- 
 -- 

-- V.1 - First ETL step: CROSS JOIN with dim_product_variant
 -- Date filter: only grab facts from the last 6 months

-- VIEW 1 -- KENNZAHLENDATEI
 -- END WITH
 -- START WITH (definition of support CTEs)
 -- 

-- Step 1 - CROSS JOIN calendar_2 dates (calculated) with promotion dates (aktionsplanmengen)

-- Generate "fake" data for AT, DK, HU, FR (based on DE data)
 -- 

-- Workaround, as there is currently no DIM table on Core for wshop_cd <-> curr_cd
 -- III.1 - First ETL step

-- Take latest date, and take the min(vkp) IN case a product has 2 prices on that date

-- "Durchschnittlicher VK_2 IN Eur (brutto)"

-- Due to data quality issues, replace numbers with non-numerical characters
 -- 

-- Workaround, as there is currently no DIM table on Core for wshop_cd <-> curr_cd
 -- 

-- PARAMETERS - Country_2 currencies
 -- Replacement filter for Qlik "VBAK.Belegdatum_AUDAT_Relevant" filter
 -- 

-- "AVG Warenkorbwert"
 -- "∅ Warenkorbwert"
 -- 

-- II.1 - First ETL step: filtering, formatting, aliasing, key definition
 -- VI.1 - First ETL step

-- Step 4 -> Calculate also the quotes per time range (qty/anfangsbestand)

-- II.2 - Second ETL step: legacy data reduction logic: keep only one record per wshop and prod_sid

-- IV. FACTS - Return Orders
 -- 
 -- Basis for further date calculations (all countries have a different logic)

-- IV.1 - First ETl step
 -- III.2 - Add prod_sid info to Kundenauftrag + EUR values

-- PART 2 >>> CREATION OF THE FINAL VIEWS
 -- 1. Support table for Dates
 -- V. FACTS - Latest Sales_2 Price
 -- 

-- 11. FINAL QUERY (+ add Austria/Denmark/Hungary data)
 -- "∅ Menge je Bestellung"
 -- Others

-- Date calculations (for breadkdown of sales_2 numbers, IN the next step)
 -- VI. FACTS - Purchasing prices
 -- 

-- "Durchschnittlicher VK_2 IN Landeswährung (brutto)"

CREATE OR REPLACE VIEW ldl_dig_transfer.v_amp_export_kennzahlendatei_2 AS WITH TMP_ETL_KUNDENAUFTRAG_1 AS (SELECT wshop_cd
   ,
   cust_order_sid,
   cust_order_dt,
   cust_order_nr,
   prod_variant_sid,
   cust_order_pos_nr,
   prod_qty -- Sales_2 orders quantities (KWMENG)
,
   curr_cd,
   prod_price_gross_local_val -- Brutto_Artikelverkaufswert_KZWI1_LANDESWÄHRUNG
,
   delivery_cost_gross_local_val -- Brutto_Art.spez.Versandkosten_KZWI3_LANDESWÄHRUNG
,
   delivery_paushal_gross_local_val -- Brutto_Versandkostenpauschale_KZWI2_LANDESWÄHRUNG
,
   tax_class_cd,
   cust_order_type_cd,
   is_part_of_bundle_header_cnt_fg
  FROM ldl_dig_core.t_fact_customer_order_line_2
  WHERE cust_order_dt >= IF(DATE_TRUNC(CURRENT_DATE, MONTH) = LAST_DAY(DATE_TRUNC(CURRENT_DATE, MONTH)), LAST_DAY(DATE_ADD(DATE_TRUNC(CURRENT_DATE
        , MONTH), INTERVAL - 6 MONTH)), DATE_ADD(DATE_TRUNC(CURRENT_DATE, MONTH), INTERVAL - 6 MONTH))
   AND (wshop_cd = 'DE' AND is_part_of_bundle_header_cnt_fg OR wshop_cd <> 'DE' AND is_part_of_bundle_pos_cnt_fg)),
 KUNDENAUFTRAG AS (SELECT T2.prod_sid,
   T2.prod_nr,
   t1.wshop_cd,
   t1.cust_order_sid,
   t1.cust_order_dt,
   t1.cust_order_nr,
   t1.prod_variant_sid,
   t1.cust_order_pos_nr,
   ROUND(CAST(t1.prod_qty AS NUMERIC), 2) AS prod_qty,
   t1.curr_cd,
   CAST(t1.prod_price_gross_local_val AS BIGNUMERIC) AS prod_price_gross_local_val,
   CAST(t1.delivery_cost_gross_local_val AS BIGNUMERIC) AS delivery_cost_gross_local_val,
   CAST(t1.delivery_paushal_gross_local_val AS BIGNUMERIC) AS delivery_paushal_gross_local_val,
   t1.tax_class_cd,
   t1.cust_order_type_cd,
   t1.is_part_of_bundle_header_cnt_fg,
   CAST(t1.prod_price_gross_local_val / T3.exchange_rate AS BIGNUMERIC) AS prod_price_gross_eur
  FROM TMP_ETL_KUNDENAUFTRAG_1 AS t1_2
   LEFT JOIN ldl_dig_core.t_dim_product_variant_2 AS T2 ON t1.prod_variant_sid = T2.prod_variant_sid AND T2.dwh_valid_fg
   LEFT JOIN ldl_dig_core.t_fact_currency_exchange_rate_2 AS T3 ON t1.curr_cd = T3.from_curr_cd AND T3.curr_exchange_rate_type_cd
       = 'F' AND t1.cust_order_dt BETWEEN T3.active_from_dt AND T3.active_to_dt), TMP_ETL_AKTIONSPLANMENGEN AS (SELECT
   CONCAT(T1.wshop_cd, T1.prod_sid, T1.promo_dt) AS pk,
   CONCAT(T1.wshop_cd, T1.prod_sid) AS artikel_os,
   T1.wshop_cd AS os,
   T1.prod_sid,
   T20.prod_nr AS kopfartnr,
   IF(ROUND(SAFE_CAST(T20.ian_nr AS BIGNUMERIC), 0) IS NULL, T20.prod_nr, T20.ian_nr) AS lidlnummer,
   T1.promo_dt AS verkaufsstart,
   T1.sale_promo_type_cd AS werbeimpuls,
   T1.promo_price_gross_local_val AS akp_brutto_local_val,
   T1.curr_cd,
   T1.tgt_prod_sale_qty AS anfangsbestand,
   T1.promo_dur_week_cnt AS abverkaufshorizont
  FROM ldl_dig_core.t_fact_sales_promotion_target_2 AS T1_2
   INNER JOIN ldl_dig_core.t_dim_product_2 AS T20 ON T1.prod_sid = T20.prod_sid AND T20.dwh_valid_fg
  WHERE T1.promo_dt >= IF(DATE_TRUNC(CURRENT_DATE, MONTH) = LAST_DAY(DATE_TRUNC(CURRENT_DATE, MONTH)), LAST_DAY(DATE_ADD(DATE_TRUNC(CURRENT_DATE
        , MONTH), INTERVAL - 6 MONTH)), DATE_ADD(DATE_TRUNC(CURRENT_DATE, MONTH), INTERVAL - 6 MONTH))),
 AKTIONSPLANMENGEN AS (SELECT *
  FROM TMP_ETL_AKTIONSPLANMENGEN
  WHERE pk IN (SELECT FIRST_VALUE(CONCAT(T10.wshop_cd, T10.prod_sid, T10.promo_dt)) OVER (PARTITION BY CONCAT(T10.wshop_cd
          , T10.prod_sid) ORDER BY T10.tgt_prod_sale_qty IS NULL DESC, T10.tgt_prod_sale_qty DESC, T10.promo_dt IS NULL
         DESC, T10.promo_dt DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS a1928350188
     FROM ldl_dig_core.t_fact_sales_promotion_target_2 AS T10
      INNER JOIN ldl_dig_core.t_dim_product_2 AS T21 ON T10.prod_sid = T21.prod_sid AND T21.dwh_valid_fg
     WHERE T10.promo_dt >= IF(DATE_TRUNC(CURRENT_DATE, MONTH) = LAST_DAY(DATE_TRUNC(CURRENT_DATE, MONTH)), LAST_DAY(DATE_ADD(DATE_TRUNC(CURRENT_DATE
           , MONTH), INTERVAL - 6 MONTH)), DATE_ADD(DATE_TRUNC(CURRENT_DATE, MONTH), INTERVAL - 6 MONTH)))), T_PAR_DATES
 AS (SELECT t11.wshop_cd,
   t12.start_date,
   t12.t1_vorb_date_par,
   t12.t3_vorb_date_par,
   t12.t7_vorb_date_par,
   t12.t1p_vorb_date_par,
   t12.t3p_vorb_date_par,
   t12.t7p_vorb_date_par,
   t12.w2p_vorb_date_par,
   t12.w3p_vorb_date_par,
   t12.w4p_vorb_date_par,
   t12.w5p_vorb_date_par,
   t12.w6p_vorb_date_par,
   t12.w7p_vorb_date_par,
   t12.w8p_vorb_date_par,
   t12.w9p_vorb_date_par,
   t12.w10p_vorb_date_par,
   t12.w11p_vorb_date_par,
   t12.w12p_vorb_date_par,
   t12.w18p_vorb_date_par,
   t12.w20p_vorb_date_par,
   t12.w26p_vorb_date_par,
   t12.w52p_vorb_date_par
  FROM (SELECT 'DE' AS wshop_cd,
      1 AS case_id
     UNION ALL
     SELECT 'NL' AS wshop_cd,
      3 AS case_id
     UNION ALL
     SELECT 'BE' AS wshop_cd,
      2 AS case_id
     UNION ALL
     SELECT 'CZ' AS wshop_cd,
      1 AS case_id
     UNION ALL
     SELECT 'PL' AS wshop_cd,
      2 AS case_id
     UNION ALL
     SELECT 'SK' AS wshop_cd,
      2 AS case_id) AS t11
   INNER JOIN (SELECT 1 AS case_id,
      'DE-CZ' AS case_comment,
      '-8' AS start_date,
      '-7' AS t1_vorb_date_par,
      '-5' AS t3_vorb_date_par,
      '-1' AS t7_vorb_date_par,
      '1' AS t1p_vorb_date_par,
      '3' AS t3p_vorb_date_par,
      '7' AS t7p_vorb_date_par,
      '14' AS w2p_vorb_date_par,
      '21' AS w3p_vorb_date_par,
      '28' AS w4p_vorb_date_par,
      '35' AS w5p_vorb_date_par,
      '42' AS w6p_vorb_date_par,
      '49' AS w7p_vorb_date_par,
      '56' AS w8p_vorb_date_par,
      '63' AS w9p_vorb_date_par,
      '70' AS w10p_vorb_date_par,
      '77' AS w11p_vorb_date_par,
      '84' AS w12p_vorb_date_par,
      '126' AS w18p_vorb_date_par,
      '140' AS w20p_vorb_date_par,
      '182' AS w26p_vorb_date_par,
      '364' AS w52p_vorb_date_par
     UNION ALL
     SELECT 2 AS case_id,
      'BE-PL-SK' AS case_comment,
      '-7' AS start_date,
      '-6' AS t1_vorb_date_par,
      '-4' AS t3_vorb_date_par,
      '0' AS t7_vorb_date_par,
      '1' AS t1p_vorb_date_par,
      '3' AS t3p_vorb_date_par,
      '7' AS t7p_vorb_date_par,
      '14' AS w2p_vorb_date_par,
      '21' AS w3p_vorb_date_par,
      '28' AS w4p_vorb_date_par,
      '35' AS w5p_vorb_date_par,
      '42' AS w6p_vorb_date_par,
      '49' AS w7p_vorb_date_par,
      '56' AS w8p_vorb_date_par,
      '63' AS w9p_vorb_date_par,
      '70' AS w10p_vorb_date_par,
      '77' AS w11p_vorb_date_par,
      '84' AS w12p_vorb_date_par,
      '126' AS w18p_vorb_date_par,
      '140' AS w20p_vorb_date_par,
      '182' AS w26p_vorb_date_par,
      '364' AS w52p_vorb_date_par
     UNION ALL
     SELECT 3 AS case_id,
      'NL' AS case_comment,
      '-4' AS start_date,
      '-3' AS t1_vorb_date_par,
      '-1' AS t3_vorb_date_par,
      '3' AS t7_vorb_date_par,
      '4' AS t1p_vorb_date_par,
      '6' AS t3p_vorb_date_par,
      '10' AS t7p_vorb_date_par,
      '17' AS w2p_vorb_date_par,
      '24' AS w3p_vorb_date_par,
      '31' AS w4p_vorb_date_par,
      '38' AS w5p_vorb_date_par,
      '45' AS w6p_vorb_date_par,
      '52' AS w7p_vorb_date_par,
      '59' AS w8p_vorb_date_par,
      '66' AS w9p_vorb_date_par,
      '73' AS w10p_vorb_date_par,
      '80' AS w11p_vorb_date_par,
      '87' AS w12p_vorb_date_par,
      '129' AS w18p_vorb_date_par,
      '143' AS w20p_vorb_date_par,
      '185' AS w26p_vorb_date_par,
      '367' AS w52p_vorb_date_par) AS t12 ON t11.case_id = t12.case_id), TMP_ETL_AKTIONDATES AS (SELECT t1.os,
   t1.prod_sid,
   t1.kopfartnr,
   IFNULL(t1.lidlnummer, t1.kopfartnr) AS ian,
   t1.werbeimpuls,
   t1.verkaufsstart,
   t1.anfangsbestand,
   t1.abverkaufshorizont,
   t1.akp_brutto_local_val,
   t1.curr_cd,
   DATE(CURRENT_TIMESTAMP()) AS today,
    CASE
    WHEN t1.os IN ('NL')
    THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
    ELSE CASE
     WHEN t1.os IN ('BE')
     THEN t1.verkaufsstart -- BE

     ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
     END
    END AS calc_date,
    CASE
    WHEN t1.os IN ('PL', 'SK')
    THEN t1.verkaufsstart -- PL / SK

    ELSE CASE
     WHEN t1.os IN ('NL')
     THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
     ELSE CASE
      WHEN t1.os IN ('BE')
      THEN t1.verkaufsstart
      ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
      END
     END
    END AS calc_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.start_date AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS start_date,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t1_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS t1_vorb_date,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t3_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS t3_vorb_date,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t7_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS t7_vorb_date,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t1p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS t1p_vorb_date
   ,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t3p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS t3p_vorb_date
   ,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t7p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS t7p_vorb_date
   ,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w2p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS w2p_vorb_date
   ,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w3p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS w3p_vorb_date
   ,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w4p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS w4p_vorb_date
   ,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w5p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS w5p_vorb_date
   ,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w6p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS w6p_vorb_date
   ,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w7p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS w7p_vorb_date
   ,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w8p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS w8p_vorb_date
   ,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w9p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS w9p_vorb_date
   ,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w10p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w10p_vorb_date,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w11p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w11p_vorb_date,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w12p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w12p_vorb_date,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w18p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w18p_vorb_date,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w20p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w20p_vorb_date,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w26p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w26p_vorb_date,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('NL')
      THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
      ELSE CASE
       WHEN t1.os IN ('BE')
       THEN t1.verkaufsstart
       ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w52p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w52p_vorb_date,
    CASE
    WHEN t2.wshop_cd = 'CZ'
    THEN DATE_ADD(DATE(DATE_ADD(CASE
        WHEN t1.os IN ('NL')
        THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
        ELSE CASE
         WHEN t1.os IN ('BE')
         THEN t1.verkaufsstart
         ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
         END
        END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t1_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)), INTERVAL 1 DAY
     )
    ELSE DATE(DATE_ADD(CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t1_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY))
    END AS t1_vorb_date_check,
    CASE
    WHEN t2.wshop_cd = 'CZ'
    THEN DATE_ADD(DATE(DATE(DATE_ADD(CASE
         WHEN t1.os IN ('NL')
         THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
         ELSE CASE
          WHEN t1.os IN ('BE')
          THEN t1.verkaufsstart
          ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
          END
         END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t3_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY))), INTERVAL 1
     DAY)
    ELSE DATE(DATE(DATE_ADD(CASE
        WHEN t1.os IN ('NL')
        THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
        ELSE CASE
         WHEN t1.os IN ('BE')
         THEN t1.verkaufsstart
         ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
         END
        END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t3_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)))
    END AS t3_vorb_date_check,
    CASE
    WHEN t2.wshop_cd = 'CZ'
    THEN DATE_ADD(DATE(DATE(DATE_ADD(CASE
         WHEN t1.os IN ('NL')
         THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
         ELSE CASE
          WHEN t1.os IN ('BE')
          THEN t1.verkaufsstart
          ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
          END
         END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t7_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY))), INTERVAL 1
     DAY)
    ELSE DATE(DATE(DATE_ADD(CASE
        WHEN t1.os IN ('NL')
        THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
        ELSE CASE
         WHEN t1.os IN ('BE')
         THEN t1.verkaufsstart
         ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
         END
        END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t7_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)))
    END AS t7_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t1p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   t1p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t3p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   t3p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.t7p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   t7p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w2p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w2p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w3p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w3p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w4p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w4p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w5p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w5p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w6p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w6p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w7p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w7p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w8p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w8p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w9p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w9p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w10p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w10p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w11p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w11p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w12p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w12p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w18p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w18p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w20p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w20p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w26p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w26p_vorb_date_check,
   DATE(DATE_ADD(CASE
      WHEN t1.os IN ('PL', 'SK')
      THEN t1.verkaufsstart
      ELSE CASE
       WHEN t1.os IN ('NL')
       THEN DATE_TRUNC(DATE_SUB(t1.verkaufsstart, INTERVAL 3 DAY), ISOWEEK)
       ELSE CASE
        WHEN t1.os IN ('BE')
        THEN t1.verkaufsstart
        ELSE DATE_TRUNC(t1.verkaufsstart, ISOWEEK)
        END
       END
      END, INTERVAL CAST(ROUND(ROUND(CAST(t2.w52p_vorb_date_par AS BIGNUMERIC), 0)) AS INTEGER) DAY)) AS
   w52p_vorb_date_check
  FROM AKTIONSPLANMENGEN AS t1_2
   INNER JOIN T_PAR_DATES AS t2 ON t1.os = t2.wshop_cd), TMP_ETL_PROD_QTY AS (SELECT t1.prod_sid,
   t1.prod_nr,
   t1.prod_variant_sid,
   t1.wshop_cd,
   t1.cust_order_dt,
   t2.os,
   t2.kopfartnr,
   t2.ian,
   t2.werbeimpuls,
   t2.verkaufsstart,
   t2.anfangsbestand,
   t2.abverkaufshorizont,
   t2.akp_brutto_local_val,
   t2.curr_cd,
    CASE
    WHEN t2.today < t2.t1_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t1_vorb_date_check
       -- t1_vorb_date_check = necessary adjustment due to CZ logic

     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_1t_vorb,
    CASE
    WHEN t2.today < t2.t3_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t3_vorb_date_check
       -- t3_vorb_date_check = necessary adjustment due to CZ logic

     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_3t_vorb,
    CASE
    WHEN t2.today < t2.t7_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t7_vorb_date_check
       -- t7_vorb_date_check = necessary adjustment due to CZ logic

     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_7t_vorb,
    CASE
    WHEN t2.today < t2.t1p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t1p_vorb_date_check
       -- t7_vorb_date_check = necessary adjustment due to PL logic

     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_1tp_vorb,
    CASE
    WHEN t2.today < t2.t3p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t3p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_3tp_vorb,
    CASE
    WHEN t2.today < t2.t7p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t7p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_7tp_vorb,
    CASE
    WHEN t2.today < t2.w2p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w2p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_2wp_vorb,
    CASE
    WHEN t2.today < t2.w3p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w3p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_3wp_vorb,
    CASE
    WHEN t2.today < t2.w4p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w4p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_4wp_vorb,
    CASE
    WHEN t2.today < t2.w5p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w5p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_5wp_vorb,
    CASE
    WHEN t2.today < t2.w6p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w6p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_6wp_vorb,
    CASE
    WHEN t2.today < t2.w7p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w7p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_7wp_vorb,
    CASE
    WHEN t2.today < t2.w8p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w8p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_8wp_vorb,
    CASE
    WHEN t2.today < t2.w9p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w9p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_9wp_vorb,
    CASE
    WHEN t2.today < t2.w10p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w10p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_10wp_vorb,
    CASE
    WHEN t2.today < t2.w11p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w11p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_11wp_vorb,
    CASE
    WHEN t2.today < t2.w12p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w12p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_12wp_vorb,
    CASE
    WHEN t2.today < t2.w18p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w18p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_18wp_vorb,
    CASE
    WHEN t2.today < t2.w20p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w20p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_20wp_vorb,
    CASE
    WHEN t2.today < t2.w26p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w26p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_26wp_vorb,
    CASE
    WHEN t2.today < t2.w52p_vorb_date
    THEN 0
    ELSE CASE
     WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w52p_vorb_date_check
     THEN t1.prod_qty
     ELSE 0
     END
    END AS qty_52wp_vorb
  FROM KUNDENAUFTRAG AS t1_2
   INNER JOIN TMP_ETL_AKTIONDATES AS t2 ON t1.wshop_cd = t2.os AND t1.prod_sid = t2.prod_sid), TMP_ETL_PROD_QTY_V2 AS (SELECT
   prod_sid,
   prod_nr,
   wshop_cd,
   verkaufsstart,
   anfangsbestand,
   os,
   kopfartnr,
   ian,
   werbeimpuls,
   abverkaufshorizont,
   akp_brutto_local_val,
   curr_cd,
   SUM(qty_1t_vorb) AS t1_vorb_stuck,
   SUM(qty_3t_vorb) AS t3_vorb_stuck,
   SUM(qty_7t_vorb) AS t7_vorb_stuck,
   SUM(qty_1tp_vorb) AS t1p_vorb_stuck,
   SUM(qty_3tp_vorb) AS t3p_vorb_stuck,
   SUM(qty_7tp_vorb) AS t7p_vorb_stuck,
   SUM(qty_2wp_vorb) AS w2p_vorb_stuck,
   SUM(qty_3wp_vorb) AS w3p_vorb_stuck,
   SUM(qty_4wp_vorb) AS w4p_vorb_stuck,
   SUM(qty_5wp_vorb) AS w5p_vorb_stuck,
   SUM(qty_6wp_vorb) AS w6p_vorb_stuck,
   SUM(qty_7wp_vorb) AS w7p_vorb_stuck,
   SUM(qty_8wp_vorb) AS w8p_vorb_stuck,
   SUM(qty_9wp_vorb) AS w9p_vorb_stuck,
   SUM(qty_10wp_vorb) AS w10p_vorb_stuck,
   SUM(qty_11wp_vorb) AS w11p_vorb_stuck,
   SUM(qty_12wp_vorb) AS w12p_vorb_stuck,
   SUM(qty_18wp_vorb) AS w18p_vorb_stuck,
   SUM(qty_20wp_vorb) AS w20p_vorb_stuck,
   SUM(qty_26wp_vorb) AS w26p_vorb_stuck,
   SUM(qty_52wp_vorb) AS w52p_vorb_stuck
  FROM TMP_ETL_PROD_QTY
  GROUP BY prod_sid,
   prod_nr,
   wshop_cd,
   os,
   kopfartnr,
   ian,
   werbeimpuls,
   verkaufsstart,
   anfangsbestand,
   abverkaufshorizont,
   akp_brutto_local_val,
   curr_cd), PROD_QTY_FINAL AS (SELECT prod_sid,
   prod_nr,
   wshop_cd,
   verkaufsstart,
   anfangsbestand,
   os,
   kopfartnr,
   ian,
   werbeimpuls,
   abverkaufshorizont,
   ROUND(CAST(akp_brutto_local_val AS BIGNUMERIC), 2) AS akp_brutto_local_val,
   curr_cd,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(t1_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS t1_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(t3_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS t3_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(t7_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS t7_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(t1p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS t1p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(t3p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS t3p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(t7p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS t7p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w2p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w2p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w3p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w3p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w4p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w4p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w5p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w5p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w6p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w6p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w7p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w7p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w8p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w8p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w9p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w9p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w10p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w10p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w11p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w11p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w12p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w12p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w18p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w18p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w20p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w20p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w26p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w26p_vorb,
   CAST(LEAST(IFNULL(IF(anfangsbestand = 0, 0, SAFE_DIVIDE(w52p_vorb_stuck, anfangsbestand)), ROUND(CAST(0.00 AS BIGNUMERIC)
       , 0)), 999.99) AS NUMERIC) AS w52p_vorb,
   CAST(t1_vorb_stuck AS NUMERIC) AS t1_vorb_stuck,
   CAST(t3_vorb_stuck AS NUMERIC) AS t3_vorb_stuck,
   CAST(t7_vorb_stuck AS NUMERIC) AS t7_vorb_stuck,
   CAST(t1p_vorb_stuck AS NUMERIC) AS t1p_vorb_stuck,
   CAST(t3p_vorb_stuck AS NUMERIC) AS t3p_vorb_stuck,
   CAST(t7p_vorb_stuck AS NUMERIC) AS t7p_vorb_stuck,
   CAST(w2p_vorb_stuck AS NUMERIC) AS w2p_vorb_stuck,
   CAST(w3p_vorb_stuck AS NUMERIC) AS w3p_vorb_stuck,
   CAST(w4p_vorb_stuck AS NUMERIC) AS w4p_vorb_stuck,
   CAST(w5p_vorb_stuck AS NUMERIC) AS w5p_vorb_stuck,
   CAST(w6p_vorb_stuck AS NUMERIC) AS w6p_vorb_stuck,
   CAST(w7p_vorb_stuck AS NUMERIC) AS w7p_vorb_stuck,
   CAST(w8p_vorb_stuck AS NUMERIC) AS w8p_vorb_stuck,
   CAST(w9p_vorb_stuck AS NUMERIC) AS w9p_vorb_stuck,
   CAST(w10p_vorb_stuck AS NUMERIC) AS w10p_vorb_stuck,
   CAST(w11p_vorb_stuck AS NUMERIC) AS w11p_vorb_stuck,
   CAST(w12p_vorb_stuck AS NUMERIC) AS w12p_vorb_stuck,
   CAST(w18p_vorb_stuck AS NUMERIC) AS w18p_vorb_stuck,
   CAST(w20p_vorb_stuck AS NUMERIC) AS w20p_vorb_stuck,
   CAST(w26p_vorb_stuck AS NUMERIC) AS w26p_vorb_stuck,
   CAST(w52p_vorb_stuck AS NUMERIC) AS w52p_vorb_stuck
  FROM TMP_ETL_PROD_QTY_V2), TOTAL_PROD_SALES AS (SELECT prod_sid,
   prod_nr,
   wshop_cd,
   curr_cd,
   SUM(prod_qty) AS total_prod_qty,
   SUM(prod_price_gross_local_val) AS total_prod_price_gross_local_val,
   SUM(prod_price_gross_eur) AS total_prod_price_gross_eur,
   CAST(IF(SUM(prod_qty) = 0, 0, SAFE_DIVIDE(SUM(prod_price_gross_local_val), SUM(prod_qty))) AS BIGNUMERIC) AS
   avg_vkp_local_val,
   CAST(IF(SUM(prod_qty) = 0, 0, SAFE_DIVIDE(SUM(prod_price_gross_eur), SUM(prod_qty))) AS BIGNUMERIC) AS avg_vkp_eur,
   COUNT(DISTINCT cust_order_sid) AS count_cust_order,
   MAX(cust_order_dt) AS max_cust_order_dt,
   MIN(cust_order_dt) AS min_cust_order_dt,
   ROUND(CAST(SUM(prod_qty) / COUNT(DISTINCT cust_order_sid) AS BIGNUMERIC), 2) AS avg_menge_je_bestellung,
   CAST(SUM(prod_price_gross_eur) / COUNT(DISTINCT cust_order_sid) AS BIGNUMERIC) AS avg_warenkorbwert
  FROM KUNDENAUFTRAG
  GROUP BY prod_sid,
   prod_nr,
   wshop_cd,
   curr_cd), TMP_ETL_RETOUREN_1 AS (SELECT T11.wshop_cd,
   T11.cust_order_sid,
   T11.cust_order_nr,
   T11.cust_order_dt,
   T11.cust_order_return_sid,
   T11.cust_order_return_nr,
   T11.prod_variant_sid,
   T11.prod_qty AS return_prod_qty
  FROM ldl_dig_core.t_fact_customer_return_line_2 AS T11
   INNER JOIN KUNDENAUFTRAG AS t2 ON T11.cust_order_sid = t2.cust_order_sid AND T11.cust_order_pos_nr = t2.cust_order_pos_nr
     ), TMP_ETL_RETOUREN_2 AS (SELECT T24.prod_sid,
   T24.prod_nr,
   t1.wshop_cd,
   t1.cust_order_sid,
   t1.cust_order_nr,
   t1.cust_order_dt,
   t1.cust_order_return_sid,
   t1.cust_order_return_nr,
   t1.prod_variant_sid,
   t1.return_prod_qty
  FROM TMP_ETL_RETOUREN_1 AS t1_2
   LEFT JOIN ldl_dig_core.t_dim_product_variant_2 AS T24 ON t1.prod_variant_sid = T24.prod_variant_sid AND T24.dwh_valid_fg
    ), RETOUREN AS (SELECT prod_sid,
   prod_nr,
   wshop_cd,
   SUM(return_prod_qty) AS total_returns
  FROM TMP_ETL_RETOUREN_2
  GROUP BY prod_sid,
   prod_nr,
   wshop_cd), TMP_ETL_AKTUELLER_VKP AS (SELECT T12.wshop_cd,
   T25.prod_sid,
   T25.prod_nr,
   T12.prod_variant_sid,
   T12.curr_cd,
   T12.cal_dt,
   T12.vkp_price_gross_local_val,
   T12.vkp_price_gross_eur_val
  FROM ldl_dig_core.t_fact_product_price_sale_ivp_gld_vkp_2 AS T12
   INNER JOIN ldl_dig_core.t_dim_product_variant_2 AS T25 ON T12.prod_variant_sid = T25.prod_variant_sid AND T12.dwh_valid_fg
      AND T25.dwh_valid_fg), AKTUELLER_VKP AS (SELECT wshop_cd,
   prod_sid,
   prod_nr,
   cal_dt,
   ROUND(CAST(AVG(vkp_price_gross_local_val) AS BIGNUMERIC), 2) AS vkp_price_gross_local_val,
   ROUND(CAST(AVG(vkp_price_gross_eur_val) AS BIGNUMERIC), 2) AS vkp_price_gross_eur_val
  FROM TMP_ETL_AKTUELLER_VKP AS t1_2
  WHERE (wshop_cd, prod_sid, prod_nr, cal_dt) IN (SELECT (T13.wshop_cd, T26.prod_sid, T26.prod_nr, MAX(T13.cal_dt))
     FROM ldl_dig_core.t_fact_product_price_sale_ivp_gld_vkp_2 AS T13
      INNER JOIN ldl_dig_core.t_dim_product_variant_2 AS T26 ON T13.prod_variant_sid = T26.prod_variant_sid AND T13.dwh_valid_fg
         AND T26.dwh_valid_fg
     GROUP BY T13.wshop_cd,
      T26.prod_sid,
      T26.prod_nr)
  GROUP BY wshop_cd,
   prod_sid,
   prod_nr,
   cal_dt), TMP_ETL_EINKAUFSPREIS AS (SELECT wshop_cd,
   supplier_sid,
   prod_variant_sid,
   curr_cd,
   price_val
  FROM ldl_dig_core.t_fact_product_price_supplier_2 AS T1_2
  WHERE price_type_cd = 'EKP'
   AND active_from_tmsp <= CURRENT_TIMESTAMP()
   AND active_to_tmsp >= CURRENT_TIMESTAMP()), EINKAUFSPREIS AS (SELECT T27.prod_sid,
   T27.prod_nr,
   t1.wshop_cd,
   ROUND(CAST(MAX(t1.price_val) AS BIGNUMERIC), 2) AS max_ekp
  FROM TMP_ETL_EINKAUFSPREIS AS t1_2
   INNER JOIN ldl_dig_core.t_dim_product_variant_2 AS T27 ON t1.prod_variant_sid = T27.prod_variant_sid AND t1.supplier_sid
       = T27.main_supplier_sid AND T27.dwh_valid_fg
  GROUP BY t1.wshop_cd,
   T27.prod_sid,
   T27.prod_nr), TMP_ETL_STOCK_DAILY_1 AS (SELECT T15.wshop_cd,
   T15.prod_variant_sid,
   T15.cal_dt,
   T15.avail_to_promise_cnt,
   T15.global_stock_cnt,
   T15.covered_remain_cnt,
   t2.blocked_stock
  FROM ldl_dig_core.t_fact_stock_webshop_daily_2 AS T15
   LEFT JOIN (SELECT prod_variant_sid,
     SUM(blocked_stock_cnt) AS blocked_stock
    FROM ldl_dig_core.t_fact_stock_warehouse_storage_location_daily_2
    WHERE active_fg
    GROUP BY prod_variant_sid) AS t2 ON T15.prod_variant_sid = t2.prod_variant_sid
  WHERE (T15.wshop_cd, T15.prod_variant_sid, T15.cal_dt) IN (SELECT (wshop_cd, prod_variant_sid, MAX(cal_dt))
     FROM ldl_dig_core.t_fact_stock_webshop_daily_2 AS T2
     GROUP BY wshop_cd,
      prod_variant_sid)), STOCK_DAILY AS (SELECT t1.wshop_cd,
   T29.prod_sid,
   T29.prod_nr,
   MAX(t1.cal_dt) AS max_cal_dt,
   SUM(t1.avail_to_promise_cnt) AS atp_bestand,
   SUM(t1.global_stock_cnt) AS globaler_bestand,
   SUM(t1.covered_remain_cnt) AS allokierter_bestand,
   SUM(t1.blocked_stock) AS sperrbestand
  FROM TMP_ETL_STOCK_DAILY_1 AS t1_2
   LEFT JOIN ldl_dig_core.t_dim_product_variant_2 AS T29 ON t1.prod_variant_sid = T29.prod_variant_sid AND T29.dwh_valid_fg
    
  GROUP BY t1.wshop_cd,
   T29.prod_sid,
   T29.prod_nr), TMP_ETL_KENNZAHLENDATEI AS (SELECT CONCAT('"""', 'OS', t1.os, '"""') AS land_2,
   t1.kopfartnr,
   t1.ian,
   CONCAT('"""', UPPER(t1.werbeimpuls), '"""') AS artikelart_u002e_,
   FORMAT_DATE('%d.%m.%Y', t1.verkaufsstart) AS verkaufsstart_u0028_werbetermin_u0029_,
   t1.anfangsbestand,
   t6.max_ekp AS `ek max`,
   IFNULL(t2.avg_vkp_eur, 0) AS `durchschnittlicher vk_2 in _u20ac_ _u0028_brutto_u0029_`,
   t1.akp_brutto_local_val AS `aktions-vk_2 in landeswährung _u0028_brutto_u0029_`,
   IFNULL(t5.vkp_price_gross_eur_val, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `aktueller vk_2 in _u20ac_ _u0028_brutto_u0029_`
   ,
   IFNULL(t2.avg_vkp_local_val, 0) AS `durchschnittlicher vk_2 in landeswährung _u0028_brutto_u0029_`,
   IFNULL(t5.vkp_price_gross_local_val, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `aktueller vk_2 in landeswährung _u0028_brutto_u0029_`
   ,
   CONCAT('"""', IFNULL(t1.curr_cd, ''), '"""') AS `belegwährung`,
   IFNULL(t1.t1_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `1 t vorb`,
   IFNULL(t1.t3_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `3 t vorb`,
   IFNULL(t1.t7_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `7 t vorb`,
   IFNULL(t1.t1p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `1t _u002b_ vorb`,
   IFNULL(t1.t3p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `3 t _u002b_ vorb`,
   IFNULL(t1.t7p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `7 t _u002b_ vorb`,
   IFNULL(t1.w2p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `2 w _u002b_ vorb`,
   IFNULL(t1.w3p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `3 w _u002b_ vorb`,
   IFNULL(t1.w4p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `4 w _u002b_ vorb`,
   IFNULL(t1.w5p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `5 w _u002b_ vorb`,
   IFNULL(t1.w6p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `6 w _u002b_ vorb`,
   IFNULL(t1.w7p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `7 w _u002b_ vorb`,
   IFNULL(t1.w8p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `8 w _u002b_ vorb`,
   IFNULL(t1.w9p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `9 w _u002b_ vorb`,
   IFNULL(t1.w10p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `10 w _u002b_ vorb`,
   IFNULL(t1.w11p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `11 w _u002b_ vorb`,
   IFNULL(t1.w12p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `12 w _u002b_ vorb`,
   IFNULL(t1.w18p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `18 w _u002b_ vorb`,
   IFNULL(t1.w20p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `20 w _u002b_ vorb`,
   IFNULL(t1.w26p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `26 w _u002b_ vorb`,
   IFNULL(t1.w52p_vorb, ROUND(CAST(0.00 AS BIGNUMERIC), 0)) AS `52 w _u002b_ vorb`,
   IFNULL(t1.t1_vorb_stuck, 0) AS `1 t vorb in stk`,
   IFNULL(t1.t3_vorb_stuck, 0) AS `3 t vorb in stk`,
   IFNULL(t1.t7_vorb_stuck, 0) AS `7 t vorb in stk`,
   IFNULL(t1.t1p_vorb_stuck, 0) AS `1 t _u002b_ vorb in stk`,
   IFNULL(t1.t3p_vorb_stuck, 0) AS `3 t _u002b_ vorb in stk`,
   IFNULL(t1.t7p_vorb_stuck, 0) AS `7 t _u002b_ vorb in stk`,
   IFNULL(t1.w2p_vorb_stuck, 0) AS `2 w _u002b_ vorb in stk`,
   IFNULL(t1.w3p_vorb_stuck, 0) AS `3 w _u002b_ vorb in stk`,
   IFNULL(t1.w4p_vorb_stuck, 0) AS `4 w _u002b_ vorb in stk`,
   IFNULL(t1.w5p_vorb_stuck, 0) AS `5 w _u002b_ vorb in stk`,
   IFNULL(t1.w6p_vorb_stuck, 0) AS `6 w _u002b_ vorb in stk`,
   IFNULL(t1.w7p_vorb_stuck, 0) AS `7 w _u002b_ vorb in stk`,
   IFNULL(t1.w8p_vorb_stuck, 0) AS `8 w _u002b_ vorb in stk`,
   IFNULL(t1.w9p_vorb_stuck, 0) AS `9 w _u002b_ vorb in stk`,
   IFNULL(t1.w10p_vorb_stuck, 0) AS `10 w _u002b_ vorb in stk`,
   IFNULL(t1.w11p_vorb_stuck, 0) AS `11 w _u002b_ vorb in stk`,
   IFNULL(t1.w12p_vorb_stuck, 0) AS `12 w _u002b_ vorb in stk`,
   IFNULL(t1.w18p_vorb_stuck, 0) AS `18 w _u002b_ vorb in stk`,
   IFNULL(t1.w20p_vorb_stuck, 0) AS `20 w _u002b_ vorb in stk`,
   IFNULL(t1.w26p_vorb_stuck, 0) AS `26 w _u002b_ vorb in stk`,
   IFNULL(t1.w52p_vorb_stuck, 0) AS `52 w _u002b_ vorb in stk`,
   IFNULL(CAST(t3.total_returns / t2.total_prod_qty * 100 AS BIGNUMERIC), 0) AS retourenquote,
   IFNULL(t7.globaler_bestand, 0) AS `globaler bestand`,
   IFNULL(t7.allokierter_bestand, 0) AS `allokierter bestand je os`,
   IFNULL(t7.atp_bestand, 0) AS `atp bestand`,
   IFNULL(t2.avg_menge_je_bestellung, 0) AS `average menge je bestellung`,
   IFNULL(CAST(t7.atp_bestand / (t2.total_prod_qty / (DATE_DIFF(t2.max_cust_order_dt, t2.min_cust_order_dt, DAY) + 1) * 7) AS BIGNUMERIC)
    , 0) AS reichweite,
   '0.00' AS `% epo`,
   IFNULL(t2.avg_warenkorbwert, 0) AS `average warenkorbwert`,
   '0' AS `bestellmenge mutterland`,
   '""""""' AS `tv mutterland`,
   '""""""' AS `region_2 mutterland`,
   t1.abverkaufshorizont,
   IFNULL(t7.sperrbestand, 0) AS sperrbestand,
   '0' AS `venlo dispo`,
   '0' AS `venlo nachdispo`,
   CAST(t1.akp_brutto_local_val / T4.exchange_rate AS BIGNUMERIC) AS `aktions-vk_2 in _u20ac_ brutto`,
   '' AS dummywert2,
   '' AS dummywert3,
   '' AS dummywert4,
   '' AS dummywert5,
   '' AS dummywert6
  FROM PROD_QTY_FINAL AS t1_2
   LEFT JOIN TOTAL_PROD_SALES AS t2 ON t1.os = t2.wshop_cd AND t1.kopfartnr = t2.prod_nr
   LEFT JOIN RETOUREN AS t3 ON t1.os = t3.wshop_cd AND t1.kopfartnr = t3.prod_nr
   LEFT JOIN ldl_dig_core.t_fact_currency_exchange_rate_2 AS T4 ON t1.curr_cd = T4.from_curr_cd AND T4.curr_exchange_rate_type_cd
       = 'F' AND t1.verkaufsstart BETWEEN T4.active_from_dt AND T4.active_to_dt
   LEFT JOIN AKTUELLER_VKP AS t5 ON t1.os = t5.wshop_cd AND t1.kopfartnr = t5.prod_nr
   LEFT JOIN EINKAUFSPREIS AS t6 ON t1.os = t6.wshop_cd AND t1.kopfartnr = t6.prod_nr
   LEFT JOIN STOCK_DAILY AS t7 ON t1.os = t7.wshop_cd AND t1.kopfartnr = t7.prod_nr), TMP_ETL_CURRENCY_COUNTRY AS (SELECT
    t2.curr_cd,
    T1.wshop_cd
   FROM ldl_dig_core.t_dim_webshop_2 AS T1_2
    INNER JOIN (SELECT DISTINCT curr_cd,
      wshop_cd
     FROM ldl_dig_core.t_fact_customer_order_line_2
     WHERE curr_cd IS NOT NULL) AS t2 ON T1.wshop_cd = t2.wshop_cd
   UNION DISTINCT
   SELECT *
   FROM (SELECT 'EUR' AS currency,
       'AT' AS country_2
      UNION ALL
      SELECT 'DKK' AS currency,
       'DK' AS country_2
      UNION ALL
      SELECT 'HUF' AS currency,
       'HU' AS country_2
      UNION ALL
      SELECT 'EUR' AS currency,
       'FR' AS country_2) AS t127
   WHERE country_2 NOT IN (SELECT T1.wshop_cd
      FROM ldl_dig_core.t_dim_webshop_2 AS T1_2
       INNER JOIN (SELECT DISTINCT curr_cd,
         wshop_cd
        FROM ldl_dig_core.t_fact_customer_order_line_2
        WHERE curr_cd IS NOT NULL) AS t2 ON T1.wshop_cd = t2.wshop_cd)) (SELECT *
  FROM (SELECT *
     FROM TMP_ETL_KENNZAHLENDATEI AS t1_2
     UNION DISTINCT
     SELECT t122.land_new AS land_2,
      t2.kopfartnr,
      t2.ian,
      t2.artikelart_u002e_,
      t2.verkaufsstart_u0028_werbetermin_u0029_,
      t2.anfangsbestand,
      t2.`ek max`,
      t2.`durchschnittlicher vk_2 in _u20ac_ _u0028_brutto_u0029_`,
      ROUND(CAST(t2.`aktions-vk_2 in landeswährung _u0028_brutto_u0029_` * T5.exchange_rate AS BIGNUMERIC), 2) AS
      `aktions-vk_2 in landeswährung _u0028_brutto_u0029_`,
      t2.`aktueller vk_2 in _u20ac_ _u0028_brutto_u0029_`,
      ROUND(CAST(t2.`durchschnittlicher vk_2 in landeswährung _u0028_brutto_u0029_` * T5.exchange_rate AS BIGNUMERIC), 2)
      AS `durchschnittlicher vk_2 in landeswährung _u0028_brutto_u0029_`,
      ROUND(CAST(t2.`aktueller vk_2 in landeswährung _u0028_brutto_u0029_` * T5.exchange_rate AS BIGNUMERIC), 2) AS
      `aktueller vk_2 in landeswährung _u0028_brutto_u0029_`,
      CONCAT('"""', IFNULL(t4.curr_cd, ''), '"""') AS `belegwährung`,
      t2.`1 t vorb`,
      t2.`3 t vorb`,
      t2.`7 t vorb`,
      t2.`1t _u002b_ vorb`,
      t2.`3 t _u002b_ vorb`,
      t2.`7 t _u002b_ vorb`,
      t2.`2 w _u002b_ vorb`,
      t2.`3 w _u002b_ vorb`,
      t2.`4 w _u002b_ vorb`,
      t2.`5 w _u002b_ vorb`,
      t2.`6 w _u002b_ vorb`,
      t2.`7 w _u002b_ vorb`,
      t2.`8 w _u002b_ vorb`,
      t2.`9 w _u002b_ vorb`,
      t2.`10 w _u002b_ vorb`,
      t2.`11 w _u002b_ vorb`,
      t2.`12 w _u002b_ vorb`,
      t2.`18 w _u002b_ vorb`,
      t2.`20 w _u002b_ vorb`,
      t2.`26 w _u002b_ vorb`,
      t2.`52 w _u002b_ vorb`,
      t2.`1 t vorb in stk`,
      t2.`3 t vorb in stk`,
      t2.`7 t vorb in stk`,
      t2.`1 t _u002b_ vorb in stk`,
      t2.`3 t _u002b_ vorb in stk`,
      t2.`7 t _u002b_ vorb in stk`,
      t2.`2 w _u002b_ vorb in stk`,
      t2.`3 w _u002b_ vorb in stk`,
      t2.`4 w _u002b_ vorb in stk`,
      t2.`5 w _u002b_ vorb in stk`,
      t2.`6 w _u002b_ vorb in stk`,
      t2.`7 w _u002b_ vorb in stk`,
      t2.`8 w _u002b_ vorb in stk`,
      t2.`9 w _u002b_ vorb in stk`,
      t2.`10 w _u002b_ vorb in stk`,
      t2.`11 w _u002b_ vorb in stk`,
      t2.`12 w _u002b_ vorb in stk`,
      t2.`18 w _u002b_ vorb in stk`,
      t2.`20 w _u002b_ vorb in stk`,
      t2.`26 w _u002b_ vorb in stk`,
      t2.`52 w _u002b_ vorb in stk`,
      t2.retourenquote,
      t2.`globaler bestand`,
      t2.`allokierter bestand je os`,
      t2.`atp bestand`,
      t2.`average menge je bestellung`,
      t2.reichweite,
      t2.`% epo`,
      t2.`average warenkorbwert`,
      t2.`bestellmenge mutterland`,
      t2.`tv mutterland`,
      t2.`region_2 mutterland`,
      t2.abverkaufshorizont,
      t2.sperrbestand,
      t2.`venlo dispo`,
      t2.`venlo nachdispo`,
      t2.`aktions-vk_2 in _u20ac_ brutto`,
      t2.dummywert2,
      t2.dummywert3,
      t2.dummywert4,
      t2.dummywert5,
      t2.dummywert6
     FROM TMP_ETL_KENNZAHLENDATEI AS t2
      RIGHT JOIN (SELECT '"""OSAT"""' AS land_new
        UNION ALL
        SELECT '"""OSDK"""' AS land_new
        UNION ALL
        SELECT '"""OSHU"""' AS land_new
        UNION ALL
        SELECT '"""OSFR"""' AS land_new) AS t122 ON t2.land_2 = '"""OSDE"""'
      LEFT JOIN TMP_ETL_CURRENCY_COUNTRY AS t4 ON LEFT(IFNULL(SPLIT(t122.land_new, 'OS')[SAFE_OFFSET(- 1)], ''), 2) = t4
       .wshop_cd
      LEFT JOIN ldl_dig_core.t_fact_currency_exchange_rate_2 AS T5 ON t4.curr_cd = T5.from_curr_cd AND T5.curr_exchange_rate_type_cd
          = 'F' AND T5.active_fg));



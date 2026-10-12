CREATE OR REPLACE VIEW TRANSFER.V_AMP_EXPORT_KENNZAHLENDATEI AS
(

-- START WITH (definition of support CTEs)

    WITH 

------------------------------------
-- PARAMETERS - Country currencies
------------------------------------

tmp_etl_currency_country AS
(
    SELECT
        t2.curr_cd
        , t1.wshop_cd
    FROM
        core.t_dim_webshop AS t1
    INNER JOIN
        (
            SELECT DISTINCT 
                curr_cd
                , wshop_cd
            FROM
                core.t_fact_customer_order_line         -- Workaround, as there is currently no DIM table on Core for wshop_cd <-> curr_cd
            WHERE 
                curr_cd IS NOT NULL
        ) AS t2
    ON 
        t1.wshop_cd = t2.wshop_cd

UNION
    
    SELECT
      currency
      ,country
    FROM
        (VALUES
              ('EUR','AT')
            , ('DKK','DK')
            , ('HUF','HU')
            , ('EUR','FR')
        ) AS temp(currency, country)
     WHERE country 
        NOT IN (
                SELECT
                    t1.wshop_cd
                FROM
                    core.t_dim_webshop AS t1
                INNER JOIN
                    (
                        SELECT DISTINCT 
                            curr_cd
                            , wshop_cd
                        FROM
                            core.t_fact_customer_order_line         -- Workaround, as there is currently no DIM table on Core for wshop_cd <-> curr_cd
                        WHERE 
                            curr_cd IS NOT NULL
                    ) AS t2
                ON 
                    t1.wshop_cd = t2.wshop_cd
                )

),

----------------------------------------------
 --   I. DIM - Article Master Data (regional)
----------------------------------------------

artikel AS
(
    SELECT
        t1.wshop_cd
        , t1.prod_sid
        , t1.prod_nr
        , t1.prod_variant_sid
        , t1.prod_variant_nr
        , IFF(TRY_TO_DECIMAL(t2.ian_nr) IS NULL, t1.prod_nr, t2.ian_nr)    AS ian_nr   -- Due to data quality issues, replace numbers with non-numerical characters
        , t1.reg_prod_variant_name
        , t1.reg_prod_variant_descr
        , t1.tax_class_cd
    FROM 
        core.t_rel_product_variant_regional     AS t1
    JOIN
        core.t_dim_product_variant              AS t2
      ON 
            t1.prod_variant_sid = t2.prod_variant_sid
        AND t1.dwh_valid_fg = 1
        AND t2.dwh_valid_fg = 1
),

-------------------------------------------------------------
--    II. FACTS - Sales promotion target (Aktionsplanmengen)
-------------------------------------------------------------

    -- II.1 - First ETL step: filtering, formatting, aliasing, key definition

tmp_etl_aktionsplanmengen AS 
(
    SELECT
        CONCAT( t1.wshop_cd, t1.prod_sid, t1.promo_dt )                     AS PK
        , CONCAT( t1.wshop_cd, t1.prod_sid )                                AS Artikel_OS
        , t1.wshop_cd                                                       AS OS
        , t1.prod_sid                                                       AS prod_sid
        , t2.prod_nr                                                        AS KopfArtNr
        , IFF(TRY_TO_DECIMAL(t2.ian_nr) IS NULL, t2.prod_nr, t2.ian_nr)     AS Lidlnummer
        , t1.promo_dt                                                       AS Verkaufsstart
        , t1.sale_promo_type_cd                                             AS Werbeimpuls
        , t1.promo_price_gross_local_val                                    AS AKP_brutto_local_val
        , t1.curr_cd                                                        AS curr_cd
        , t1.tgt_prod_sale_qty                                              AS Anfangsbestand
        , t1.promo_dur_week_cnt                                             AS Abverkaufshorizont
    FROM
        core.t_fact_sales_promotion_target  AS t1
    JOIN
        core.t_dim_product  				AS t2
      ON  
            t1.prod_sid = t2.prod_sid
        AND t2.dwh_valid_fg = 1
    WHERE
        Verkaufsstart >= ADD_MONTHS(DATE_TRUNC('MONTH', CURRENT_DATE()), -6)
),

    -- II.2 - Second ETL step: legacy data reduction logic: keep only one record per wshop and prod_sid

aktionsplanmengen AS 
(
  SELECT
      * 
  FROM
      tmp_etl_aktionsplanmengen
  WHERE
      PK IN (
        SELECT 
            FIRST_VALUE( PK ) OVER ( PARTITION BY Artikel_OS ORDER BY Anfangsbestand DESC, Verkaufsstart DESC) 
        FROM 
            tmp_etl_aktionsplanmengen
      )
),

--------------------------------
--    III. FACTS - Sales orders
--------------------------------          

    -- III.1 - First ETL step

tmp_etl_kundenauftrag_1 AS
(
    SELECT
        wshop_cd
        , cust_order_sid
        , cust_order_dt
        , cust_order_nr
        , prod_variant_sid
        , cust_order_pos_nr
        , prod_qty                                  -- Sales orders quantities (KWMENG)
        , curr_cd
        , prod_price_gross_local_val                -- Brutto_Artikelverkaufswert_KZWI1_LANDESWÄHRUNG
        , delivery_cost_gross_local_val             -- Brutto_Art.spez.Versandkosten_KZWI3_LANDESWÄHRUNG
        , delivery_paushal_gross_local_val          -- Brutto_Versandkostenpauschale_KZWI2_LANDESWÄHRUNG  
        , tax_class_cd
        , cust_order_type_cd
        , is_part_of_bundle_header_cnt_fg
    FROM 
        core.t_fact_customer_order_line
    WHERE 
            cust_order_dt >= ADD_MONTHS(DATE_TRUNC('MONTH', CURRENT_DATE()), -6)      -- Date filter: only grab facts from the last 6 months
        AND (
                    ( wshop_cd  = 'DE' AND is_part_of_bundle_header_cnt_fg   )        -- Replacement filter for Qlik "VBAK.Belegdatum_AUDAT_Relevant" filter
                OR  ( wshop_cd != 'DE' AND is_part_of_bundle_pos_cnt_fg      ) 
            )
),

    -- III.2 - Add prod_sid info to Kundenauftrag + EUR values

Kundenauftrag AS
(
    SELECT
        t2.prod_sid                                                                 AS prod_sid             
        , t2.prod_nr                                                                AS prod_nr            
        , t1.wshop_cd                                                               AS wshop_cd              
        , t1.cust_order_sid                                                         AS cust_order_sid             
        , t1.cust_order_dt                                                          AS cust_order_dt
        , t1.cust_order_nr                                                          AS cust_order_nr
        , t1.prod_variant_sid                                                       AS prod_variant_sid
        , t1.cust_order_pos_nr                                                      AS cust_order_pos_nr
        , CAST(t1.prod_qty AS DECIMAL(10,2))                                        AS prod_qty  
        , t1.curr_cd                                                                AS curr_cd
        , CAST(t1.prod_price_gross_local_val AS DECIMAL(38,5))                      AS prod_price_gross_local_val  
        , CAST(t1.delivery_cost_gross_local_val AS DECIMAL (38,5))                  AS delivery_cost_gross_local_val  
        , CAST(t1.delivery_paushal_gross_local_val AS DECIMAL(38,5))                AS delivery_paushal_gross_local_val  
        , t1.tax_class_cd                                                           AS tax_class_cd
        , t1.cust_order_type_cd                                                     AS cust_order_type_cd
        , t1.is_part_of_bundle_header_cnt_fg                                        AS is_part_of_bundle_header_cnt_fg
        , CAST(t1.prod_price_gross_local_val/t3.exchange_rate AS DECIMAL(38,5))     AS prod_price_gross_eur
    FROM 
        tmp_etl_kundenauftrag_1             AS t1
    LEFT JOIN  
        core.t_dim_product_variant          AS t2
      ON 
            t1.prod_variant_sid = t2.prod_variant_sid
        AND t2.dwh_valid_fg
    LEFT JOIN
        core.t_fact_currency_exchange_rate  AS t3
      ON 
            t1.curr_cd = t3.from_curr_cd
        AND t3.curr_exchange_rate_type_cd = 'F'
        AND t1.cust_order_dt BETWEEN t3.active_from_dt AND t3.active_to_dt
),

--------------------------------
--    IV. FACTS - Return Orders
--------------------------------

    -- IV.1 - First ETl step

tmp_etl_retouren_1 AS
(
    SELECT
		t1.wshop_cd    
		, t1.cust_order_sid
		, t1.cust_order_nr
		, t1.cust_order_dt  
		, t1.cust_order_return_sid
		, t1.cust_order_return_nr        
		, t1.prod_variant_sid
		, t1.prod_qty				AS return_prod_qty
	FROM 
		core.t_fact_customer_return_line    AS t1
    INNER JOIN
        Kundenauftrag                       AS t2
    ON
            t1.cust_order_sid = t2.cust_order_sid
        AND t1.cust_order_pos_nr = t2.cust_order_pos_nr
),

    -- IV.2 - Second ETL step

tmp_etl_retouren_2 AS
(
    SELECT
        t2.prod_sid
        , t2.prod_nr
        , t1.*
    FROM
        tmp_etl_retouren_1          AS t1
    LEFT JOIN  
        core.t_dim_product_variant  AS t2
    ON 
            t1.prod_variant_sid = t2.prod_variant_sid
        AND t2.dwh_valid_fg = 1
)
,

    -- IV.3 - Generate returns data per prod_sid

retouren AS
(
    SELECT  
        prod_sid                    AS prod_sid
        , prod_nr                   AS prod_nr
        , wshop_cd                  AS wshop_cd
        , SUM(return_prod_qty)      AS total_returns
    FROM
        tmp_etl_retouren_2
    GROUP BY
        prod_sid
        , prod_nr
        , wshop_cd
),
    
------------------------------------
--   V. FACTS - Latest Sales Price
------------------------------------    

    -- V.1 - First ETL step: join with dim_product_variant

tmp_etl_aktueller_vkp AS
(
    SELECT
        t1.wshop_cd
        , t2.prod_sid
        , t2.prod_nr
        , t1.prod_variant_sid
        , t1.curr_cd
        , t1.cal_dt
        , t1.vkp_price_gross_local_val AS vkp_price_gross_local_val
        , t1.vkp_price_gross_eur_val AS vkp_price_gross_eur_val
    FROM 
        core.t_fact_product_price_sale_ivp_gld_vkp  AS t1
    INNER JOIN 
        core.t_dim_product_variant t2
    ON  
            t1.prod_variant_sid = t2.prod_variant_sid   
        AND t1.dwh_valid_fg = 1
        AND t2.dwh_valid_fg = 1     
),

    -- V.2 - Generate Latest VKP values on product level

aktueller_vkp AS
(   
    SELECT 
          t1.wshop_cd                                                   AS wshop_cd
        , t1.prod_sid                                                   AS prod_sid
        , t1.prod_nr                                                    AS prod_nr
        , t1.cal_dt                                                     AS cal_dt
        , CAST(AVG(t1.vkp_price_gross_local_val) AS DECIMAL(38,2))      AS vkp_price_gross_local_val
        , CAST(AVG(t1.vkp_price_gross_eur_val) AS DECIMAL(38,2))        AS vkp_price_gross_eur_val
    FROM
        tmp_etl_aktueller_vkp t1
    WHERE 
        (wshop_cd, prod_sid, prod_nr, cal_dt) IN
            (
                SELECT
                   wshop_cd
                   , prod_sid
                   , prod_nr
                   , MAX(cal_dt)    AS cal_dt      -- Take latest date, and take the min(vkp) IN case a product has 2 prices on that date
                FROM
                   tmp_etl_aktueller_vkp
                GROUP BY
                   wshop_cd
                   , prod_sid
                   , prod_nr
            )
    GROUP BY
        wshop_cd
        , prod_sid
        , prod_nr
        , cal_dt
), 


------------------------------------
--    VI. FACTS - Purchasing prices
------------------------------------    

    -- VI.1 - First ETL step

tmp_etl_einkaufspreis AS
(
    SELECT
        t1.wshop_cd
        , t1.supplier_sid
        , t1.prod_variant_sid
        , t1.curr_cd
        , t1.price_val
    FROM 
        core.t_fact_product_price_supplier  t1
    WHERE
            t1.price_type_cd = 'EKP'
        AND t1.active_from_tmsp <= GETDATE()
        AND t1.active_to_tmsp >= GETDATE()
),

    -- VI.2 - Generate EKP values needed for final view on product level

einkaufspreis AS
(
    SELECT
        t2.prod_sid
        , t2.prod_nr
        , t1.wshop_cd
        , CAST(MAX(t1.price_val) AS DECIMAL (38,2))  AS max_ekp
    FROM
        tmp_etl_einkaufspreis       AS t1
    JOIN
        core.t_dim_product_variant  AS t2
      ON 
            t1.prod_variant_sid = t2.prod_variant_sid
        AND t1.supplier_sid = t2.main_supplier_sid     
        AND t2.dwh_valid_fg
    GROUP BY
        t2.prod_sid
        , t2.prod_nr
        , t1.wshop_cd
),

--------------------------------------------
--   VII. FACTS - Webshop stock information
--------------------------------------------   

    -- VII.1 - First ETL step

tmp_etl_stock_daily_1 AS
(
    SELECT
        t1.wshop_cd
        , t1.prod_variant_sid
        , t1.cal_dt
        , t1.avail_to_promise_cnt
        , t1.global_stock_cnt
        , t1.covered_remain_cnt
        , t2.blocked_stock
    FROM
        core.t_fact_stock_webshop_daily AS t1
    LEFT JOIN
        (
            SELECT
                 prod_variant_sid
                , SUM(blocked_stock_cnt)  AS blocked_stock
            FROM
                core.t_fact_stock_warehouse_storage_location_daily
            WHERE 
                active_fg = 'TRUE'
            GROUP BY
                prod_variant_sid
        ) t2
    ON 
        t1.prod_variant_sid = t2.prod_variant_sid
    WHERE
        (t1.wshop_cd, t1.prod_variant_sid, t1.cal_dt) IN
        (
            SELECT
                 t2.wshop_cd
                , t2.prod_variant_sid
                , MAX(t2.cal_dt) AS cal_dt
            FROM
                core.t_fact_stock_webshop_daily AS t2
            GROUP BY
                 t2.wshop_cd
                ,t2.prod_variant_sid
        )
) ,     

    -- VII.2 - Get stock data per product / wshop

stock_daily AS
(
    SELECT
        t1.wshop_cd                         AS wshop_cd
        , t2.prod_sid                       AS prod_sid
        , t2.prod_nr                        AS prod_nr
        , MAX( t1.cal_dt )                  AS max_cal_dt
        , SUM( t1.avail_to_promise_cnt )    AS atp_bestand
        , SUM( t1.global_stock_cnt )        AS globaler_bestand
        , SUM( t1.covered_remain_cnt )      AS allokierter_bestand
        , SUM( t1.blocked_stock  )          AS Sperrbestand
    FROM
        tmp_etl_stock_daily_1       AS t1
    LEFT JOIN
        core.t_dim_product_variant  AS t2
      ON
            t1.prod_variant_sid = t2.prod_variant_sid
        AND t2.dwh_valid_fg
    GROUP BY
        wshop_cd
        , prod_sid
        , prod_nr
),


----------------------------------------------------------------------------------------------------------------------------------------------------------
-- PART 2 >>> CREATION OF THE FINAL VIEWS
----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------
--    VIEW 1 -- KENNZAHLENDATEI
--------------------------------

    ------------------------------
    --    1. Support table for Dates
    ------------------------------  

t_par_dates AS
(
    SELECT
        t1.wshop_cd
        , t2.start_date
        , t2.t1_vorb_date_par
        , t2.t3_vorb_date_par
        , t2.t7_vorb_date_par
        , t2.t1p_vorb_date_par
        , t2.t3p_vorb_date_par
        , t2.t7p_vorb_date_par
        , t2.W2p_vorb_date_par
        , t2.W3p_vorb_date_par
        , t2.W4p_vorb_date_par
        , t2.W5p_vorb_date_par
        , t2.W6p_vorb_date_par
        , t2.W7p_vorb_date_par
        , t2.W8p_vorb_date_par
        , t2.W9p_vorb_date_par
        , t2.W10p_vorb_date_par
        , t2.W11p_vorb_date_par
        , t2.W12p_vorb_date_par
        , t2.W18p_vorb_date_par
        , t2.W20p_vorb_date_par
        , t2.W26p_vorb_date_par
        , t2.W52p_vorb_date_par
    FROM
    (VALUES
        ('DE', 1),
        ('NL', 3),
        ('BE', 2),
        ('CZ', 1),
        ('PL', 2),
        ('SK', 2)
        ) AS t1(wshop_cd, case_id)    
    JOIN
        (VALUES
            (1, 'DE-CZ',    '-8', '-7', '-5', '-1', '1', '3', '7', '14', '21', '28', '35', '42', '49', '56', '63', '70', '77', '84', '126', '140', '182', '364'),
            (2, 'BE-PL-SK', '-7', '-6', '-4', '0', '1', '3', '7', '14', '21', '28', '35', '42', '49', '56', '63', '70', '77', '84', '126', '140', '182', '364'),
            (3, 'NL',       '-4', '-3', '-1', '3', '4', '6', '10', '17', '24', '31', '38', '45', '52', '59', '66', '73', '80', '87', '129', '143', '185', '367') 
        ) AS t2 (case_id, case_comment, start_date, t1_vorb_date_par, t3_vorb_date_par, t7_vorb_date_par, t1p_vorb_date_par, t3p_vorb_date_par, t7p_vorb_date_par, W2p_vorb_date_par, W3p_vorb_date_par, W4p_vorb_date_par, W5p_vorb_date_par, W6p_vorb_date_par, W7p_vorb_date_par, W8p_vorb_date_par, W9p_vorb_date_par, W10p_vorb_date_par, W11p_vorb_date_par, W12p_vorb_date_par, W18p_vorb_date_par, W20p_vorb_date_par, W26p_vorb_date_par, W52p_vorb_date_par)
    ON 
        t1.case_id = t2.case_id
),

    ---------------------------------------------------------------------------------
    --   3. Calculate prod_qty and quotes of sold products for specified time ranges
    ---------------------------------------------------------------------------------  

        -- Step 1 - Join calendar dates (calculated) with promotion dates (aktionsplanmengen)

tmp_etl_aktiondates AS
(
    SELECT
          t1.OS
        , t1.prod_sid
        , t1.kopfartnr
        , IFNULL(t1.Lidlnummer, t1.KopfArtNr)   AS IAN   
        , t1.Werbeimpuls                               
        , t1.Verkaufsstart
        , t1.Anfangsbestand
        , t1.Abverkaufshorizont                           
        , t1.AKP_brutto_local_val
        , t1.curr_cd
        , CAST(GETDATE() AS DATE) AS today

    -- Basis for further date calculations (all countries have a different logic)

        , CASE WHEN OS IN ('NL') THEN DATE_TRUNC('WEEK', t1.Verkaufsstart -3)       -- NL
                ELSE CASE WHEN OS IN ('BE') THEN t1.Verkaufsstart                   -- BE
                        ELSE DATE_TRUNC('WEEK',t1.Verkaufsstart)                    -- Others
                    END
            END AS calc_date
    
    -- Basic for special case PL logic
  
        , CASE WHEN OS IN ('PL','SK') THEN t1.Verkaufsstart                         -- PL / SK
                ELSE calc_date                                                      -- Others
            END AS calc_date_check

     -- Date calculations (for breadkdown of sales numbers, IN the next step)

        , CAST( calc_date + CAST( t2.start_date           AS INTEGER) AS DATE)     AS start_date        
        , CAST( calc_date + CAST( t2.t1_vorb_date_par     AS INTEGER) AS DATE)     AS t1_vorb_date
        , CAST( calc_date + CAST( t2.t3_vorb_date_par     AS INTEGER) AS DATE)     AS t3_vorb_date
        , CAST( calc_date + CAST( t2.t7_vorb_date_par     AS INTEGER) AS DATE)     AS t7_vorb_date
        , CAST( calc_date + CAST( t2.t1p_vorb_date_par    AS INTEGER) AS DATE)     AS t1p_vorb_date
        , CAST( calc_date + CAST( t2.t3p_vorb_date_par    AS INTEGER) AS DATE)     AS t3p_vorb_date
        , CAST( calc_date + CAST( t2.t7p_vorb_date_par    AS INTEGER) AS DATE)     AS t7p_vorb_date
        , CAST( calc_date + CAST( t2.w2p_vorb_date_par    AS INTEGER) AS DATE)     AS w2p_vorb_date
        , CAST( calc_date + CAST( t2.w3p_vorb_date_par    AS INTEGER) AS DATE)     AS w3p_vorb_date
        , CAST( calc_date + CAST( t2.w4p_vorb_date_par    AS INTEGER) AS DATE)     AS w4p_vorb_date
        , CAST( calc_date + CAST( t2.w5p_vorb_date_par    AS INTEGER) AS DATE)     AS w5p_vorb_date
        , CAST( calc_date + CAST( t2.w6p_vorb_date_par    AS INTEGER) AS DATE)     AS w6p_vorb_date
        , CAST( calc_date + CAST( t2.w7p_vorb_date_par    AS INTEGER) AS DATE)     AS w7p_vorb_date
        , CAST( calc_date + CAST( t2.w8p_vorb_date_par    AS INTEGER) AS DATE)     AS w8p_vorb_date
        , CAST( calc_date + CAST( t2.w9p_vorb_date_par    AS INTEGER) AS DATE)     AS w9p_vorb_date
        , CAST( calc_date + CAST( t2.w10p_vorb_date_par   AS INTEGER) AS DATE)     AS w10p_vorb_date
        , CAST( calc_date + CAST( t2.w11p_vorb_date_par   AS INTEGER) AS DATE)     AS w11p_vorb_date
        , CAST( calc_date + CAST( t2.w12p_vorb_date_par   AS INTEGER) AS DATE)     AS w12p_vorb_date
        , CAST( calc_date + CAST( t2.w18p_vorb_date_par   AS INTEGER) AS DATE)     AS w18p_vorb_date
        , CAST( calc_date + CAST( t2.w20p_vorb_date_par   AS INTEGER) AS DATE)     AS w20p_vorb_date
        , CAST( calc_date + CAST( t2.w26p_vorb_date_par   AS INTEGER) AS DATE)     AS w26p_vorb_date
        , CAST( calc_date + CAST( t2.w52p_vorb_date_par   AS INTEGER) AS DATE)     AS w52p_vorb_date

    -- Special case due to CZ logic

        , CASE WHEN wshop_cd = 'CZ' 
            THEN t1_vorb_date + 1
                ELSE t1_vorb_date
          END                               AS t1_vorb_date_check

        , CASE WHEN wshop_cd = 'CZ' 
            THEN CAST(t3_vorb_date AS DATE) + 1
                ELSE CAST(t3_vorb_date AS DATE)
          END                               AS t3_vorb_date_check

        , CASE WHEN wshop_cd = 'CZ' 
            THEN CAST(t7_vorb_date AS DATE) + 1
                ELSE CAST(t7_vorb_date AS DATE)
          END                               AS t7_vorb_date_check 
        
        , CAST( calc_date_check + CAST( t2.t1p_vorb_date_par    AS INTEGER) AS DATE)     AS t1p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.t3p_vorb_date_par    AS INTEGER) AS DATE)     AS t3p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.t7p_vorb_date_par    AS INTEGER) AS DATE)     AS t7p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w2p_vorb_date_par    AS INTEGER) AS DATE)     AS w2p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w3p_vorb_date_par    AS INTEGER) AS DATE)     AS w3p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w4p_vorb_date_par    AS INTEGER) AS DATE)     AS w4p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w5p_vorb_date_par    AS INTEGER) AS DATE)     AS w5p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w6p_vorb_date_par    AS INTEGER) AS DATE)     AS w6p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w7p_vorb_date_par    AS INTEGER) AS DATE)     AS w7p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w8p_vorb_date_par    AS INTEGER) AS DATE)     AS w8p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w9p_vorb_date_par    AS INTEGER) AS DATE)     AS w9p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w10p_vorb_date_par   AS INTEGER) AS DATE)     AS w10p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w11p_vorb_date_par   AS INTEGER) AS DATE)     AS w11p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w12p_vorb_date_par   AS INTEGER) AS DATE)     AS w12p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w18p_vorb_date_par   AS INTEGER) AS DATE)     AS w18p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w20p_vorb_date_par   AS INTEGER) AS DATE)     AS w20p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w26p_vorb_date_par   AS INTEGER) AS DATE)     AS w26p_vorb_date_check
        , CAST( calc_date_check + CAST( t2.w52p_vorb_date_par   AS INTEGER) AS DATE)     AS w52p_vorb_date_check
       
    FROM
        Aktionsplanmengen 	AS t1
    JOIN
        t_par_dates 		AS t2
    ON
        t1.OS = t2.wshop_cd
),

        -- Step 2 - Calculate the prod_qty per time range on variant level

tmp_etl_prod_qty AS
(
    SELECT
        t1.prod_sid
        , t1.prod_nr
        , t1.prod_variant_sid
        , t1.wshop_cd
        , t1.cust_order_dt
        , t2.OS 
        , t2.KopfArtNr 
        , t2.IAN   
        , t2.Werbeimpuls
        , t2.Verkaufsstart
        , t2.Anfangsbestand
        , t2.Abverkaufshorizont  
        , t2.AKP_brutto_local_val 
        , t2.curr_cd
        
        , CASE WHEN t2.today < t2.t1_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t1_vorb_date_check  -- t1_vorb_date_check = necessary adjustment due to CZ logic
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_1t_vorb

        , CASE WHEN t2.today < t2.t3_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t3_vorb_date_check  -- t3_vorb_date_check = necessary adjustment due to CZ logic
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_3t_vorb

        , CASE WHEN t2.today < t2.t7_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t7_vorb_date_check  -- t7_vorb_date_check = necessary adjustment due to CZ logic
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_7t_vorb

        , CASE WHEN t2.today < t2.t1p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t1p_vorb_date_check -- t7_vorb_date_check = necessary adjustment due to PL logic
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_1tp_vorb

        , CASE WHEN t2.today < t2.t3p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t3p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_3tp_vorb

        , CASE WHEN t2.today < t2.t7p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.t7p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_7tp_vorb

        , CASE WHEN t2.today < t2.w2p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w2p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_2wp_vorb

        , CASE WHEN t2.today < t2.w3p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w3p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_3wp_vorb

        , CASE WHEN t2.today < t2.w4p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w4p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_4wp_vorb

        , CASE WHEN t2.today < t2.w5p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w5p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_5wp_vorb

        , CASE WHEN t2.today < t2.w6p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w6p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_6wp_vorb

        , CASE WHEN t2.today < t2.w7p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w7p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_7wp_vorb

        , CASE WHEN t2.today < t2.w8p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w8p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_8wp_vorb

        , CASE WHEN t2.today < t2.w9p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w9p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_9wp_vorb

        , CASE WHEN t2.today < t2.w10p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w10p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_10wp_vorb

        , CASE WHEN t2.today < t2.w11p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w11p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_11wp_vorb

        , CASE WHEN t2.today < t2.w12p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w12p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_12wp_vorb

        , CASE WHEN t2.today < t2.w18p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w18p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_18wp_vorb

        , CASE WHEN t2.today < t2.w20p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w20p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_20wp_vorb

        , CASE WHEN t2.today < t2.w26p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w26p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_26wp_vorb

        , CASE WHEN t2.today < t2.w52p_vorb_date
            THEN 0
            ELSE CASE WHEN t1.cust_order_dt >= t2.start_date AND t1.cust_order_dt < t2.w52p_vorb_date_check 
            THEN t1.prod_qty
            ELSE 0
            END
        END AS qty_52wp_vorb

    FROM
        Kundenauftrag           AS t1
    JOIN
        tmp_etl_aktiondates     AS t2
      ON 
            t1.wshop_cd = t2.os
        AND t1.prod_sid = t2.prod_sid
),

-- Step 3 -> calculate the prod_qty per time range on product level

tmp_etl_prod_qty_v2 AS
(
    SELECT
        prod_sid                    AS prod_sid
        , prod_nr                   AS prod_nr
        , wshop_cd                  AS wshop_cd
        , verkaufsstart             AS verkaufsstart
        , anfangsbestand            AS anfangsbestand
        , OS                        AS OS
        , KopfArtNr                 AS KopfArtNr
        , IAN                       AS IAN
        , Werbeimpuls               AS Werbeimpuls
        , Abverkaufshorizont        AS Abverkaufshorizont
        , AKP_brutto_local_val      AS AKP_brutto_local_val
        , curr_cd                   AS curr_cd
        , SUM(qty_1t_vorb)          AS t1_vorb_stuck   
        , SUM(qty_3t_vorb)          AS t3_vorb_stuck
        , SUM(qty_7t_vorb)          AS t7_vorb_stuck
        , SUM(qty_1tp_vorb)         AS t1p_vorb_stuck
        , SUM(qty_3tp_vorb)         AS t3p_vorb_stuck
        , SUM(qty_7tp_vorb)         AS t7p_vorb_stuck
        , SUM(qty_2wp_vorb)         AS w2p_vorb_stuck
        , SUM(qty_3wp_vorb)         AS w3p_vorb_stuck
        , SUM(qty_4wp_vorb)         AS w4p_vorb_stuck
        , SUM(qty_5wp_vorb)         AS w5p_vorb_stuck
        , SUM(qty_6wp_vorb)         AS w6p_vorb_stuck
        , SUM(qty_7wp_vorb)         AS w7p_vorb_stuck
        , SUM(qty_8wp_vorb)         AS w8p_vorb_stuck
        , SUM(qty_9wp_vorb)         AS w9p_vorb_stuck
        , SUM(qty_10wp_vorb)        AS w10p_vorb_stuck     
        , SUM(qty_11wp_vorb)        AS w11p_vorb_stuck     
        , SUM(qty_12wp_vorb)        AS w12p_vorb_stuck     
        , SUM(qty_18wp_vorb)        AS w18p_vorb_stuck     
        , SUM(qty_20wp_vorb)        AS w20p_vorb_stuck     
        , SUM(qty_26wp_vorb)        AS w26p_vorb_stuck     
        , SUM(qty_52wp_vorb)        AS w52p_vorb_stuck     
    FROM
        tmp_etl_prod_qty
    GROUP BY
        prod_sid
        , prod_nr
        , wshop_cd
        , verkaufsstart
        , anfangsbestand
        , OS
        , KopfArtNr
        , IAN
        , Werbeimpuls
        , Abverkaufshorizont
        , AKP_brutto_local_val
        , curr_cd
),

-- Step 4 -> Calculate also the quotes per time range (qty/anfangsbestand)

prod_qty_final AS
(
    SELECT
        prod_sid                                                                                    AS prod_sid
        , prod_nr                                                                                   AS prod_nr
        , wshop_cd                                                                                  AS wshop_cd
        , verkaufsstart                                                                             AS verkaufsstart
        , anfangsbestand                                                                            AS anfangsbestand
        , OS                                                                                        AS OS
        , KopfArtNr                                                                                 AS KopfArtNr
        , IAN                                                                                       AS IAN
        , Werbeimpuls                                                                               AS Werbeimpuls
        , Abverkaufshorizont                                                                        AS Abverkaufshorizont
        , CAST(AKP_brutto_local_val AS DECIMAL(38,2))                                               AS AKP_brutto_local_val
        , curr_cd                                                                                   AS curr_cd
        , CAST( LEAST( IFNULL(DIV0( t1_vorb_stuck, anfangsbestand ),'0.00'), '999.99'   ) AS DECIMAL(5,2))   AS t1_vorb    
        , CAST( LEAST( IFNULL(DIV0( t3_vorb_stuck, anfangsbestand ),'0.00'), '999.99'   ) AS DECIMAL(5,2))   AS t3_vorb    
        , CAST( LEAST( IFNULL(DIV0( t7_vorb_stuck, anfangsbestand ),'0.00'), '999.99'   ) AS DECIMAL(5,2))   AS t7_vorb    
        , CAST( LEAST( IFNULL(DIV0( t1p_vorb_stuck, anfangsbestand ),'0.00'), '999.99'  ) AS DECIMAL(5,2))   AS t1p_vorb
        , CAST( LEAST( IFNULL(DIV0( t3p_vorb_stuck, anfangsbestand ),'0.00'), '999.99'  ) AS DECIMAL(5,2))   AS t3p_vorb
        , CAST( LEAST( IFNULL(DIV0( t7p_vorb_stuck, anfangsbestand ),'0.00'), '999.99'  ) AS DECIMAL(5,2))   AS t7p_vorb
        , CAST( LEAST( IFNULL(DIV0( w2p_vorb_stuck, anfangsbestand ),'0.00'), '999.99'  ) AS DECIMAL(5,2))   AS w2p_vorb
        , CAST( LEAST( IFNULL(DIV0( w3p_vorb_stuck, anfangsbestand ),'0.00'), '999.99'  ) AS DECIMAL(5,2))   AS w3p_vorb
        , CAST( LEAST( IFNULL(DIV0( w4p_vorb_stuck, anfangsbestand ),'0.00'), '999.99'  ) AS DECIMAL(5,2))   AS w4p_vorb
        , CAST( LEAST( IFNULL(DIV0( w5p_vorb_stuck, anfangsbestand ),'0.00'), '999.99'  ) AS DECIMAL(5,2))   AS w5p_vorb
        , CAST( LEAST( IFNULL(DIV0( w6p_vorb_stuck, anfangsbestand ),'0.00'), '999.99'  ) AS DECIMAL(5,2))   AS w6p_vorb
        , CAST( LEAST( IFNULL(DIV0( w7p_vorb_stuck, anfangsbestand ),'0.00'), '999.99'  ) AS DECIMAL(5,2))   AS w7p_vorb
        , CAST( LEAST( IFNULL(DIV0( w8p_vorb_stuck, anfangsbestand ),'0.00'), '999.99'  ) AS DECIMAL(5,2))   AS w8p_vorb
        , CAST( LEAST( IFNULL(DIV0( w9p_vorb_stuck, anfangsbestand ),'0.00'), '999.99'  ) AS DECIMAL(5,2))   AS w9p_vorb
        , CAST( LEAST( IFNULL(DIV0( w10p_vorb_stuck, anfangsbestand ),'0.00'), '999.99' ) AS DECIMAL(5,2))   AS w10p_vorb      
        , CAST( LEAST( IFNULL(DIV0( w11p_vorb_stuck, anfangsbestand ),'0.00'), '999.99' ) AS DECIMAL(5,2))   AS w11p_vorb  
        , CAST( LEAST( IFNULL(DIV0( w12p_vorb_stuck, anfangsbestand ),'0.00'), '999.99' ) AS DECIMAL(5,2))   AS w12p_vorb   
        , CAST( LEAST( IFNULL(DIV0( w18p_vorb_stuck, anfangsbestand ),'0.00'), '999.99' ) AS DECIMAL(5,2))   AS w18p_vorb   
        , CAST( LEAST( IFNULL(DIV0( w20p_vorb_stuck, anfangsbestand ),'0.00'), '999.99' ) AS DECIMAL(5,2))   AS w20p_vorb   
        , CAST( LEAST( IFNULL(DIV0( w26p_vorb_stuck, anfangsbestand ),'0.00'), '999.99' ) AS DECIMAL(5,2))   AS w26p_vorb   
        , CAST( LEAST( IFNULL(DIV0( w52p_vorb_stuck, anfangsbestand ),'0.00'), '999.99' ) AS DECIMAL(5,2))   AS w52p_vorb
        , CAST(t1_vorb_stuck   AS DECIMAL(20,0))                                                    AS t1_vorb_stuck   
        , CAST(t3_vorb_stuck   AS DECIMAL(20,0))                                                    AS t3_vorb_stuck
        , CAST(t7_vorb_stuck   AS DECIMAL(20,0))                                                    AS t7_vorb_stuck
        , CAST(t1p_vorb_stuck  AS DECIMAL(20,0))                                                    AS t1p_vorb_stuck
        , CAST(t3p_vorb_stuck  AS DECIMAL(20,0))                                                    AS t3p_vorb_stuck
        , CAST(t7p_vorb_stuck  AS DECIMAL(20,0))                                                    AS t7p_vorb_stuck
        , CAST(w2p_vorb_stuck  AS DECIMAL(20,0))                                                    AS w2p_vorb_stuck
        , CAST(w3p_vorb_stuck  AS DECIMAL(20,0))                                                    AS w3p_vorb_stuck
        , CAST(w4p_vorb_stuck  AS DECIMAL(20,0))                                                    AS w4p_vorb_stuck
        , CAST(w5p_vorb_stuck  AS DECIMAL(20,0))                                                    AS w5p_vorb_stuck
        , CAST(w6p_vorb_stuck  AS DECIMAL(20,0))                                                    AS w6p_vorb_stuck
        , CAST(w7p_vorb_stuck  AS DECIMAL(20,0))                                                    AS w7p_vorb_stuck
        , CAST(w8p_vorb_stuck  AS DECIMAL(20,0))                                                    AS w8p_vorb_stuck
        , CAST(w9p_vorb_stuck  AS DECIMAL(20,0))                                                    AS w9p_vorb_stuck
        , CAST(w10p_vorb_stuck AS DECIMAL(20,0))                                                    AS w10p_vorb_stuck
        , CAST(w11p_vorb_stuck AS DECIMAL(20,0))                                                    AS w11p_vorb_stuck    
        , CAST(w12p_vorb_stuck AS DECIMAL(20,0))                                                    AS w12p_vorb_stuck    
        , CAST(w18p_vorb_stuck AS DECIMAL(20,0))                                                    AS w18p_vorb_stuck    
        , CAST(w20p_vorb_stuck AS DECIMAL(20,0))                                                    AS w20p_vorb_stuck    
        , CAST(w26p_vorb_stuck AS DECIMAL(20,0))                                                    AS w26p_vorb_stuck    
        , CAST(w52p_vorb_stuck AS DECIMAL(20,0))                                                    AS w52p_vorb_stuck    
    FROM
        tmp_etl_prod_qty_v2
),   

    --------------------------------------------------------------
    --    2. Generate Sales Orders data per prod_sid
    --------------------------------------------------------------

total_prod_sales AS
(
    SELECT  
        prod_sid                                                                                AS prod_sid
        , prod_nr                                                                               AS prod_nr
        , wshop_cd                                                                              AS wshop_cd
        , curr_cd                                                                               AS curr_cd
        , SUM(prod_qty)                                                                         AS total_prod_qty
        , SUM(prod_price_gross_local_val)                                                       AS total_prod_price_gross_local_val
        , SUM(prod_price_gross_eur)                                                             AS total_prod_price_gross_eur
        , CAST(div0(total_prod_price_gross_local_val, total_prod_qty) AS DECIMAL (38,2))        AS avg_vkp_local_val            -- "Durchschnittlicher VK IN Landeswährung (brutto)"
        , CAST(div0(total_prod_price_gross_eur, total_prod_qty) AS DECIMAL (38,2))              AS avg_vkp_eur                  -- "Durchschnittlicher VK IN Eur (brutto)" 
        , COUNT(DISTINCT cust_order_sid)                                                        AS count_cust_order 
        , MAX(cust_order_dt)                                                                    AS max_cust_order_dt
        , MIN(cust_order_dt)                                                                    AS min_cust_order_dt
        , CAST(SUM(prod_qty) / (COUNT(DISTINCT cust_order_sid)) AS DECIMAL (38,2))              AS avg_menge_je_bestellung      -- "AVG Menge je Bestellung"
        , CAST(SUM(prod_price_gross_eur)/(COUNT(DISTINCT cust_order_sid)) AS DECIMAL (38,2))    AS avg_warenkorbwert            -- "AVG Warenkorbwert"
    FROM    
        Kundenauftrag
    GROUP BY
        prod_sid
        , prod_nr
        , wshop_cd
        , curr_cd
),

--------------------------------------------------------------
--    11. Join all data IN a Final view
-------------------------------------------------------------- 

tmp_etl_kennzahlendatei AS
(
    SELECT 
        CONCAT('"""', 'OS', t1.OS, '"""')               AS "Land"
        , t1.KopfArtNr                                  AS "KopfArtNr"
        , t1.IAN                                        AS "IAN"
        , CONCAT('"""', UPPER(t1.Werbeimpuls), '"""')   AS "ArtikelArt."
        , to_varchar(t1.Verkaufsstart, 'DD.MM.YYYY')    AS "Verkaufsstart(Werbetermin)"
        , t1.Anfangsbestand                             AS "Anfangsbestand"  
        , t6.max_ekp                                    AS "EK Max"
        , IFNULL(t2.AVG_vkp_eur,0)                      AS "Durchschnittlicher VK IN € (brutto)"
        , t1.AKP_brutto_local_val                       AS "Aktions-VK IN Landeswährung (brutto)"
        , IFNULL(t5.vkp_price_gross_eur_val,'0.00')     AS "aktueller VK IN € (brutto)"
        , IFNULL(t2.AVG_vkp_local_val,0)                AS "Durchschnittlicher VK IN Landeswährung (brutto)"
        , IFNULL(t5.vkp_price_gross_local_val,'0.00')   AS "aktueller VK IN Landeswährung (brutto)"
        , CONCAT('"""',IFNULL(t1.curr_cd,''),'"""')     AS "Belegwährung" 
        , IFNULL(t1.t1_vorb,'0.00')                     AS "1 T Vorb"     
        , IFNULL(t1.t3_vorb,'0.00')                     AS "3 T Vorb"
        , IFNULL(t1.t7_vorb,'0.00')                     AS "7 T Vorb"
        , IFNULL(t1.t1p_vorb,'0.00')                    AS "1T + Vorb" 
        , IFNULL(t1.t3p_vorb,'0.00')                    AS "3 T + Vorb"
        , IFNULL(t1.t7p_vorb,'0.00')                    AS "7 T + Vorb"
        , IFNULL(t1.w2p_vorb,'0.00')                    AS "2 W + Vorb"
        , IFNULL(t1.w3p_vorb,'0.00')                    AS "3 W + Vorb"
        , IFNULL(t1.w4p_vorb,'0.00')                    AS "4 W + Vorb"
        , IFNULL(t1.w5p_vorb,'0.00')                    AS "5 W + Vorb"
        , IFNULL(t1.w6p_vorb,'0.00')                    AS "6 W + Vorb"
        , IFNULL(t1.w7p_vorb,'0.00')                    AS "7 W + Vorb"
        , IFNULL(t1.w8p_vorb,'0.00')                    AS "8 W + Vorb"
        , IFNULL(t1.w9p_vorb,'0.00')                    AS "9 W + Vorb"
        , IFNULL(t1.w10p_vorb,'0.00')                   AS "10 W + Vorb"      
        , IFNULL(t1.w11p_vorb,'0.00')                   AS "11 W + Vorb"  
        , IFNULL(t1.w12p_vorb,'0.00')                   AS "12 W + Vorb"   
        , IFNULL(t1.w18p_vorb,'0.00')                   AS "18 W + Vorb"   
        , IFNULL(t1.w20p_vorb,'0.00')                   AS "20 W + Vorb"   
        , IFNULL(t1.w26p_vorb,'0.00')                   AS "26 W + Vorb"   
        , IFNULL(t1.w52p_vorb,'0.00')                   AS "52 W + Vorb"
        , IFNULL(t1.t1_vorb_stuck,'0')                  AS "1 T Vorb IN Stk"                                
        , IFNULL(t1.t3_vorb_stuck,'0')                  AS "3 T Vorb IN Stk"
        , IFNULL(t1.t7_vorb_stuck,'0')                  AS "7 T Vorb IN Stk"
        , IFNULL(t1.t1p_vorb_stuck,'0')                 AS "1 T + Vorb IN Stk"
        , IFNULL(t1.t3p_vorb_stuck,'0')                 AS "3 T + Vorb IN Stk" 
        , IFNULL(t1.t7p_vorb_stuck,'0')                 AS "7 T + Vorb IN Stk" 
        , IFNULL(t1.w2p_vorb_stuck,'0')                 AS "2 W + Vorb IN Stk" 
        , IFNULL(t1.w3p_vorb_stuck,'0')                 AS "3 W + Vorb IN Stk"
        , IFNULL(t1.w4p_vorb_stuck,'0')                 AS "4 W + Vorb IN Stk"
        , IFNULL(t1.w5p_vorb_stuck,'0')                 AS "5 W + Vorb IN Stk"
        , IFNULL(t1.w6p_vorb_stuck,'0')                 AS "6 W + Vorb IN Stk"
        , IFNULL(t1.w7p_vorb_stuck,'0')                 AS "7 W + Vorb IN Stk"
        , IFNULL(t1.w8p_vorb_stuck,'0')                 AS "8 W + Vorb IN Stk"
        , IFNULL(t1.w9p_vorb_stuck,'0')                 AS "9 W + Vorb IN Stk"
        , IFNULL(t1.w10p_vorb_stuck,'0')                AS "10 W + Vorb IN Stk" 
        , IFNULL(t1.w11p_vorb_stuck,'0')                AS "11 W + Vorb IN Stk"
        , IFNULL(t1.w12p_vorb_stuck,'0')                AS "12 W + Vorb IN Stk"
        , IFNULL(t1.w18p_vorb_stuck,'0')                AS "18 W + Vorb IN Stk"
        , IFNULL(t1.w20p_vorb_stuck,'0')                AS "20 W + Vorb IN Stk"
        , IFNULL(t1.w26p_vorb_stuck,'0')                AS "26 W + Vorb IN Stk"
        , IFNULL(t1.w52p_vorb_stuck,'0')                AS "52 W + Vorb IN Stk" 
        , IFNULL(CAST((t3.total_returns/t2.total_prod_qty)*100 AS DECIMAL (38,2)), 0)   AS "Retourenquote"
        , IFNULL(t7.globaler_bestand, 0)                AS "Globaler Bestand"
        , IFNULL(t7.allokierter_bestand, 0)             AS "Allokierter Bestand je OS"
        , IFNULL(t7.atp_bestand, 0)                     AS "ATP Bestand" 
        , IFNULL(t2.AVG_menge_je_bestellung, 0)         AS "∅ Menge je Bestellung"
        , IFNULL(CAST(t7.atp_bestand / (( t2.total_prod_qty / (( t2.max_cust_order_dt - t2.min_cust_order_dt) +1 ))*7 ) AS DECIMAL (38,0)), 0)  AS "Reichweite"
        , '0.00'                                        AS "% EPO"
        , IFNULL(t2.AVG_warenkorbwert, 0)               AS "∅ Warenkorbwert"
        , '0'                                           AS "Bestellmenge Mutterland"
        , '""""""'                                      AS "TV Mutterland"
        , '""""""'                                      AS "Region Mutterland"
        , t1.Abverkaufshorizont                         AS "Abverkaufshorizont"
        , IFNULL(t7.sperrbestand, 0)                    AS "Sperrbestand"             
        , '0'                                           AS "Venlo Dispo"
        , '0'                                           AS "Venlo Nachdispo"
        , CAST( t1.AKP_brutto_local_val / t4.exchange_rate AS DECIMAL (38,2)) AS "Aktions-VK IN € brutto" 
        , ''                                            AS "Dummywert2"                                           
        , ''                                            AS "Dummywert3"
        , ''                                            AS "Dummywert4"
        , ''                                            AS "Dummywert5"
        , ''                                            AS "Dummywert6"
    FROM
        prod_qty_final                          AS t1
    LEFT JOIN
        total_prod_sales                        AS t2
      ON  
            t1.OS = t2.wshop_cd
        AND t1.KopfArtNr = t2.prod_nr
    LEFT JOIN
        retouren                                AS t3
      ON  
            t1.OS = t3.wshop_cd
        AND t1.KopfArtNr = t3.prod_nr
    LEFT JOIN
        core.t_fact_currency_exchange_rate      AS t4
      ON 
            t1.curr_cd = t4.from_curr_cd
        AND t4.curr_exchange_rate_type_cd = 'F'
        AND t1.Verkaufsstart BETWEEN t4.active_from_dt AND t4.active_to_dt  
    LEFT JOIN
        aktueller_vkp                           AS t5
      ON 
            t1.OS = t5.wshop_cd
        AND t1.KopfArtNr = t5.prod_nr
    LEFT JOIN
        einkaufspreis                           AS t6
      ON 
            t1.OS = t6.wshop_cd
        AND t1.KopfArtNr = t6.prod_nr  
    LEFT JOIN
        stock_daily                             AS t7
      ON
            t1.OS = t7.wshop_cd
        AND t1.KopfArtNr = t7.prod_nr
)

-- END WITH

-----------------------------------------------------------
--    11. FINAL QUERY (+ add Austria/Denmark/Hungary data)
-----------------------------------------------------------

SELECT
    t1.*
FROM
    tmp_etl_kennzahlendatei     AS t1

    UNION       -- Generate "fake" data for AT, DK, HU, FR (based on DE data)

SELECT
      t3.Land_new                                                                                       AS "Land"
    , t2."KopfArtNr"
    , t2."IAN"
    , t2."ArtikelArt."
    , t2."Verkaufsstart(Werbetermin)"
    , t2."Anfangsbestand"  
    , t2."EK Max"
    , t2."Durchschnittlicher VK IN € (brutto)"
    , CAST(t2."Aktions-VK IN Landeswährung (brutto)"*t5.exchange_rate AS DECIMAL (38,2))                AS "Aktions-VK IN Landeswährung (brutto)"
    , t2."aktueller VK IN € (brutto)"                  
    , CAST(t2."Durchschnittlicher VK IN Landeswährung (brutto)"*t5.exchange_rate AS DECIMAL (38,2))     AS "Durchschnittlicher VK IN Landeswährung (brutto)"
    , CAST("aktueller VK IN Landeswährung (brutto)"*t5.exchange_rate AS DECIMAL (38,2))                 AS "aktueller VK IN Landeswährung (brutto)"      
    , CONCAT('"""',IFNULL(t4.curr_cd,''),'"""')                                                         AS "Belegwährung"
    , t2."1 T Vorb"     
    , t2."3 T Vorb"
    , t2."7 T Vorb"
    , t2."1T + Vorb" 
    , t2."3 T + Vorb"
    , t2."7 T + Vorb"
    , t2."2 W + Vorb"
    , t2."3 W + Vorb"
    , t2."4 W + Vorb"
    , t2."5 W + Vorb"
    , t2."6 W + Vorb"
    , t2."7 W + Vorb"   
    , t2."8 W + Vorb"
    , t2."9 W + Vorb"
    , t2."10 W + Vorb"      
    , t2."11 W + Vorb"  
    , t2."12 W + Vorb"   
    , t2."18 W + Vorb"   
    , t2."20 W + Vorb"   
    , t2."26 W + Vorb"   
    , t2."52 W + Vorb"
    , t2."1 T Vorb IN Stk"                                
    , t2."3 T Vorb IN Stk"
    , t2."7 T Vorb IN Stk"
    , t2."1 T + Vorb IN Stk"
    , t2."3 T + Vorb IN Stk" 
    , t2."7 T + Vorb IN Stk" 
    , t2."2 W + Vorb IN Stk" 
    , t2."3 W + Vorb IN Stk"
    , t2."4 W + Vorb IN Stk"
    , t2."5 W + Vorb IN Stk"
    , t2."6 W + Vorb IN Stk"
    , t2."7 W + Vorb IN Stk"
    , t2."8 W + Vorb IN Stk"
    , t2."9 W + Vorb IN Stk"
    , t2."10 W + Vorb IN Stk" 
    , t2."11 W + Vorb IN Stk"
    , t2."12 W + Vorb IN Stk"
    , t2."18 W + Vorb IN Stk"
    , t2."20 W + Vorb IN Stk"
    , t2."26 W + Vorb IN Stk"
    , t2."52 W + Vorb IN Stk" 
    , t2."Retourenquote"
    , t2."Globaler Bestand"            
    , t2."Allokierter Bestand je OS"  
    , t2."ATP Bestand"                 
    , t2."∅ Menge je Bestellung"
    , t2."Reichweite"                  
    , t2."% EPO"
    , t2."∅ Warenkorbwert"
    , t2."Bestellmenge Mutterland"
    , t2."TV Mutterland"
    , t2."Region Mutterland"
    , t2."Abverkaufshorizont"
    , t2."Sperrbestand"                
    , t2."Venlo Dispo"
    , t2."Venlo Nachdispo"
    , t2."Aktions-VK IN € brutto"
    , t2."Dummywert2"    
    , t2."Dummywert3"
    , t2."Dummywert4"
    , t2."Dummywert5"
    , t2."Dummywert6"
FROM
    tmp_etl_kennzahlendatei                         AS t2
RIGHT OUTER JOIN
    (VALUES ('"""OSAT"""'), ('"""OSDK"""'), ('"""OSHU"""'), ('"""OSFR"""'))     AS t3 (land_new)
  ON 
    t2.Land = '"""OSDE"""'
LEFT JOIN 
    tmp_etl_currency_country                        AS t4
  ON 
    LEFT(split_part( t3.Land_new, 'OS', -1), 2) = t4.wshop_cd 
LEFT JOIN 
    core.t_fact_currency_exchange_rate              AS t5
  ON 
        t4.curr_cd = t5.from_curr_cd
    AND t5.curr_exchange_rate_type_cd = 'F'
    AND t5.active_fg = 1
)
;
CREATE OR REPLACE VIEW TRANSFER.V_AMP_EXPORT_ABVERKAUFSQUOTEN AS
(
    
-- START WITH (definition of support CTEs)
    
    WITH

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
        
        , CASE WHEN CONTAINS(UPPER(reg_prod_variant_descr), 'FARBE:') 
            THEN concat('"""', LEFT(RTRIM(split_part(UPPER(reg_prod_variant_descr), 'FARBE:', -1)), 44), '"""')          
                ELSE (CASE WHEN CONTAINS(UPPER(reg_prod_variant_descr), 'ART:') 
                        THEN concat('"""', LEFT(RTRIM(split_part(UPPER(reg_prod_variant_descr), 'ART:', -1)), 44), '"""')
                            ELSE NULL 
                    END) 
          END               AS STYLE_AMP
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
        concat( t1.wshop_cd, t1.prod_sid, t1.promo_dt )                     AS PK
        , concat( t1.wshop_cd, t1.prod_sid )                                AS Artikel_OS
        , t1.wshop_cd                                                       AS OS
        , t1.prod_sid                                                       AS prod_sid
        , t2.prod_nr                                                        AS KopfArtNr
        , IFF(TRY_TO_DECIMAL(t2.ian_nr) IS NULL, t2.prod_nr, t2.ian_nr)     AS Lidlnummer    -- Replace numbers with non-numerical characters
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
        Verkaufsstart >= add_months(date_trunc('month', CURRENT_DATE()), -6)
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
            cust_order_dt >= add_months(date_trunc('month', CURRENT_DATE()), -6)      -- Date filter: only grab facts from the last 6 months
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
        , CAST(t1.delivery_cost_gross_local_val AS DECIMAL(38,5))                   AS delivery_cost_gross_local_val  
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

    -------------------------------------------------------------------
    --    1. tmp_etl_abverkaufsquoten_1 (Aktionsplanmengen) (DIM side)
    -------------------------------------------------------------------

tmp_etl_abverkaufsquoten_1 AS
(
    SELECT DISTINCT                                     -- DISTINCT is important, to group similar styles together per IAN (= per KopfArtikel)
        concat( OS, IAN, STYLE)     AS join_key_tmp
        , *
    FROM
    (
        SELECT    
            concat('"""', 'OS', t1.OS, '"""')                   AS Land
            , OS                                                AS OS
            , ifnull(t1.Lidlnummer, t1.KopfArtNr)               AS IAN
            , to_varchar(t1.Verkaufsstart, 'DD.MM.YYYY')        AS "Verkaufsstart(Werbetermin)"
            , ifnull(t2.STYLE_AMP, '""""""')                    AS STYLE
        FROM 
            Aktionsplanmengen   AS t1  
        LEFT JOIN
            Artikel             AS t2
          ON 
            t1.prod_sid = t2.prod_sid                  -- Multiplies the data ( 1<n relationship)
    )
),

----------------------------------------------------------------
--    2. tmp_etl_abverkaufsquoten_2 (Kundenauftrag) (FACT side)
----------------------------------------------------------------

    ---------------------------------------------------------------------------------------
    --    STEP 1: Aggr of sales orders quantities (per wshop and prod_variant) + join prep
    ---------------------------------------------------------------------------------------

tmp_etl_kundenauftrag AS
(
    SELECT
        concat(wshop_cd, prod_variant_sid)      AS join_key_tmp
        , wshop_cd                              AS wshop_cd
        , prod_variant_sid                      AS prod_variant_sid
        , SUM( prod_qty )                       AS bestellmenge
    FROM
        Kundenauftrag
    GROUP BY
        wshop_cd
        , prod_variant_sid
),

    ----------------------------------------------
    --    STEP 2: Artikel master data + join prep
    ----------------------------------------------

tmp_etl_artikel AS
(
    SELECT
        concat(wshop_cd, prod_variant_sid)      AS join_key_tmp
        , wshop_cd                              AS wshop_cd
        , prod_variant_sid                      AS prod_variant_sid
        , ifnull(ian_nr, prod_nr)               AS IAN
        , ifnull(STYLE_amp, '""""""')           AS STYLE
    FROM 
        artikel
),

    ----------------------------------------
     --   STEP 3: Join together Steps 1 & 2
    ----------------------------------------

tmp_etl_kundenauftrag_aggr AS
(
    SELECT
        t1.wshop_cd                     AS wshop_cd
        , t1.ian                        AS ian
        , t1.prod_variant_sid           AS prod_variant_sid
        , t1.STYLE                      AS STYLE
        , ifnull(t2.bestellmenge, 0)    AS bestellmenge
    FROM
        tmp_etl_artikel         AS t1
    LEFT JOIN
        tmp_etl_kundenauftrag   AS t2
      ON 
        t1.join_key_tmp = t2.join_key_tmp
),

    ---------------------------------------------
     --   STEP 4: Aggr of sales orders quantites
    ---------------------------------------------

tmp_etl_abverkaufsquoten_2 AS
(
    SELECT 
        concat(wshop_cd, ian, STYLE)                                    AS join_key_tmp    
        , wshop_cd                                                      AS wshop_cd
        , ian                                                           AS ian
        , STYLE                                                         AS STYLE
        , bestellmenge_aggr                                             AS bestellmenge_aggr
        , SUM(bestellmenge_aggr) OVER (PARTITION BY wshop_cd, ian)      AS bestellmenge_total
    FROM
        (
            SELECT
                wshop_cd
                , ian
                , STYLE
                , SUM(bestellmenge) AS bestellmenge_aggr
            FROM
                tmp_etl_kundenauftrag_aggr
            GROUP BY
                wshop_cd
                , ian
                , STYLE
        )
),

--------------------------------------------------------------
--    3. Join tmp_etl_abverkaufsquoten_1 (DIM) and _2 (FACTS)
--------------------------------------------------------------


tmp_etl_abverkaufsquoten_3 AS            
(
    SELECT
        t1.Land                                                             AS Land
        , t1.IAN                                                            AS IAN
        , t1."Verkaufsstart(Werbetermin)"                                   AS "Verkaufsstart(Werbetermin)"
        , t1.STYLE                                                          AS STYLE
        , ROUND(div0(t2.Bestellmenge_aggr, t2.Bestellmenge_total)*100, 2)   AS Wert
    FROM
        tmp_etl_abverkaufsquoten_1      AS t1
    LEFT JOIN
        tmp_etl_abverkaufsquoten_2      AS t2
      ON
        t1.join_key_tmp = t2.join_key_tmp  
)

-- END WITH
    
-----------------------------------------------------------------
--    4. FINAL QUERY (+ add Austria/Denmark/Hungary/France data)
-----------------------------------------------------------------
    
SELECT
    t1.*
FROM
    tmp_etl_abverkaufsquoten_3  AS t1
    
    UNION           -- Generate "fake" data for AT, DK, HU, FR (based on DE data)

(SELECT
    t3.Land_new                         AS Land
    , t2.IAN                            AS IAN
    , t2."Verkaufsstart(Werbetermin)"   AS "Verkaufsstart(Werbetermin)"
    , t2.STYLE                          AS STYLE
    , CAST(t2.Wert AS DECIMAL(5,2))     AS Wert
FROM
    tmp_etl_abverkaufsquoten_3  AS t2
RIGHT OUTER JOIN
    (VALUES ('"""OSAT"""'), ('"""OSDK"""'), ('"""OSHU"""'), ('"""OSFR"""')) AS t3 (Land_new)
  ON 
    t2.Land = '"""OSDE"""') 
)
;
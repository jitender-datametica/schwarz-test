CREATE OR REPLACE VIEW FE_MSTR_NFMD.MV_FRONTEND_ID40_WB_2 AS
(
SELECT wbv.MANDANT_ID,
       sc.LAND_ID,
       wbv.YEAR_ID,
       wbv.WEEK_ID,
       wbv.KJWO,
       wbv.AKTION_ID,
       sc.AKTION_DAT_VON,
       sc.VK_AKTION_BRUTTO,
       sc.CURRENCY,
       sc.PROMO_STORES,
       wbv.WUP_ID,
       REGEXP_REPLACE(sc.WUP_NAME, 'Kaufland ', '')                               AS WUP_NAME,
       sc.WUP_CLUSTER,
       COALESCE(sc.WUP_REGION::VARCHAR(10), 'Missing')                             AS WUP_REGION,
       wbv.SKU_ID,
       wbv.kl_art_id,
       sc.ART_NAME                                                                AS SKU_NAME,
       sc.HWG_BEZ,
       sc.OWG_BEZ,
       sc.WG_BEZ,
       sc.WUG_BEZ,
       sc.STOCK_INITIAL,
       sc.SALES_PROMO_WEEK,
       sc.SELL_RATIO_PROMO_WEEK,
       sc.SALES_TOTAL,
       sc.SELL_RATIO_CURRENT,
       sc.REMAINING_STOCK,
       sc.CURRENT_DISCOUNT,
       sc.CURRENT_WEEK,
       sc.REMAINING_WEEKS,
       sc.MD_PRICE_OPT                                                            AS SRC_MD_PRICE_OPT,      -- Source MD PRICE OPT
       wbv.SAP_TRANSFER_DATE,
       wbv.PREVIOUS_SUBMITTED_VALID_FROM,
       wbv.SUBMITTED_DATE,
       -- Calculate the total remaining value of products accross store
       sc.VK_AKTION_BRUTTO * sc.REMAINING_STOCK                                   AS ART_WARENWERT,

       --- Hilfspalten - damit nicht zweimal das gleiche case when geschreiben werden muss
       CASE
           -- Rules to enforce minimum price and prevent discounts for no stock
           WHEN (wbv.VALID_FROM < DATEADD(DAY, prms.NO_TOUCH_TIME, sc.AKTION_DAT_VON)
               OR ART_WARENWERT <= prms.MIN_VALUE
               OR sc.REMAINING_STOCK = 0
               OR wbv.NB_OF_MARKDOWNS >= prms.DISCOUNT_COUNT)
               THEN COALESCE(wbv.previous_submitted_price, VK_AKTION_BRUTTO)
           -- Discount steps rule
           WHEN sc.MD_PRICE_OPT >= ROUND(wbv.previous_submitted_price * (1 - (prms.DISCOUNT_STEPS / 100)), 2)
                OR (sc.MD_PRICE_OPT IS NULL AND wbv.previous_submitted_price IS NOT NULL )
                -- submitted price - discount higher than the max. discount 
                OR ( wbv.previous_submitted_price <= ROUND( sc.VK_AKTION_BRUTTO * (1 - (prms.MAX_DISCOUNT/ 100)),2) ) 
                  --- submitted price - discount lower than the min. discount and md price - discount lower than the min. discount 
                OR (wbv.previous_submitted_price >= ROUND(sc.VK_AKTION_BRUTTO * (1 - (prms.MIN_DISCOUNT/ 100)),2) AND sc.MD_PRICE_OPT >= ROUND(sc.VK_AKTION_BRUTTO * (1 - (prms.MIN_DISCOUNT/ 100)),2) ) 
               THEN wbv.previous_submitted_price
          /* -- Rule to restrict number of markdowns possible herausnehmen, da dies keinen Sinn ergibt Abstand nur zwischen Rabatten
           WHEN sc.MD_PRICE_OPT >= ROUND(sc.VK_AKTION_BRUTTO * (1 - (prms.DISCOUNT_STEPS / 100)), 2)
               THEN sc.VK_AKTION_BRUTTO*/
           -- Rule to restrict highest discount possible
           WHEN (sc.MD_PRICE_OPT IS NULL
               OR sc.MD_PRICE_OPT > (sc.VK_AKTION_BRUTTO * ( 1 - (prms.MIN_DISCOUNT / 100) ) ) ) 
               THEN sc.VK_AKTION_BRUTTO
           -- Rule to restrict lowest discount possible
           WHEN sc.MD_PRICE_OPT <= sc.VK_AKTION_BRUTTO * ( 1 - (CASE
                                              WHEN sc.VK_AKTION_BRUTTO >= prms.PRICE_THRESHOLD_FOR_MAX_DISCOUNT
                                                  THEN prms.MAX_DISCOUNT_FOR_MAX_PRICE
                                              ELSE prms.MAX_DISCOUNT END/
                                          100))
           
               THEN sc.VK_AKTION_BRUTTO * ( 1 - (CASE
                                              WHEN sc.VK_AKTION_BRUTTO >= prms.PRICE_THRESHOLD_FOR_MAX_DISCOUNT
                                                  THEN prms.MAX_DISCOUNT_FOR_MAX_PRICE
                                              ELSE prms.MAX_DISCOUNT END /
                                          100))
           
           ELSE sc.MD_PRICE_OPT
           END                                                                    AS helper_md_price,
       CASE 
       -- Hier einiges rausgenommen da dies aus unserer Sicht nicht notwendig ist 
       --- Manueller VK_2 sollte alles moeglich sein, dies soll nur anhand der Hintergrundfarben im Frontend gezeigt werden 
          /* -- Discount steps rule
           WHEN last_manual_price >= ROUND(wbv.previous_submitted_price * (1 - (prms.DISCOUNT_STEPS / 100)), 2)
               THEN wbv.previous_submitted_price
           WHEN last_manual_price >= ROUND(sc.VK_AKTION_BRUTTO * (1 - (prms.DISCOUNT_STEPS / 100)), 2)
               THEN helper_md_price
           -- Rule to restrict lowest discount possible
           WHEN sc.MD_PRICE_OPT <= sc.VK_AKTION_BRUTTO * (prms.MIN_DISCOUNT / 100)
               THEN sc.VK_AKTION_BRUTTO * (prms.MIN_DISCOUNT / 100)*/
           WHEN (ART_WARENWERT <= prms.MIN_VALUE OR sc.REMAINING_STOCK = 0 OR
                 wbv.NB_OF_MARKDOWNS >= prms.DISCOUNT_COUNT) THEN
               COALESCE(wbv.previous_submitted_price, VK_AKTION_BRUTTO)
           WHEN last_manual_price IS NOT NULL AND  last_manual_price <= COALESCE(wbv.previous_submitted_price, VK_AKTION_BRUTTO)
                THEN last_manual_price
           ELSE helper_md_price END                  AS helper_manual_price,
       ----------------------------------------------
       CASE
           WHEN VK_AKTION_BRUTTO > 0
               THEN ROUND(1 - (helper_md_price / VK_AKTION_BRUTTO), 4) END        AS MD_DISCOUNT_OPT,
       ROUND(helper_md_price, CASE
                                  WHEN VK_AKTION_BRUTTO >= prms.PRICE_ENDING_THRESHOLD
                                      AND VK_AKTION_BRUTTO <> ROUND(helper_md_price, 0) THEN 0
                                  ELSE 2 END)                                     AS MD_PRICE_OPT,          -- Rule for price endings
       sc.MD_CONFIDENCE,
       sc.MODEL_DATE,
       sc.MODEL_ID,
       sc.PARAMETER_CONFIG,
       sc.CLUSTER_CONFIG,
       CASE
           WHEN VK_AKTION_BRUTTO > 0
               THEN ROUND(1 - (helper_manual_price / sc.VK_AKTION_BRUTTO), 2) END AS manual_markdown_percentage,
       ROUND(helper_manual_price, CASE
                                      WHEN VK_AKTION_BRUTTO >= prms.PRICE_ENDING_THRESHOLD AND
                                           VK_AKTION_BRUTTO > ROUND(helper_manual_price, 0) THEN 0
                                      ELSE 2 END)                                 AS manual_markdown_price, -- Rule for price endings
       wbv.valid_from,
       wbv.manual_comment,
       wbv.jf_submitted,
       wbv.id40_submitted_price,
       purchasing_price,                                                                                    -- this column stays empty until handover with client
       rohertrag,                                                                                           -- this column stays empty until handover with client
       wbv.previous_submitted_price,
       wbv.nb_of_markdowns                                                        AS nb_of_markdown,
       wbv.first_day_of_cw,
       wbv.promotion_week_x_weeks_ago,
       wbv.region_2,
       wbv.WERBEMUTTER,
       sc.WG_ID                                                                   AS WARENGRUPPE_ID,
       sc.SALES_LAST_WEEK,
       sc.CURRENT_REVENUE,
       CAST(NULL AS TIMESTAMP)                                                    AS MODEL_RUN_TIME,
       CASE
           WHEN wbv.last_manual_price IS NULL
               AND wbv.last_manual_price IS NULL THEN 'Model Recommendation'
           ELSE 'Manual Input'
           END                                                                    AS MANUAL_INPUT_INDICATOR,
       CASE
           WHEN manual_markdown_percentage > 0
               THEN COUNT(sc.WUP_ID) OVER (PARTITION BY sc.LAND_ID , sc.CALENDAR_YEAR, sc.CALENDAR_WEEK,
               sc.AKTION_ID, sc.ART_ID)
           ELSE 0 END                                                             AS STORES_WITH_DISCOUNTS,
       last_manual_updated_date,
       wbv.ARTICLE_CLUSTER,
       prms.DISCOUNT_ENDING             -- used to determine which columns are editable 
FROM FE_MSTR_NFMD.MV_LATEST_FE_WB_2 wbv -- view of lookup tables and MicroStrategy writeback data 
         LEFT JOIN FE_MSTR_NFMD.MV_HADOOP_PARAMETERS_2 prms
                   ON wbv.mandant_id = prms.mandant_id
         JOIN CORE.SRC_HDP_FRONTEND_SCREEN_SCORECARD_2 sc -- source model table
              ON sc.mandant_id = wbv.mandant_id AND
                 sc.CALENDAR_YEAR = wbv.YEAR_ID AND
                 sc.CALENDAR_WEEK = wbv.WEEK_ID AND
                 sc.AKTION_ID = wbv.AKTION_ID AND
                 sc.ART_ID = wbv.SKU_ID AND
                 sc.WUP_ID = wbv.WUP_ID
     -- Nur die Testmaerkte
        WHERE SC.WUP_ID IN (1360,1430,1480,1493,1500,1530,1580,1600,1633,1863,2160,2170,2370,2440,2590,2640,2700,2900,3040,3080,3280,3470,3520,3560,3690,4200,4250,4350,4370,4410,4550,4620,5050,5380,5590,5620,6000,6580,8610)
    );
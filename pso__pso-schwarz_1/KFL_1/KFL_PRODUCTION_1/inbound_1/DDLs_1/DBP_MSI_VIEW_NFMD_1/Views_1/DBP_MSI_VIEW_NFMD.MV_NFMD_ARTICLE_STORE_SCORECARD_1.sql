CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_NFMD_ARTICLE_STORE_SCORECARD_1(
	MANDANT_ID,
	KJWO_WW,
	AKTION_ID,
	PROMO_START_DT,
	SELLING_PRICE_GROSS_LOCAL_VAL,
	WRG_ID,
	PROMO_STORES_CNT,
	WUP_ID,
	ART_ID,
	DISCOUNT_TYPE_NAME,
	SECOND_DISCOUNT_START_DT,
	SECOND_DISCOUNT_END_DT,
	WG_ID,
	STOCK_INITIAL_CNT,
	SALES_PROMO_WEEK_CNT,
	PROMO_WEEK_SELL_RATE,
	SELL_RATIO_WK12,
	SELL_RATIO_WK123,
	SALES_TOTAL_CNT,
	CURRENT_SELL_RATE,
	REMAINING_STOCK_CNT,
	CURRENT_DISCOUNT_RATE,
	CURRENT_WEEK_NR,
	REMAINING_WEEKS_CNT,
	REVENUE_LAST_WEEK_GROSS_LOCAL_VAL,
	TOTAL_REVENUE_GROSS_LOCAL_VAL,
	SRC_MODEL_PRICE_GROSS_LOCAL_VAL,
	MODEL_EXECUTION_TMSP,
	ART_WARENWERT,
	SAP_TRANSFER_DATE,
	SUBMITTED_DATE,
	HELPER_LAST_MANUAL,
	LAST_MANUAL_PRICE,
	PREVIOUS_SUBMITTED_VALID_FROM,
	LAST_MANUAL_UPDATED_DATE,
	LAST_MANUAL_VALID_FROM,
	VALID_FROM,
	NB_OF_MARKDOWNS,
	HELPER_MD_PRICE,
	HELPER_MANUAL_PRICE,
	MD_DISCOUNT_OPT,
	MD_PRICE_OPT,
	MANUAL_MARKDOWN_PERCENTAGE,
	MANUAL_MARKDOWN_PRICE,
	MANUAL_COMMENT,
	ID40_SUBMITTED_PRICE,
	PURCHASING_PRICE,
	ROHERTRAG,
	PREVIOUS_SUBMITTED_PRICE,
	ARTICLE_CLUSTER_ID,
	CURVE_TYPE_CD,
	RULE_CREATED_DT,
	IS_IN_EXPERIMENT_FG,
	EXPERIMENT_GROUP_CD,
	EXPERIMENT_STORES_CNT,
	DISPLAY_ART_ID,
	RULE_DECISION_RECORD,
	VK_NETTO,
	UMSATZ_NETTO,
	MANUAL_MARKDOWN_PRICE_NETTO,
    checkbox_zr_default
) AS  
SELECT sc.MANDANT_ID,
       sc.KJWO_WW ,                                                                         
       sc.AKTION_ID,
       sc.PROMO_START_DT, 
       sc.SELLING_PRICE_GROSS_LOCAL_VAL,
       sc.WRG_ID,
       sc.PROMO_STORES_CNT,
       sc.WUP_ID,
       sc.ART_ID,
       sc.DISCOUNT_TYPE_NAME,
       sc.SECOND_DISCOUNT_START_DT,
       sc.SECOND_DISCOUNT_END_DT,
       sc.WG_ID,
       
       sc.STOCK_INITIAL_CNT,
       sc.SALES_PROMO_WEEK_CNT,
       sc.PROMO_WEEK_SELL_RATE,
       sc.sell_ratio_wk12,
       sc.sell_ratio_wk123,
       sc.SALES_TOTAL_CNT,
       sc.CURRENT_SELL_RATE,
       sc.REMAINING_STOCK_CNT,
       sc.CURRENT_DISCOUNT_RATE,
       sc.CURRENT_WEEK_NR,
       sc.REMAINING_WEEKS_CNT,
       sc.REVENUE_LAST_WEEK_GROSS_LOCAL_VAL,
       sc.TOTAL_REVENUE_GROSS_LOCAL_VAL,
       sc.MODEL_PRICE_GROSS_LOCAL_VAL AS SRC_MODEL_PRICE_GROSS_LOCAL_VAL,
       -- NULL AS MODEL_CONFIDENCE,
       sc.MODEL_EXECUTION_TMSP,
       
       sc.SELLING_PRICE_GROSS_LOCAL_VAL * sc.REMAINING_STOCK_CNT AS ART_WARENWERT,

       
       vps.LAST_SAP_TRANSFER_DATE  AS SAP_TRANSFER_DATE,
       vps.SUBMITTED_DATE,
    ----------------------------------------------------------------------------------------------------------
    --------- HELPER - Damit die Case Whens nicht mehrfach wiederholt werden müssen ---------------------------
       --- Check if Manual price on Article or Article-Wup_1  the newest 
        CASE
           WHEN sc.DISCOUNT_TYPE_NAME = 'second_discount' THEN 'ART_WUP_LEVEL'
           WHEN dpc.UPDATED_DATE IS NULL OR dca.UPDATED_DATE > dpc.UPDATED_DATE THEN 'ART_LEVEL'
           WHEN dca.UPDATED_DATE IS NULL OR dca.UPDATED_DATE < dpc.UPDATED_DATE THEN 'ART_WUP_LEVEL'
           ELSE NULL
           END                                                                                  AS helper_last_manual,
       -- letzter Manueller Preis
       CASE WHEN helper_last_manual = 'ART_LEVEL' THEN dca.MANUAL_PRICE_ART
            WHEN helper_last_manual = 'ART_WUP_LEVEL' THEN dpc.MANUAL_PRICE_ART_WUP
            ELSE NULL
       END                                                                                      AS last_manual_price,
       -- Previous_submitted_valid_from only shown if manual_price != selling_price_gross_local_val (Aktueller VK_1)
       CASE
           WHEN ROUND(vps.previous_submitted_price, 2) <> ROUND( sc.SELLING_PRICE_GROSS_LOCAL_VAL, 2) THEN vps.previous_submitted_valid_from
           ELSE NULL 
           END                                                                                      AS previous_submitted_valid_from,
       CASE
           WHEN helper_last_manual = 'ART_LEVEL' THEN dca.UPDATED_DATE
           WHEN helper_last_manual = 'ART_WUP_LEVEL' THEN dpc.UPDATED_DATE
           ELSE NULL
       END                                                                                   AS last_manual_updated_date,
       --- Letztes Gültig ab
       CASE
           WHEN ddc.UPDATED_DATE IS NULL OR dcvf.UPDATED_DATE > ddc.UPDATED_DATE THEN dcvf.MANUAL_PRICE_ART_DAT
           WHEN dcvf.UPDATED_DATE IS NULL OR dcvf.UPDATED_DATE < ddc.UPDATED_DATE THEN ddc.MANUAL_PRICE_ART_WUP_DAT
           ELSE NULL
           END                                                                                   AS last_manual_valid_from,
           
     /* TO CHECK */
       COALESCE(CASE WHEN last_manual_valid_from > CURRENT_DATE() THEN last_manual_valid_from END,
                NEXT_DAY(CURRENT_DATE(), prms.DISCOUNT_DAY_OF_WEEK)) AS valid_from, 
                
       COALESCE(vps.NB_OF_MARKDOWNS, 0)                                                          AS NB_OF_MARKDOWNS,
      /* END TO CHECK */     
       --- Hilfspalten - damit nicht zweimal das gleiche case when geschreiben werden muss
       /*CASE
           -- Rules to enforce minimum price and prevent discounts for no stock
           WHEN (VALID_FROM < DATEADD(DAY, prms.NO_TOUCH_DAYS_CNT, sc.PROMO_START_DT)
               OR ART_WARENWERT <= prms.MIN_PRICE_GROSS_LOCAL_VAL
               OR sc.REMAINING_STOCK_CNT = 0
               --OR NB_OF_MARKDOWNS >= prms.MAX_DISCOUNT_CNT
                )
               THEN COALESCE(vps.previous_submitted_price, sc.SELLING_PRICE_GROSS_LOCAL_VAL)
           -- Discount steps rule
           WHEN sc.MODEL_PRICE_GROSS_LOCAL_VAL >= ROUND(vps.previous_submitted_price * (1 - (prms.DISCOUNT_STEPS / 100)), 2)
                OR (sc.MODEL_PRICE_GROSS_LOCAL_VAL IS NULL AND vps.previous_submitted_price IS NOT NULL )
                -- submitted price - discount higher than the max. discount 
                OR ( vps.previous_submitted_price <= ROUND( sc.SELLING_PRICE_GROSS_LOCAL_VAL * (1 - (prms.MAX_DISCOUNT_PCT/ 100)),2) ) 
                  --- submitted price - discount lower than the min. discount and md price - discount lower than the min. discount 
                OR (vps.previous_submitted_price >= ROUND(sc.SELLING_PRICE_GROSS_LOCAL_VAL * (1 - (prms.MIN_DISCOUNT_PCT/ 100)),2) AND sc.MODEL_PRICE_GROSS_LOCAL_VAL >= ROUND(sc.SELLING_PRICE_GROSS_LOCAL_VAL * (1 - (prms.MIN_DISCOUNT_PCT/ 100)),2) ) 
               THEN vps.previous_submitted_price*/
          /* -- Rule to restrict number of markdowns possible herausnehmen, da dies keinen Sinn ergibt Abstand nur zwischen Rabatten
           WHEN sc.MD_PRICE_OPT >= ROUND(sc.VK_AKTION_BRUTTO * (1 - (prms.DISCOUNT_STEPS / 100)), 2)
               THEN sc.VK_AKTION_BRUTTO*/
           -- Rule to restrict highest discount possible
           /*WHEN (sc.MODEL_PRICE_GROSS_LOCAL_VAL IS NULL
               OR sc.MODEL_PRICE_GROSS_LOCAL_VAL > (sc.SELLING_PRICE_GROSS_LOCAL_VAL * ( 1 - (prms.MIN_DISCOUNT_PCT / 100) ) ) ) 
               THEN sc.SELLING_PRICE_GROSS_LOCAL_VAL
           -- Rule to restrict lowest discount possible
           WHEN sc.MODEL_PRICE_GROSS_LOCAL_VAL <= sc.SELLING_PRICE_GROSS_LOCAL_VAL * ( 1 - (CASE
                                              WHEN sc.SELLING_PRICE_GROSS_LOCAL_VAL >= prms.MAX_PRICE_FOR_MAX_DISCOUNT
                                                  THEN prms.MAX_DISCOUNT_FOR_MAX_PRICE_PCT
                                              ELSE prms.MAX_DISCOUNT_PCT END/
                                          100))
           
               THEN sc.SELLING_PRICE_GROSS_LOCAL_VAL * ( 1 - (CASE
                                              WHEN sc.SELLING_PRICE_GROSS_LOCAL_VAL >= prms.MAX_PRICE_FOR_MAX_DISCOUNT
                                                  THEN prms.MAX_DISCOUNT_FOR_MAX_PRICE_PCT
                                              ELSE prms.MAX_DISCOUNT_PCT END /
                                          100))
           
           ELSE sc.MODEL_PRICE_GROSS_LOCAL_VAL
           END                                                                    AS helper_md_price,*/
        CASE
           -- Rules to enforce minimum price and prevent discounts for no stock
           WHEN (--VALID_FROM < DATEADD(DAY, prms.NO_TOUCH_DAYS_CNT, sc.PROMO_START_DT)
               --OR ART_WARENWERT <= prms.MIN_PRICE_GROSS_LOCAL_VAL
               --OR sc.REMAINING_STOCK_CNT = 0
               --OR NB_OF_MARKDOWNS >= prms.MAX_DISCOUNT_CNT
                sc.MODEL_PRICE_GROSS_LOCAL_VAL IS NULL
                )
               THEN COALESCE(vps.previous_submitted_price, sc.SELLING_PRICE_GROSS_LOCAL_VAL)
           -- Discount steps rule
           /*WHEN --sc.MODEL_PRICE_GROSS_LOCAL_VAL >= ROUND(vps.previous_submitted_price * (1 - (prms.DISCOUNT_STEPS / 100)), 2)
                --OR (sc.MODEL_PRICE_GROSS_LOCAL_VAL IS NULL AND vps.previous_submitted_price IS NOT NULL )
                -- submitted price - discount higher than the max. discount 
                 ( vps.previous_submitted_price <= ROUND( sc.SELLING_PRICE_GROSS_LOCAL_VAL * (1 - (prms.MAX_DISCOUNT_PCT/ 100)),2) ) 
                  --- submitted price - discount lower than the min. discount and md price - discount lower than the min. discount 
                
               THEN vps.previous_submitted_price*/
          /* -- Rule to restrict number of markdowns possible herausnehmen, da dies keinen Sinn ergibt Abstand nur zwischen Rabatten
           WHEN sc.MD_PRICE_OPT >= ROUND(sc.VK_AKTION_BRUTTO * (1 - (prms.DISCOUNT_STEPS / 100)), 2)
               THEN sc.VK_AKTION_BRUTTO*/
          
           -- Rule to restrict lowest discount possible
         
           
           ELSE sc.MODEL_PRICE_GROSS_LOCAL_VAL
           END                                                                    AS helper_md_price,
       CASE 
       -- Hier einiges rausgenommen da dies aus unserer Sicht nicht notwendig ist 
       --- Manueller VK_1 sollte alles moeglich sein, dies soll nur anhand der Hintergrundfarben im Frontend gezeigt werden 
          /* -- Discount steps rule
           WHEN last_manual_price >= ROUND(wbv.previous_submitted_price * (1 - (prms.DISCOUNT_STEPS / 100)), 2)
               THEN wbv.previous_submitted_price
           WHEN last_manual_price >= ROUND(sc.VK_AKTION_BRUTTO * (1 - (prms.DISCOUNT_STEPS / 100)), 2)
               THEN helper_md_price
           -- Rule to restrict lowest discount possible
           WHEN sc.MD_PRICE_OPT <= sc.VK_AKTION_BRUTTO * (prms.MIN_DISCOUNT / 100)
               THEN sc.VK_AKTION_BRUTTO * (prms.MIN_DISCOUNT / 100)*/
           WHEN ( (ART_WARENWERT <= prms.MIN_PRICE_GROSS_LOCAL_VAL OR sc.REMAINING_STOCK_CNT = 0 ) AND NOT sc.MANDANT_ID = 5
                 -- OR NB_OF_MARKDOWNS >= prms.MAX_DISCOUNT_CNT
                ) THEN
               COALESCE(vps.previous_submitted_price, sc.SELLING_PRICE_GROSS_LOCAL_VAL)
           WHEN last_manual_price IS NOT NULL AND  last_manual_price <= COALESCE(vps.previous_submitted_price, sc.SELLING_PRICE_GROSS_LOCAL_VAL)
                THEN last_manual_price
           ELSE helper_md_price END                  AS helper_manual_price,
           --------
           -----
           ----
           
           /*HELPER END */ 
       CASE
           WHEN sc.SELLING_PRICE_GROSS_LOCAL_VAL > 0
               THEN 1 - (helper_md_price / sc.SELLING_PRICE_GROSS_LOCAL_VAL) END        AS MD_DISCOUNT_OPT,
       ROUND(helper_md_price, /* Rundung rausnehmen war hier falsch und wird im Backend gemacht
                                case
                                  WHEN sc.SELLING_PRICE_GROSS_LOCAL_VAL >= prms.PRICE_ENDING_THRESHOLD
                                      AND sc.SELLING_PRICE_GROSS_LOCAL_VAL <> ROUND(helper_md_price, 0) THEN 0
                                  ELSE 2 END*/ 2)                                     AS MD_PRICE_OPT,          -- Rule for price endings
      
      CASE
           WHEN  sc.SELLING_PRICE_GROSS_LOCAL_VAL > 0
                -- Rundung rausgenommen 
               THEN 1 - (helper_manual_price /  sc.SELLING_PRICE_GROSS_LOCAL_VAL) END AS manual_markdown_percentage,
       ROUND(helper_manual_price, /* Rundung rausnehmen war hier falsch und wird im Backend gemacht
                                    case            
                                      WHEN  sc.SELLING_PRICE_GROSS_LOCAL_VAL >= prms.PRICE_ENDING_THRESHOLD AND
                                            sc.SELLING_PRICE_GROSS_LOCAL_VAL > ROUND(helper_manual_price, 0) THEN 0
                                      ELSE 2 END*/ 2)                                 AS manual_markdown_price, -- Rule for price endings
     
           
       COALESCE(comm.COMMENT_TXT, '')                                                             AS manual_comment,
       --fin.MARKDOWN_DECISION_ID                                                                     AS jf_submitted,
       vps.submitted_price                                                                       AS id40_submitted_price,
       CAST(NULL AS FLOAT)                                                                       AS purchasing_price,
       -- this column stays empty until handover with client
       CAST(NULL AS FLOAT)                                                                       AS rohertrag,
       -- this column stays empty until handover with client
       vps.previous_submitted_price,
       --COALESCE(vps.NB_OF_MARKDOWNS, 0)                                                          AS NB_OF_MARKDOWNS,
     -- warum ?! 
       --CAST(NULL AS TIMESTAMP) AS MODEL_RUN_TIME,
       COALESCE (art_clust.ARTICLE_CLUSTER_ID,0) AS ARTICLE_CLUSTER_ID,
       /* CASE
           WHEN manual_markdown_percentage > 0
               THEN COUNT(DISTINCTsc.WUP_ID) OVER (PARTITION BY sc.MANDANT_ID , sc.KJWO_WW,sc.AKTION_ID, sc.ART_ID)
           ELSE 0 END                                                             AS STORES_WITH_DISCOUNTS,*/
   ---- neue Felder 
   COALESCE(sc.CURVE_TYPE_CD,0) AS CURVE_TYPE_CD,
   sc.RULE_CREATED_DT,
   COALESCE(sc.IS_IN_EXPERIMENT_FG,0) AS IS_IN_EXPERIMENT_FG,
   COALESCE(sc.EXPERIMENT_GROUP_CD,'-') AS EXPERIMENT_GROUP_CD,
   COALESCE(sc.EXPERIMENT_STORES_CNT,0) AS EXPERIMENT_STORES_CNT,
   sc.display_art_id,
   sc.RULE_DECISION_RECORD,
   sc.SELLING_PRICE_GROSS_LOCAL_VAL / (1+(mwst_per.mwst/100)) AS VK_NETTO,
   sc.total_revenue_gross_local_VAL / (1+(mwst_per.mwst/100)) AS Umsatz_NETTO,
   manual_markdown_price/ (1+(mwst_per.mwst/100)) AS manual_markdown_price_NETTO,
   -- Logik ausgelagert von MSI - Checkbox fuer ZR bei KMO schon angehakt bei DE nicht angehakt
   CASE WHEN sc.mandant_id = 1 THEN 0 ELSE 1 END AS checkbox_zr_default
FROM 
-- Hier schon die Scorecard dazu nehmen 
DBP_VIEW.V_NFMD_ARTICLE_STORE_SCORECARD_1 sc 

-- Alle Entscheidung pro Artikel_1, die freigegeben wurden sind 
JOIN DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION_1 fin 
ON fin.MANDANT_ID = sc.MANDANT_ID
    AND fin.ART_ID = sc.ART_ID
   -- AND fin.AKTION_ID = sc.AKTION_ID
    AND fin.KJWO_WW = sc.KJWO_WW
    AND fin.MARKDOWN_DECISION_ID = 0
----
--- MWST 
    JOIN dbp_view.v_art_1 art_1
   ON sc.art_id = art.art_id
   AND sc.mandant_id = art.mandant_id

   JOIN dbp_view.v_mwst_per_1 mwst_per_1
   ON mwst_per.mwst_id = art.mwst_id
   AND mwst_per.mandant_id = art.mandant_id
   AND mwst_per.dat_bis = '9999-12-31'
    
-- Für das VALID FROM zu berechnen 
JOIN DBP_VIEW.V_NFMD_PARAMETER_1 prms 
ON fin.mandant_id = prms.mandant_id

-- Letzter gespeicherte Preis pro Artikel_1 
LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ART_PRICE_1 dca
ON fin.KJWO_WW = dca.KJWO_WW
    --AND fin.AKTION_ID = dca.AKTION_ID
    AND fin.ART_ID = dca.ART_ID
    AND fin.MANDANT_ID = dca.MANDANT_ID
-- Letztes Gültig ab pro Artikel_1 
LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ART_PRICE_DAT_1 dcvf
ON fin.KJWO_WW = dcvf.KJWO_WW
    --AND fin.AKTION_ID = dcvf.AKTION_ID
    AND fin.ART_ID = dcvf.ART_ID
    AND fin.MANDANT_ID = dcvf.MANDANT_ID
    
-- Letzter Kommentar pro Artikel_1 
LEFT JOIN DBP_MSI_VIEW_NFMD.TS_NFMD_COMMENTS_1 comm
ON fin.KJWO_WW = comm.KJWO_WW
   --AND fin.AKTION_ID = comm.AKTION_ID
   AND fin.ART_ID = comm.ART_ID
   AND fin.MANDANT_ID = comm.MANDANT_ID

-- Letzter gespeicherte Preis pro Artikel_1 Markt 
LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ART_WUP_PRICE_1 dpc
ON sc.mandant_id = dpc.mandant_id
   AND sc.KJWO_WW = dpc.KJWO_WW
   AND sc.ART_ID = dpc.ART_ID
   AND sc.WUP_ID = dpc.WUP_ID 
-- Letztes Gültig ab pro Artikel_1 Markt  
LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ART_WUP_PRICE_DAT_1 ddc
ON sc.mandant_id = ddc.mandant_id
   AND sc.KJWO_WW = ddc.KJWO_WW
   AND sc.ART_ID = ddc.ART_ID
   AND sc.WUP_ID = ddc.WUP_ID 

-- Artikelcluster pro Artikel_1 
LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ARTICLE_ARTICLE_CLUSTER_REL_1 art_clust
--FE_MSTR_NFMD.MV_LATEST_ARTICE_CLUSTER_WB_1 art_clust
ON (fin.KJWO_WW = art_clust.KJWO_WW
    --AND fin.AKTION_ID = art_clust.AKTION_ID
    AND fin.ART_ID = art_clust.ART_ID
    AND fin.mandant_id = art_clust.mandant_id)                       

-- letzte freigegeben Daten pro Artikel_1 Markt
LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_LOADED_ART_WUP_VALUES_1 vps
--FE_MSTR_NFMD.MV_PRODUCT_STATISTICS_1 vps
ON  sc.KJWO_WW = vps.KJWO_WW
   AND sc.AKTION_ID = vps.AKTION_ID
   AND sc.MANDANT_ID = vps.MANDANT_ID
   AND sc.ART_ID = vps.ART_ID
   AND sc.WUP_ID = vps.WUP_ID                            
WHERE fin.MARKDOWN_DECISION_ID = 0
;
create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_NFMD.MV_REPORTING_KPI(
	KJWO_WW,
	MANDANT_ID,
	AKTION_ID,
	ART_ID,
	WUP_ID,
	WRG_ID,
	AKT_KJWO_WW,
	MODEL_DATE_FORMAT,
	CURVE_STATUS,
	COMMENT_TEXT,
	INITIALER_BESTAND,
	INITIALER_VK_BRUTTO,
	INITIALER_VK_NETTO,
	ABSATZ_TOTAL,
	ABSATZ_W1,
	UMSATZ_W1,
	UMSATZ_W1_NETTO,
	ENDBESTAND_W8,
	RESTMENGE_EUR,
	UMSATZ_TOTAL_BRUTTO,
	UMSATZ_TOTAL_NETTO,
	ANZAHL_MARKDOWN,
	""1_REDUZIERUNG"",
	""2_REDUZIERUNG"",
	AKTUELLER_VK,
	GEGEBENER_RABATT,
	PREISABSCHRIFT,
	TOTALABSCHRIFT,
	ABSCHRIFT_GESAMT_EUR,
	INITIALER_WARENWERT,
	PREIS_ANGEPASST_FG
) as (     
WITH base AS (
    SELECT 
    v01.KJWO_WW,
    v01.aktion_id, 
    v01.mandant_id,
    v01.art_id, 
    v01.curve_week_nr,
    v01.wup_id, 
    
    
    v01.STOCK_INITIAL_CNT, 
    v01.STOCK_INITIAL_CNT - v01.CUMULATED_SALES_CNT AS aktueller_bestand,
    v01.WEEKLY_SALES_CNT AS Absatz, 
    v01.CUMULATED_SALES_CNT AS absatz_total, 
    v01.WEEKLY_SELL_RATE AS avq, 
    v01.WEEKLY_REVENUE_GROSS_LOCAL_VAL,
    SUM(v01.WEEKLY_REVENUE_GROSS_LOCAL_VAL) OVER (PARTITION BY v01.KJWO_WW, v01.mandant_id, v01.art_id, v01.wup_id, v01.aktion_id, v01.WRG_ID  ) AS Umsatz_total,
    SUM(v01.WEEKLY_SALES_CNT) OVER (PARTITION BY v01.KJWO_WW, v01.mandant_id, v01.art_id, v01.wup_id, v01.aktion_id, v01.WRG_ID  ) AS akt_absatz_total,

    v01.SELLING_PRICE_GROSS_LOCAL_VAL, 
    v01.WRG_ID,
    v03.comment_txt,
    v04.akt_kjwo_ww, 
    
    v01.MODEL_EXECUTION_TMSP AS model_date_format,
    v06.mwst/100 AS mwst_per,
    v07.promo_lifecycle_weeks_cnt 
    FROM  DBP_VIEW.V_NFMD_ARTICLE_STORE_CURVES v01
    JOIN DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION v02
    ON  v01.KJWO_WW = v02.KJWO_WW 
    AND v01.art_id = v02.ART_ID 
    AND v01.mandant_id = v02.mandant_id
    AND v02.markdown_decision_id =  0  
    LEFT JOIN DBP_MSI_VIEW_NFMD.TS_NFMD_COMMENTS v03
    ON  v01.kjwo_ww = v03.kjwo_ww 
    AND v01.art_id = v03.art_id 
    AND v01.mandant_id = v03.mandant_id
    AND LENGTH(TRIM(v03.comment_txt)) >0
    INNER JOIN  (SELECT DISTINCT MANDANT_ID, KJWO_WW, akt_kjwo_ww
    FROM DBP_VIEW.V_WERBEWOCHE_KL)  v04
    ON v04.kjwo_ww = v01.kjwo_ww
    AND v04.mandant_id = v01.MANDANT_ID
    AND v04.akt_kjwo_ww <= 0
    
    JOIN dbp_view.v_art v05
   ON v01.art_id = v05.art_id
   AND v01.mandant_id = v05.mandant_id

   JOIN dbp_view.v_mwst_per v06
   ON v06.mwst_id = v05.mwst_id
   AND v06.mandant_id = v05.mandant_id
   AND v06.dat_bis = '9999-12-31'
  
   JOIN dbp_data.nfmd_parameter v07
   ON v01.mandant_id = v07.mandant_id
    
  WHERE v01.STOCK_INITIAL_CNT > 0

), week_8 AS (
    SELECT DISTINCT
    v01.KJWO_WW,
    v01.aktion_id, 
    v01.mandant_id,
    v01.art_id, 
    v01.CURVE_WEEK_NR,
    v01.wup_id, 
    aktueller_bestAND AS Bestand_8woche,
    Absatz_total, 
    Umsatz_total,    
    v01.SELLING_PRICE_GROSS_LOCAL_VAL, 
    
    v01.WRG_ID
    FROM base v01
    WHERE v01.CURVE_WEEK_NR = v01.promo_lifecycle_weeks_cnt AND v01.Absatz IS NOT NULL
), week_1 AS (
    SELECT DISTINCT
    v01.KJWO_WW, 
    v01.aktion_id, 
    v01.mandant_id,
    v01.art_id, 
    v01.curve_week_nr,
    v01.wup_id, 
    v01.Absatz AS absatz_1woche, 
    v01.WEEKLY_REVENUE_GROSS_LOCAL_VAL AS umsatz_1woche,
    v01.WRG_ID
    FROM base v01
    






    WHERE v01.curve_week_nr = 1 
), submit_table_base AS (
    SELECT DISTINCT 
    KJWO_WW,
    mandant_id,
    aktion_id,
    art_id, 
    wup_id,
    MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL,
    MANUAL_PROMO_PRICE_DT,
	MODEL_PRICE_GROSS_LOCAL_VAL,
    DENSE_RANK() OVER (PARTITION BY KJWO_WW, mandant_id, aktion_id, ART_id,wup_id ORDER BY MANUAL_PROMO_PRICE_DT ASC) AS markdown
    FROM 
    DBP_MSI_VIEW_NFMD.TS_NFMD_MANUAL_PRICE_RELEASE
), submit_table_md AS (
    SELECT DISTINCT 
    KJWO_WW,
    mandant_id,
    aktion_id,
    ART_id, 
    wup_id,
    MAX(markdown) AS Anzahl_Markdown 
    FROM submit_table_base 
  GROUP BY KJWO_WW,
    mandant_id,
    aktion_id,
    ART_id, 
    wup_id
), submit_table_1md AS (
    SELECT DISTINCT 
    KJWO_WW,
    mandant_id,
    aktion_id,
    ART_id, 
    wup_id,
    MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL,
    MANUAL_PROMO_PRICE_DT,
	MODEL_PRICE_GROSS_LOCAL_VAL
    FROM submit_table_base
    WHERE markdown = '1'
), submit_table_2md AS (
    SELECT DISTINCT 
    KJWO_WW,
    mandant_id,
    aktion_id,
    ART_id, 
    wup_id,
    MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL,
    MANUAL_PROMO_PRICE_DT,
	MODEL_PRICE_GROSS_LOCAL_VAL
    FROM submit_table_base
    WHERE markdown = '2'
) 

SELECT DISTINCT
    base.KJWO_WW, 
    base.mandant_id,
    base.aktion_id,
    base.art_id, 
    
    base.wup_id, 
    
    
    base.WRG_ID,
    base.akt_kjwo_ww, 
    base.model_date_format,
    CASE WHEN base.akt_kjwo_ww BETWEEN -base.promo_lifecycle_weeks_cnt AND 0 THEN 1
    WHEN base.akt_kjwo_ww < -base.promo_lifecycle_weeks_cnt AND week_8.absatz_total IS NULL THEN 2
    ELSE 3 END 
    AS CURVE_STATUS,
  
    base.COMMENT_TXT AS comment_text,
    base.STOCK_INITIAL_CNT AS initialer_bestand,
    base.SELLING_PRICE_GROSS_LOCAL_VAL AS initialer_VK_Brutto,
    base.SELLING_PRICE_GROSS_LOCAL_VAL /(1+base.mwst_per)  AS initialer_VK_netto,
    base.akt_absatz_total AS absatz_total,
    week_1.absatz_1woche AS Absatz_W1,
    week_1.umsatz_1woche AS Umsatz_W1,
    week_1.umsatz_1woche / (1+base.mwst_per)  AS Umsatz_W1_netto, 
    week_8.Bestand_8woche AS Endbestand_W8,
    week_8.Bestand_8woche * (week_8.SELLING_PRICE_GROSS_LOCAL_VAL / (1+base.mwst_per) ) AS Restmenge_EUR,
    base.Umsatz_total AS Umsatz_total_brutto,
    base.Umsatz_total / (1+base.mwst_per)   AS Umsatz_total_netto, 
  
    COALESCE(submit_table_md.Anzahl_Markdown, 0) AS Anzahl_Markdown,
    submit_table_1md.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL AS ""1_Reduzierung"",
    submit_table_2md.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL AS ""2_Reduzierung"",
    COALESCE(submit_table_2md.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL,submit_table_1md.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL,base.SELLING_PRICE_GROSS_LOCAL_VAL)   AS aktueller_VK,
    CASE WHEN submit_table_md.Anzahl_Markdown IS NOT NULL THEN 1 - (aktueller_VK / base.SELLING_PRICE_GROSS_LOCAL_VAL) ELSE 0 END AS gegebener_rabatt,
    ROUND((initialer_VK_netto * base.akt_absatz_total),2) - ROUND(Umsatz_total_netto,2) AS preisabschrift,
    week_8.Bestand_8woche * ( (base.SELLING_PRICE_GROSS_LOCAL_VAL - aktueller_VK) / (1+base.mwst_per) ) AS totalabschrift, 
    
    preisabschrift + Restmenge_EUR AS abschrift_gesamt_EUR,
    base.STOCK_INITIAL_CNT * initialer_VK_netto AS initialer_Warenwert,
	MAX(CASE WHEN ""aktueller_VK"" <> ""1_Reduzierung"" THEN 1 ELSE 0 END) OVER (PARTITION BY base.mandant_id, base.kjwo_ww, base.art_id) AS preis_angepasst_fg
FROM base
  



LEFT JOIN week_8
ON base.KJWO_WW = week_8.KJWO_WW
    AND base.aktion_id = week_8.aktion_id
    AND base.mandant_id = week_8.mandant_id
    AND base.art_id = week_8.art_id
    AND base.wup_id = week_8.wup_id
    AND base.WRG_ID = week_8.WRG_ID
LEFT JOIN week_1
ON base.KJWO_WW = week_1.KJWO_WW
    AND base.aktion_id = week_1.aktion_id
    AND base.mandant_id = week_1.mandant_id
    AND base.art_id = week_1.art_id
    AND base.wup_id = week_1.wup_id
    AND base.WRG_ID = week_1.WRG_ID
LEFT JOIN submit_table_md
ON base.KJWO_WW = submit_table_md.KJWO_WW
    AND base.aktion_id = submit_table_md.aktion_id
    AND base.mandant_id = submit_table_md.mandant_id
    AND base.art_id = submit_table_md.ART_ID
    AND base.wup_id = submit_table_md.wup_id
LEFT JOIN submit_table_1md
ON submit_table_md.KJWO_WW = submit_table_1md.KJWO_WW
    AND submit_table_md.aktion_id = submit_table_1md.aktion_id
    AND submit_table_md.mandant_id = submit_table_1md.mandant_id
    AND submit_table_md.ART_ID = submit_table_1md.ART_ID
    AND submit_table_md.wup_id = submit_table_1md.wup_id
LEFT JOIN submit_table_2md
ON submit_table_md.KJWO_WW = submit_table_2md.KJWO_WW
    AND submit_table_md.aktion_id = submit_table_2md.aktion_id
    AND submit_table_md.mandant_id = submit_table_2md.mandant_id
    AND submit_table_md.ART_ID = submit_table_2md.ART_ID
    AND submit_table_md.wup_id = submit_table_2md.wup_id ) ;

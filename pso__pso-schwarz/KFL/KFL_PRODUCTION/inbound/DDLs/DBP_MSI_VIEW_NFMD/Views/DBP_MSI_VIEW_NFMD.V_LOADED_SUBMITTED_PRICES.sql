CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.V_LOADED_SUBMITTED_PRICES AS
-- Data with manual changes
WITH submit_table_base AS (
    SELECT DISTINCT 
    KJWO_WW,
    mandant_id,
    aktion_id,
    art_id, 
    wup_id,
    MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL,
    MANUAL_PROMO_PRICE_DT,
    DWH_CREATED_TMSP,
    DENSE_RANK() OVER (PARTITION BY KJWO_WW, mandant_id, aktion_id, art_id,wup_id ORDER BY MANUAL_PROMO_PRICE_DT ASC) AS markdown
    FROM 
    DBP_MSI_VIEW_NFMD.TS_NFMD_MANUAL_PRICE_RELEASE ORDER BY KJWO_WW DESC)
-- SAP Load	max time per Mandant
, sap_wb AS ( 
  SELECT DISTINCT 
    Mandant_id, 
    MAX(EXECUTION_TMSP) AS timestamp_sap
    FROM 
    DBP_VIEW.V_NFMD_PIPELINE_EXPORT_LOG
	GROUP BY Mandant_id)
-- Basetable - Scorecard 
, id40 AS ( 
  SELECT DISTINCT 
    KJWO_WW,
    mandant_id,
    aktion_id,
    art_id, 
    wup_id,
    SELLING_PRICE_GROSS_LOCAL_VAL    
    FROM 
    DBP_VIEW.V_NFMD_ARTICLE_STORE_SCORECARD
)

SELECT 
    v01.mandant_id, 
    v01.art_id, 
    v01.wup_id, 
    v01.kjwo_ww, 
    v01.aktion_id,
    v03.SELLING_PRICE_GROSS_LOCAL_VAL AS initialer_VK,
    v01.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL AS neuer_vk, 
    ROUND(v01.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL/v03.SELLING_PRICE_GROSS_LOCAL_VAL,4)  AS Rabatt,
    v01.MANUAL_PROMO_PRICE_DT AS valid_from, 
   -- to_char(weekiso(v01.valid_from_date), 'FM00') AS test,
    YEAR(v01.MANUAL_PROMO_PRICE_DT) ||  TO_CHAR(WEEKISO(v01.MANUAL_PROMO_PRICE_DT), 'FM00') - v01.KJWO_WW + 1 AS Woche_Rabatt,
    v01.markdown AS Anzahl_Markdowns
From submit_table_base v01
JOIN sap_wb v02
ON v01.mandant_id = v02.mandant_id
AND v01.DWH_CREATED_TMSP < v02.timestamp_sap -- Only data that transferred to SAP 
JOIN id40 v03 -- Only article-market combination from the scorecard
ON v01.mandant_id = v03.mandant_id
AND v01.kjwo_ww = v03.kjwo_ww 
AND v01.wup_id = v03.wup_id 
AND v01.aktion_id = v03.aktion_id 
AND v01.art_id = v03.art_id;
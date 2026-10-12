    -- letzter übermittelter Preis 
CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_LOADED_ART_WUP_VALUES_1 AS
(
-- Alle freigegeben Preise 
WITH base AS (
    SELECT KJWO_WW,
           MANDANT_ID,
           AKTION_ID, 
           ART_ID,
           WUP_ID,
           WRG_ID,
           DWH_CREATED_TMSP,
           MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL AS SUBMITTED_PRICE,
           MANUAL_PROMO_PRICE_DT,
           COALESCE(LAST_TRANSFER_TMSP,'1900-01-01') AS LAST_TRANSFER_TMSP
    FROM DBP_MSI_VIEW_NFMD.TS_NFMD_MANUAL_PRICE_RELEASE_1),
-- zu jedem freigegeben Preis der Vorgänger definieren 
lagged AS (
SELECT KJWO_WW,
MANDANT_ID,
AKTION_ID, 
ART_ID,
WUP_ID,
WRG_ID,
SUBMITTED_PRICE,
MANUAL_PROMO_PRICE_DT,
DWH_CREATED_TMSP,
LAG(SUBMITTED_PRICE) OVER (PARTITION BY KJWO_WW ,
    AKTION_ID,
    ART_ID,
    WUP_ID,
    WRG_ID,                           
    MANDANT_ID
    ORDER BY
        LAST_TRANSFER_TMSP)  AS  previous_submitted_price,
LAG(MANUAL_PROMO_PRICE_DT) OVER (PARTITION BY KJWO_WW ,
    AKTION_ID,
    ART_ID,
    WUP_ID,
    WRG_ID,                           
    MANDANT_ID
    ORDER BY
        LAST_TRANSFER_TMSP)  AS  previous_submitted_valid_from,
ROW_NUMBER() OVER (PARTITION BY KJWO_WW ,
    AKTION_ID,
    ART_ID,
    WUP_ID,
    WRG_ID,                           
    MANDANT_ID
    ORDER BY
        LAST_TRANSFER_TMSP) AS nb_of_markdowns,
LAST_TRANSFER_TMSP
FROM base 
ORDER BY LAST_TRANSFER_TMSP),
-- Anzahl der Markdowns     
latest AS (
SELECT  KJWO_WW,
        AKTION_ID,
        ART_ID,
        WUP_ID,
        WRG_ID,                           
        MANDANT_ID,
        MAX(nb_of_markdowns) AS nb_of_markdowns
 FROM lagged
 GROUP BY KJWO_WW,
        AKTION_ID,
        ART_ID,
        WUP_ID,
        WRG_ID,                           
        MANDANT_ID),
LAST_SAP_TRANSFER AS (
    SELECT v1.MANDANT_ID, MAX(COALESCE(EXECUTION_TMSP,'1900-01-01')) AS LAST_SAP_TRANSPER_TMSP 
    FROM DBP_VIEW.V_MANDANT_1 v1
    LEFT JOIN DBP_VIEW.V_NFMD_PIPELINE_EXPORT_LOG_1 v2
    ON v1.mandant_id = v2.mandant_id
    GROUP BY v1.MANDANT_ID
)

SELECT lg.KJWO_WW,
       lg.MANDANT_ID,
       lg.AKTION_ID,
       lg.ART_ID,
       lg.WUP_ID,
       lg.WRG_ID, 
       lg.SUBMITTED_PRICE,
       lg.MANUAL_PROMO_PRICE_DT,
        
       lg.LAST_TRANSFER_TMSP            AS LAST_SAP_TRANSFER_DATE,
       lg.DWH_CREATED_TMSP AS SUBMITTED_DATE,
    -- aktueller VK_1 - der bereist nach SAP übertragen wurden ist 
       CASE
           WHEN lg.DWH_CREATED_TMSP >= sap.LAST_SAP_TRANSPER_TMSP THEN lg.PREVIOUS_SUBMITTED_PRICE
           ELSE lg.SUBMITTED_PRICE END AS PREVIOUS_SUBMITTED_PRICE,
    -- mit welchem Gültig ab nach SAP übertragen wurden ist 
       CASE
           WHEN lg.DWH_CREATED_TMSP >= sap.LAST_SAP_TRANSPER_TMSP
               THEN lg.PREVIOUS_SUBMITTED_VALID_FROM
           ELSE lg.MANUAL_PROMO_PRICE_DT END AS PREVIOUS_SUBMITTED_VALID_FROM,
    -- Anzahl der Markdowns (Wie viele Rabatte nach SAP schon für die MAK uebertragen wurden sind)
       CASE
           WHEN lg.DWH_CREATED_TMSP >= sap.LAST_SAP_TRANSPER_TMSP THEN lg.NB_OF_MARKDOWNS - 1
           ELSE lg.NB_OF_MARKDOWNS END    NB_OF_MARKDOWNS,
    -- Ob schon übertragen worden ist oder nicht 
       CASE
           WHEN lg.DWH_CREATED_TMSP >= sap.LAST_SAP_TRANSPER_TMSP THEN 'Not yet Loaded'
           ELSE 'Loaded' END   AS loaded
FROM lagged lg
         JOIN latest lst ON
            lg.KJWO_WW = lst.KJWO_WW
        AND lg.AKTION_ID = lst.AKTION_ID
        AND lg.ART_ID = lst.ART_ID
        AND lg.WUP_ID = lst.WUP_ID
        AND lg.MANDANT_ID = lst.MANDANT_ID
        AND lg.nb_of_markdowns = lst.nb_of_markdowns -- somit pro Artikel_1 nur den letzten Eintrag. 
JOIN LAST_SAP_TRANSFER sap
    ON sap.MANDANT_ID = lst.MANDANT_ID 
ORDER BY lg.NB_OF_MARKDOWNS DESC
       );
CREATE OR REPLACE VIEW FE_MSTR_NFMD.MV_PRODUCT_STATISTICS AS
(
WITH base AS (
    SELECT YEAR_ID,
           WEEK_ID,
           MANDANT_ID,
           AKTION_ID, 
           SKU_ID,
           WUP_ID,
           CREATED_AT,
           SUBMITTED_PRICE,
           VALID_FROM_DATE,
           LATEST_TRANSFER_DATE
    FROM CORE.TS_ID40_FINAL_SUBMIT),
     lagged AS (
         SELECT YEAR_ID,
                WEEK_ID,
                MANDANT_ID,
                AKTION_ID,
                SKU_ID,
                WUP_ID,
                SUBMITTED_PRICE,
                VALID_FROM_DATE,
                CREATED_AT,
                LAG(SUBMITTED_PRICE) OVER (PARTITION BY YEAR_ID ,
                    WEEK_ID ,
                    AKTION_ID,
                    SKU_ID,
                    WUP_ID,
                    MANDANT_ID
                    ORDER BY
                        LATEST_TRANSFER_DATE)    previous_submitted_price,
                LAG(VALID_FROM_DATE) OVER (PARTITION BY YEAR_ID ,
                    WEEK_ID ,
                    AKTION_ID,
                    SKU_ID,
                    WUP_ID,
                    MANDANT_ID
                    ORDER BY
                        LATEST_TRANSFER_DATE)    previous_submitted_valid_from,
                ROW_NUMBER() OVER (PARTITION BY YEAR_ID ,
                    WEEK_ID ,
                    AKTION_ID,
                    SKU_ID,
                    WUP_ID,
                    MANDANT_ID
                    ORDER BY
                        LATEST_TRANSFER_DATE) AS nb_of_markdowns,
                LATEST_TRANSFER_DATE
         FROM base b
         ORDER BY LATEST_TRANSFER_DATE),
     latest AS (
         SELECT YEAR_ID,
                WEEK_ID,
                AKTION_ID,
                SKU_ID,
                WUP_ID,
                MANDANT_ID,
                MAX(nb_of_markdowns) AS nb_of_markdowns
         FROM lagged
         GROUP BY YEAR_ID,
                  WEEK_ID,
                  AKTION_ID,
                  SKU_ID,
                  WUP_ID,
                  MANDANT_ID)
SELECT lg.YEAR_ID,
       lg.WEEK_ID,
       lg.MANDANT_ID,
       lg.AKTION_ID,
       lg.SKU_ID,
       lg.WUP_ID,
       lg.SUBMITTED_PRICE,
       lg.VALID_FROM_DATE,
       LATEST_TRANSFER_DATE            AS SAP_TRANSFER_DATE,
       CREATED_AT AS SUBMITTED_DATE,
       CASE
           WHEN lg.CREATED_AT >= (SELECT MAX("TIMESTAMP") FROM CORE.SAP_PIPELINE_WRITEBACK WHERE MANDANT_ID = lg.MANDANT_ID) THEN lg.PREVIOUS_SUBMITTED_PRICE
           ELSE lg.SUBMITTED_PRICE END AS PREVIOUS_SUBMITTED_PRICE,
       CASE
           WHEN lg.CREATED_AT >= (SELECT MAX("TIMESTAMP") FROM CORE.SAP_PIPELINE_WRITEBACK WHERE MANDANT_ID = lg.MANDANT_ID)
               THEN lg.PREVIOUS_SUBMITTED_VALID_FROM
           ELSE lg.VALID_FROM_DATE END AS PREVIOUS_SUBMITTED_VALID_FROM,
       CASE
           WHEN lg.CREATED_AT >= (SELECT MAX("TIMESTAMP") FROM CORE.SAP_PIPELINE_WRITEBACK WHERE MANDANT_ID = lg.MANDANT_ID) THEN lg.NB_OF_MARKDOWNS - 1
           ELSE lg.NB_OF_MARKDOWNS END    NB_OF_MARKDOWNS,
       CASE
           WHEN lg.CREATED_AT >= (SELECT MAX("TIMESTAMP") FROM CORE.SAP_PIPELINE_WRITEBACK WHERE MANDANT_ID = lg.MANDANT_ID) THEN 'Loaded'
           ELSE 'Not yet Loaded' END   AS loaded
FROM lagged lg
         JOIN latest lst ON
            lg.YEAR_ID = lst.YEAR_ID
        AND lg.WEEK_ID = lst.WEEK_ID
        AND lg.AKTION_ID = lst.AKTION_ID
        AND lg.SKU_ID = lst.SKU_ID
        AND lg.WUP_ID = lst.WUP_ID
        AND lg.MANDANT_ID = lst.MANDANT_ID
        AND lg.nb_of_markdowns = lst.nb_of_markdowns
ORDER BY lg.NB_OF_MARKDOWNS DESC
       );
       
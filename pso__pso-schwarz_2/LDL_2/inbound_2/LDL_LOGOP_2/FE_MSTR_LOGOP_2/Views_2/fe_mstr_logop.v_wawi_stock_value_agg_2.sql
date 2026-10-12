CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_WAWI_STOCK_VALUE_AGG_2(
    CLIENT_ID COMMENT 'Client id - calculated based on the country_2 code',
    WH_ID COMMENT 'Warehouse id',
    ARTIKELNR COMMENT 'Item_2 nr',
    REPORTED_DATE COMMENT 'T1001 Date',
    PIECEQTY_CAL COMMENT 'Stock Expected',
    PIECEQTY_REAL COMMENT 'Stock Counted',
    PIECEQTY_DIFF COMMENT 'Stock Difference',
    VALID_SEQ COMMENT 'Valid Sequences of Tech Differences',
    RETAIL_PRICE COMMENT 'Retail Price from Bestandartikel_2',
    DWH_LOAD_ID COMMENT 'Load id',
    DWH_CREATED COMMENT 'Record created at',
    DWH_UPDATED COMMENT 'Record updated at',
    DWH_VALID_FROM COMMENT 'Valid from date',
    DWH_VALID_TO COMMENT 'Valid to date',
    DELETED_FG COMMENT 'Flag if record is deleted'
) AS
WITH base_stock AS (
    SELECT
        bas.CLIENT_ID,
        bas.WH_ID,
        bas.ARTIKELNR,
        bas.REPORTED_DATE,
        bas.PIECEQTY_CAL,
        bas.PIECEQTY_REAL,
        bas.PIECEQTY_DIFF,
        bas.RETAIL_PRICE,
        bas.DWH_LOAD_ID,
        bas.DWH_CREATED,
        bas.DWH_UPDATED,
        bas.DWH_VALID_FROM,
        bas.DWH_VALID_TO,
        bas.DELETED_FG
    FROM FE_MSTR_LOGOP.V_WAWI_STOCK_VALUE_ADD_2 bas
),
flagged_stock AS (
    SELECT
        CLIENT_ID,
        WH_ID,
        ARTIKELNR,
        REPORTED_DATE,
        PIECEQTY_DIFF,
        CASE
            WHEN ABS(PIECEQTY_DIFF) > 1 THEN 1
            ELSE 0
        END AS DIFF_NON_ZERO,
        LAG(DIFF_NON_ZERO) OVER (PARTITION BY CLIENT_ID, WH_ID, ARTIKELNR ORDER BY REPORTED_DATE) AS PREV_DIFF_NON_ZERO,
        MAX(REPORTED_DATE) OVER () AS MAX_REPORTED_DATE
    FROM base_stock
),
counted_stock AS (
    SELECT
        CLIENT_ID,
        WH_ID,
        ARTIKELNR,
        REPORTED_DATE,
        PIECEQTY_DIFF,
        DIFF_NON_ZERO,
        PREV_DIFF_NON_ZERO,
        MAX_REPORTED_DATE,
        CASE 
            WHEN REPORTED_DATE = MAX_REPORTED_DATE AND DIFF_NON_ZERO = 1 AND PREV_DIFF_NON_ZERO = 1 THEN 1
            ELSE 0
        END AS VALID_FG
    FROM flagged_stock
),
valid_stock AS (
    SELECT 
        CLIENT_ID,
        WH_ID,
        ARTIKELNR,
        REPORTED_DATE,
        PIECEQTY_DIFF,
        DIFF_NON_ZERO,
        PREV_DIFF_NON_ZERO,
        MAX_REPORTED_DATE,
        VALID_FG,
        CASE 
            WHEN SUM(VALID_FG) OVER (PARTITION BY CLIENT_ID, WH_ID, ARTIKELNR ORDER BY REPORTED_DATE DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) = 0 THEN 0
            ELSE CASE 
                WHEN DIFF_NON_ZERO = 0 THEN 0 
                ELSE 1 
            END 
        END AS VALID_SEQ,
        SUM(CASE 
                WHEN DIFF_NON_ZERO = 0 THEN 1
                ELSE 0
            END) OVER (PARTITION BY CLIENT_ID, WH_ID, ARTIKELNR ORDER BY REPORTED_DATE DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ZERO_COUNT
    FROM counted_stock
),
adjusted_validity AS (
    SELECT
        CLIENT_ID,
        WH_ID,
        ARTIKELNR,
        REPORTED_DATE,
        PIECEQTY_DIFF,
        DIFF_NON_ZERO,
        PREV_DIFF_NON_ZERO,
        MAX_REPORTED_DATE,
        VALID_FG,
        VALID_SEQ,
        ZERO_COUNT,
        CASE 
            WHEN ZERO_COUNT > 0 THEN 0
            ELSE VALID_SEQ
        END AS ADJ_VALID_SEQ
    FROM valid_stock
)
SELECT
    bs.CLIENT_ID,
    bs.WH_ID,
    bs.ARTIKELNR,
    bs.REPORTED_DATE,
    bs.PIECEQTY_CAL,
    bs.PIECEQTY_REAL,
    bs.PIECEQTY_DIFF,
    av.ADJ_VALID_SEQ AS VALID_SEQ,
    bs.RETAIL_PRICE,
    bs.DWH_LOAD_ID,
    bs.DWH_CREATED,
    bs.DWH_UPDATED,
    bs.DWH_VALID_FROM,
    bs.DWH_VALID_TO,
    bs.DELETED_FG
FROM base_stock bs
JOIN adjusted_validity av
ON av.CLIENT_ID = bs.CLIENT_ID
AND av.WH_ID = bs.WH_ID
AND av.ARTIKELNR = bs.ARTIKELNR
AND av.REPORTED_DATE = bs.REPORTED_DATE
;
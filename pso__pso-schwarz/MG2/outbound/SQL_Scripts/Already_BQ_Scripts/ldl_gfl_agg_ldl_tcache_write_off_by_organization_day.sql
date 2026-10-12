CREATE
OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.VT3 AS
SELECT
    AGG.BUS_DT,
    AGG.COUNTRY_ORG_CD,
    AGG.INT_ORG_SID,
    AGG.INT_ORG_TYPE_CD,
    AGG.CURR_CD,

    AGG.WRITE_OFF_NET_VAL, 
    AGG.WRITE_OFF_FOR_BREAKAGE_NET_VAL, -- Bruch
    AGG.WRITE_OFF_FOR_SELL_BY_DT_NET_VAL, --MHD
    AGG.WRITE_OFF_FOR_DELIV_QUALITY_NET_VAL, -- Anlieferung Qualitat
    AGG.WRITE_OFF_FOR_DEFECTIVE_NON_FOOD_NET_VAL, -- Defektes NF
    AGG.WRITE_OFF_FOR_DONATIONS_NET_VAL, -- Spenden
    AGG.WRITE_OFF_FOR_DISCOUNTS_NET_VAL,
    AGG.WRITE_OFF_FOR_TAKEN_PROD_NET_VAL, -- Warenentnahme
    AGG.WRITE_OFF_FOR_FORCE_MAJEURE_NET_VAL,
    AGG.WRITE_OFF_FOR_STOCK_CLEARANCE_NET_VAL,

    CURRENT_TIMESTAMP AS DWH_CREATED_TMSP,
    CURRENT_TIMESTAMP AS DWH_UPDATED_TMSP,
    '${LOAD_ID}' AS DWH_LOAD_ID,
    'CORE_REL' AS DWH_NODE_CD
FROM
    (
        SELECT
            WR.BUS_DT AS BUS_DT,
            WR.COUNTRY_ORG_CD,
            WR.INT_ORG_SID,
            WR.INT_ORG_TYPE_CD,
            WR.CURR_CD,
            SUM (
                CASE
                    WHEN WRITE_OFF_REASON_ID in (2, 128) THEN WR.write_off_net_val
                    ELSE 0
                END
            ) AS WRITE_OFF_FOR_BREAKAGE_NET_VAL -- Bruch
,
            SUM (
                CASE
                    WHEN WRITE_OFF_REASON_ID in (1, 127, 134, 135) THEN WR.write_off_net_val
                    ELSE 0
                END
            ) AS WRITE_OFF_FOR_SELL_BY_DT_NET_VAL --MHD
,
            SUM (
                CASE
                    WHEN WRITE_OFF_REASON_ID in (8) THEN WR.write_off_net_val
                    ELSE 0
                END
            ) AS WRITE_OFF_FOR_DELIV_QUALITY_NET_VAL -- Anlieferung Qualitat
,
            SUM (
                CASE
                    WHEN WRITE_OFF_REASON_ID in (9, 10, 11) THEN WR.write_off_net_val
                    ELSE 0
                END
            ) AS WRITE_OFF_FOR_DEFECTIVE_NON_FOOD_NET_VAL -- Defektes NF
,
            SUM (
                CASE
                    WHEN WRITE_OFF_REASON_ID in (7, 130, 131) THEN WR.write_off_net_val
                    ELSE 0
                END
            ) AS WRITE_OFF_FOR_DONATIONS_NET_VAL -- Spenden
,
            SUM (
                CASE
                    WHEN WRITE_OFF_REASON_ID in (5) THEN WR.write_off_net_val
                    ELSE 0
                END
            ) AS WRITE_OFF_FOR_DISCOUNTS_NET_VAL -- Rabattierung
,
            SUM (
                CASE
                    WHEN WRITE_OFF_REASON_ID in (4, 101, 102, 110, 111, 129, 155) THEN WR.write_off_net_val
                    ELSE 0
                END
            ) AS WRITE_OFF_FOR_TAKEN_PROD_NET_VAL -- Warenentnahme
,
            SUM (
                CASE
                    WHEN WRITE_OFF_REASON_ID in (3, 136, 137, 152) THEN WR.write_off_net_val
                    ELSE 0
                END
            ) AS WRITE_OFF_FOR_FORCE_MAJEURE_NET_VAL 
,
            SUM (
                CASE
                    WHEN WRITE_OFF_REASON_ID in (6, 151) THEN WR.write_off_net_val
                    ELSE 0
                END
            ) AS WRITE_OFF_FOR_STOCK_CLEARANCE_NET_VAL
,
            SUM (WR.write_off_net_val                 
            ) AS WRITE_OFF_NET_VAL

        FROM CORE_REL.T_WRITE_OFF_EVENT WR
             INNER JOIN ${FWRK_WORK_DB}.VT1 DK 
                ON DK.LOC_SID = WR.INT_ORG_SID
                AND DK.DWH_CAL_DT = WR.BUS_DT
        WHERE
            WR.WRITE_OFF_DT BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
            AND WR.CURR_STAT_FG = TRUE
            AND WR.INT_ORG_TYPE_CD = 'STORE'
            AND WR.WRITE_OFF_EVENT_TYPE_ID IN (137, 147)
        GROUP BY
            WR.BUS_DT,
            WR.COUNTRY_ORG_CD,
            WR.INT_ORG_SID,
            WR.INT_ORG_TYPE_CD,
            WR.CURR_CD
    ) AS AGG
LEFT OUTER JOIN CORE_DIM.T_FACT_RETAIL_BY_STORE_DAY SA 
           ON AGG.BUS_DT=SA.BUS_DT
              AND AGG.COUNTRY_ORG_CD=SA.COUNTRY_ORG_CD
              AND AGG.INT_ORG_SID=SA.INT_ORG_SID
              AND AGG.INT_ORG_TYPE_CD=SA.INT_ORG_TYPE_CD
              AND AGG.CURR_CD=SA.CURR_CD
 
;


BEGIN TRANSACTION
;

DELETE FROM
    ETL_PROCESS.T_TCACHE_WRITE_OFF_BY_ORGANIZATION_DAY AGG USING ${FWRK_WORK_DB}.VT1 B
WHERE
    B.DWH_CAL_DT = AGG.BUS_DT
    AND B.LOC_SID = AGG.INT_ORG_SID
;
 

INSERT INTO
    ETL_PROCESS.T_TCACHE_WRITE_OFF_BY_ORGANIZATION_DAY
(
    BUS_DT,
    COUNTRY_ORG_CD,
    INT_ORG_SID,
    INT_ORG_TYPE_CD,
    CURR_CD,

    WRITE_OFF_NET_VAL,
    WRITE_OFF_FOR_BREAKAGE_NET_VAL, -- Bruch
    WRITE_OFF_FOR_SELL_BY_DT_NET_VAL, --MHD
    WRITE_OFF_FOR_DELIV_QUALITY_NET_VAL, -- Anlieferung Qualitat
    WRITE_OFF_FOR_DEFECTIVE_NON_FOOD_NET_VAL, -- Defektes NF
    WRITE_OFF_FOR_DONATIONS_NET_VAL, -- Spenden
    WRITE_OFF_FOR_DISCOUNTS_NET_VAL,
    WRITE_OFF_FOR_TAKEN_PROD_NET_VAL, -- Warenentnahme
    WRITE_OFF_FOR_FORCE_MAJEURE_NET_VAL,
    WRITE_OFF_FOR_STOCK_CLEARANCE_NET_VAL,
    
    DWH_CREATED_TMSP,
    DWH_UPDATED_TMSP,
    DWH_LOAD_ID,
    DWH_NODE_CD
)
SELECT
    BUS_DT,
    COUNTRY_ORG_CD,
    INT_ORG_SID,
    INT_ORG_TYPE_CD,
    CURR_CD,
    
    WRITE_OFF_NET_VAL,
    WRITE_OFF_FOR_BREAKAGE_NET_VAL, -- Bruch
    WRITE_OFF_FOR_SELL_BY_DT_NET_VAL, --MHD
    WRITE_OFF_FOR_DELIV_QUALITY_NET_VAL, -- Anlieferung Qualitat
    WRITE_OFF_FOR_DEFECTIVE_NON_FOOD_NET_VAL, -- Defektes NF
    WRITE_OFF_FOR_DONATIONS_NET_VAL, -- Spenden
    WRITE_OFF_FOR_DISCOUNTS_NET_VAL,
    WRITE_OFF_FOR_TAKEN_PROD_NET_VAL, -- Warenentnahme  
    WRITE_OFF_FOR_FORCE_MAJEURE_NET_VAL,
    WRITE_OFF_FOR_STOCK_CLEARANCE_NET_VAL,    

    DWH_CREATED_TMSP,
    DWH_UPDATED_TMSP,
    DWH_LOAD_ID,
    DWH_NODE_CD
from
    ETL.VT3
;

COMMIT
;

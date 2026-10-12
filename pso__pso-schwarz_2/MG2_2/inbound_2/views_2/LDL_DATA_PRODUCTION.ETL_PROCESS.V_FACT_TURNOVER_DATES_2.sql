create or replace view LDL_DATA_PRODUCTION.ETL_PROCESS.V_FACT_TURNOVER_DATES_2(
	BUS_YEAR,
	INT_ORG_SID,
	INT_ORG_TYPE_CD,
	COUNTRY_ORG_CD,
	CURR_CD,
	BEGIN_BUS_DT,
	TO_BUS_DT
) as 
SELECT BUS_YEAR, INT_ORG_SID
     , INT_ORG_TYPE_CD
     , COUNTRY_ORG_CD
     , CURR_CD 
     , BEGIN_BUS_DT
     , CASE WHEN BUS_YEAR = LAST_BUS_YEAR THEN LAST_BUS_DT
            ELSE END_BUS_DT  
        END AS TO_BUS_DT    
  FROM (
        SELECT D.BUS_YEAR
             , MDT.LAST_BUS_YEAR
             , F.INT_ORG_SID
             , F.INT_ORG_TYPE_CD
             , F.COUNTRY_ORG_CD
             , F.CURR_CD 
             , D.BEGIN_BUS_DT
             , D.END_BUS_DT  
             , MDT.LAST_BUS_DT               
             , MAX(F.BUS_DT) AS LAST_BD
             , SUM(F.TURNOVER_NET_VAL) AS S_TURNOVER_NET_VAL
             , SUM(F.TURNOVER_GROSS_VAL) AS S_TURNOVER_GROSS_VAL
             , SUM(F.RECEIPT_CNT) AS S_RECEIPT_CNT
             , ROW_NUMBER() OVER (PARTITION BY D.BUS_YEAR ,F.INT_ORG_SID ORDER BY MAX(F.BUS_DT) DESC) AS rn --identifys the last valid entry for the business year      
          FROM ETL.T_TCACHE_FACT_TURNOVER_BY_STORE_DAY_2 AS F
          JOIN (SELECT BUS_YEAR
                     , MIN(CAL_DT) AS BEGIN_BUS_DT
                     , MAX(CAL_DT) AS END_BUS_DT 
                 FROM CORE_DIM.T_DIM_CALENDAR_DATE_2
                 GROUP BY BUS_YEAR) AS D
            ON D.BUS_YEAR = F.BUS_YEAR
          JOIN (SELECT MAX(BUS_YEAR) AS LAST_BUS_YEAR 
                     , MAX(BUS_DT) AS LAST_BUS_DT 
                  FROM ETL_PROCESS.T_TCACHE_FACT_TURNOVER_BY_STORE_DAY_2) AS MDT
            ON 1=1
         GROUP BY D.BUS_YEAR
             , MDT.LAST_BUS_YEAR
             , MDT.LAST_BUS_DT  
             , D.BEGIN_BUS_DT
             , D.END_BUS_DT
             , F.INT_ORG_SID
             , F.INT_ORG_TYPE_CD
             , F.COUNTRY_ORG_CD
             , F.CURR_CD
             ) AS SRC
WHERE rn = 1
  AND COALESCE( S_TURNOVER_NET_VAL, 0) <> 0
  AND COALESCE( S_TURNOVER_GROSS_VAL, 0) <> 0
  AND COALESCE( S_RECEIPT_CNT, 0) <> 0
;
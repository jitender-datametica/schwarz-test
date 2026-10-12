/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-12-08 Pawel Wieczorek          Initial version
#  1.1 2022-01-17 Pawel Wieczorek          Change DISCOUNT_PLAN_VAL to PRICE_CHANGE_PLAN_VAL
#  1.2 2022-02-07 Pawel Wieczorek          Change PRICE_CHANGE_PLAN_VAL into two columns PRICE_CHANGE_LP_REV_PLAN_VAL and PRICE_CHANGE_TOT_REV_PLAN_VAL
#  1.3 2022-02-08 Pawel Wieczorek          #261360 Change comments
#  1.4 2022-12-01 Marcin Kikola            Extension of the logic in the table within AP0149031
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_LDPL_PLAN_MTH
(
 CLIENT_ID COMMENT 'Identifier for client'
,CY_MONTH COMMENT 'Month number'
,HARMO_CAL_MONTH_NO COMMENT 'Harmonized month no per country - month since rollout'
,CURRENCY_ISO_CD COMMENT 'ISO code for the currency of the client.'
,CURR_TOT_ID COMMENT 'Currency tot identifier'
,PRICE_CHANGE_LP_REV_PLAN_VAL COMMENT 'Plan for LidlPlus Price Change divided by LidlPlus net turnover. 5% is stored as 5.0'
,PRICE_CHANGE_TOT_REV_PLAN_VAL COMMENT 'Plan for LidlPlus Price Change divided by total net turnover. 5% is stored as 5.0. Used for data patch'
,TOTAL_NET_PLAN_VAL COMMENT 'Plan for total revenue net value. 5% is stored as 5.0. Used for data patch'
,TOTAL_KPGES_REV_PLAN COMMENT 'Rvenue plan value taken from KPGES'
,TOTAL_NEW_REG_CNT_PLAN COMMENT 'Plan value for LidlPlus registered users. Used for data patch'
,LP_CUSTOMER_SID_CNT_PLAN COMMENT 'Plan value for LidlPlus identified customers. Used for data patch'
,PRICE_CHANGE_TOT_REV_PLAN_VAL_GROSS COMMENT 'Calculated value of LP price change'
,TOTAL_NET_PLAN_VAL_GROSS COMMENT 'Calculated value of LP revenue'
,DWH_LOAD_ID COMMENT 'Load identifier'
,DWH_CREATED COMMENT 'Row created time'
,DWH_UPDATED COMMENT 'Row update time'
)
AS
WITH 
CTE_CURR_RATE AS (
    SELECT 
     CLIENT_ID
    ,CURRENCY_ISO_CD
    ,CURR_TOT_ID
    ,TO_CURRENCY_ISO_CD
    ,RATE_CURRENCY_EXCHANGE   

    FROM P_LEW_MART_MSI.V_REF_CURRENCY AS C
    WHERE
    C.LOCAL_CURRENCY_FG = 0

    UNION ALL

    SELECT 
     CLIENT_ID
    ,CURRENCY_ISO_CD
    ,CURR_TOT_ID
    ,CURRENCY_ISO_CD AS TO_CURRENCY_ISO_CD
    ,1 AS RATE_CURRENCY_EXCHANGE  
    FROM P_LEW_MART_MSI.V_REF_CURRENCY AS C
        WHERE
    CURRENCY_ISO_CD = 'EUR'
/*CTE CREATED TO OBTAIN LIST OF EXCHANGE RATES IN ORDER TO POPULATE LOCAL CURRENCIES AND EUR FOR NON EU COUNTRIES*/
),
KPGES AS 
(
SELECT 
K.CLIENT_ID,
CAL.CY_MONTH,
K.CURRENCY_ISO_CD,
SUM(VAL_INDICATOR) AS  TOTAL_KPGES_REV_PLAN
FROM P_LEW_MART_MSI_AC.V_KPGES_PLAN_DAY_WH_MERGE K
INNER JOIN P_LEW_CORE_AC.V_CAL_CALENDARDAY CAL  
   ON K.DAT_FORMDATE = CAL.CAL_DT
WHERE K.INDICATOR_ID IN (157)
AND K.CURRENCY_ISO_CD='EUR'
AND K.ASPECT_ID = 2
GROUP BY 1,2,3
)
SELECT
 P.CLIENT_ID
,P.CY_MONTH
,H.HARMO_CAL_MONTH_NO
,C.TO_CURRENCY_ISO_CD AS  CURRENCY_ISO_CD
,CASE WHEN C.TO_CURRENCY_ISO_CD = 'EUR' THEN 0 ELSE P.CLIENT_ID END AS CURR_TOT_ID
,P.PRICE_CHANGE_LP_REV_PLAN_VAL
,P.PRICE_CHANGE_TOT_REV_PLAN_VAL      
,P.TOTAL_NET_PLAN_VAL
,A.TOTAL_KPGES_REV_PLAN*C.RATE_CURRENCY_EXCHANGE      
,P.TOTAL_NEW_REG_CNT_PLAN    
,P.LP_CUSTOMER_SID_CNT_PLAN       
,(P.PRICE_CHANGE_TOT_REV_PLAN_VAL)*(A.TOTAL_KPGES_REV_PLAN)*C.RATE_CURRENCY_EXCHANGE/100 AS PRICE_CHANGE_TOT_REV_PLAN_VAL_GROSS
,(P.TOTAL_NET_PLAN_VAL)*(A.TOTAL_KPGES_REV_PLAN)*C.RATE_CURRENCY_EXCHANGE/100 AS TOTAL_NET_PLAN_VAL_GROSS
,P.DWH_LOAD_ID
,P.DWH_CREATED
,P.DWH_UPDATED
FROM P_LEW_PROCESS_MSTR.T_REF_LDPL_PLAN_MTH AS P
LEFT OUTER JOIN P_LEW_MART_LIDL_DIGITAL.T_HARMO_CALENDAR_LDPL_DAY AS H
    ON H.CLIENT_ID = P.CLIENT_ID
    AND H.CY_MONTH = P.CY_MONTH
    AND H.LAST_DAY_MONTH_FG = 1
INNER JOIN CTE_CURR_RATE AS C
    ON C.CLIENT_ID = P.CLIENT_ID
    AND C.CURRENCY_ISO_CD=P.CURRENCY_ISO_CD
LEFT OUTER JOIN /*JOIN TO OBTAIN KPGES UMSATZ VALUE*/
KPGES AS A
 ON  A.CLIENT_ID       = P.CLIENT_ID
 AND A.CY_MONTH        = P.CY_MONTH
 AND A.CURRENCY_ISO_CD = P.CURRENCY_ISO_CD
 ;
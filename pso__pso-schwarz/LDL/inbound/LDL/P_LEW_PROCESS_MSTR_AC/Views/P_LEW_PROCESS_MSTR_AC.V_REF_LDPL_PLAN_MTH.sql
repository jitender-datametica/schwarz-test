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
#  1.2 2022-02-08 Pawel Wieczorek          #261360 Change comments
#  1.3 2022-12-01 Marcin Kikola            Extension of the logic in the table within AP0149031
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_LDPL_PLAN_MTH
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
SELECT
 CLIENT_ID
,CY_MONTH
,HARMO_CAL_MONTH_NO
,CURRENCY_ISO_CD
,CURR_TOT_ID
,PRICE_CHANGE_LP_REV_PLAN_VAL
,PRICE_CHANGE_TOT_REV_PLAN_VAL
,TOTAL_NET_PLAN_VAL
,TOTAL_KPGES_REV_PLAN
,TOTAL_NEW_REG_CNT_PLAN
,LP_CUSTOMER_SID_CNT_PLAN
,PRICE_CHANGE_TOT_REV_PLAN_VAL_GROSS
,TOTAL_NET_PLAN_VAL_GROSS
,DWH_LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_PLAN_MTH;
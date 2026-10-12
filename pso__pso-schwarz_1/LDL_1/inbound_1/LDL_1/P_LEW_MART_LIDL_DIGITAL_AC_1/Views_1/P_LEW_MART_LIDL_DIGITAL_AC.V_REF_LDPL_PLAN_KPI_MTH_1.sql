/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2025-03-19 Marcin Kikola    Initial version AP0263904
#------------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_REF_LDPL_PLAN_KPI_MTH_1
(
 CLIENT_ID COMMENT 'Identifier for client'
,CY_MONTH COMMENT 'Month number'
,BUSYEAR COMMENT 'Business year number'
,HARMO_CAL_MONTH_NO COMMENT 'Harmonized month no per country_1 - month since rollout'
,CURRENCY_ISO_CD COMMENT 'ISO code for the currency of the client.'
,CURR_TOT_ID COMMENT 'Currency tot identifier'
,LP_CUSTOMER_SID_CNT_PLAN COMMENT 'Plan value for Lidl Plus identified customers. Used for data patch'
,LP_CUSTOMER_SID_CNT_PLAN_BUSYEAR COMMENT 'Plan value for Lidl Plus identified customers per business year. Used for data patch'
,LP_RECEIPT_CNT_PLAN COMMENT 'Plan value for Lidl Plus count of receipts. Used for data patch'
,LP_NET_VAL_EUR_PLAN COMMENT 'Plan value for Lidl Plus revenue net value in EUR. Used for data patch'
,TOTAL_NET_VAL_EUR_PLAN COMMENT 'Plan value for total revenue net value in EUR. Used for data patch'
,LP_DISCOUNT_VAL_EUR_PLAN COMMENT 'Plan value for Lidl Plus discount in EUR. Used for data patch'
,LP_NEW_REG_CNT_PLAN COMMENT 'Plan value for Lidl Plus registered users. Used for data patch'
,LP_NEW_REG_CNT_PLAN_BUSYEAR COMMENT 'Plan value for Lidl Plus registered users per business year. Used for data patch'
,LP_ADVERTISING_DISCOUNT COMMENT 'Plan value for Lidl Plus advertising discount in EUR. Used for data patch'
,NON_LP_ADVERTISING_DISCOUNT COMMENT 'Plan value for Total Plus advertising discount in EUR. Used for data patch'
,TOTAL_ADVERTISING_DISCOUNT COMMENT 'Plan value for Non Lidl Plus advertising discount in EUR. Used for data patch'
,LOYALTY_ADVERTISING_DISCOUNT  COMMENT 'Plan value for Loyalty advertising discount in EUR. Used for data patch'
,PROMO_ADVERTISING_DISCOUNT  COMMENT 'Plan value for Loyalty advertising discount in EUR. Used for data patch'
,DWH_LOAD_ID COMMENT 'Load identifier'
,DWH_CREATED COMMENT 'Row created time'
,DWH_UPDATED COMMENT 'Row update time'
)
AS 
SELECT
 CLIENT_ID
,CY_MONTH 
,BUSYEAR
,HARMO_CAL_MONTH_NO
,CURRENCY_ISO_CD
,CURR_TOT_ID
,LP_CUSTOMER_SID_CNT_PLAN 
,LP_CUSTOMER_SID_CNT_PLAN_BUSYEAR
,LP_RECEIPT_CNT_PLAN 
,LP_NET_VAL_EUR_PLAN 
,TOTAL_NET_VAL_EUR_PLAN 
,LP_DISCOUNT_VAL_EUR_PLAN
,LP_NEW_REG_CNT_PLAN  
,LP_NEW_REG_CNT_PLAN_BUSYEAR
,LP_ADVERTISING_DISCOUNT
,NON_LP_ADVERTISING_DISCOUNT
,TOTAL_ADVERTISING_DISCOUNT 
,LOYALTY_ADVERTISING_DISCOUNT
,PROMO_ADVERTISING_DISCOUNT
,DWH_LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_REF_LDPL_PLAN_KPI_MTH_1
;
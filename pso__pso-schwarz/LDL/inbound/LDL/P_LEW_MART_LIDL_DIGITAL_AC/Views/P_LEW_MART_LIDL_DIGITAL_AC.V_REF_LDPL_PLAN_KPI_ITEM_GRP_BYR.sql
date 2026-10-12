/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2025-03-19 Marcin Kikola    Initial version AP0263904
#------------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_REF_LDPL_PLAN_KPI_ITEM_GRP_BYR
(
 CLIENT_ID COMMENT 'Identifier for client'
,BYR COMMENT 'Business year number'
,ITEMGROUP_INT_ID COMMENT 'Item group identifier'
,CURRENCY_ISO_CD COMMENT 'ISO code for the currency of the client.'
,CURR_TOT_ID COMMENT 'Currency tot identifier'
,LP_ADVERTISING_DISCOUNT_BUSYEAR COMMENT 'Plan value for Lidl Plus advertising discount in EUR. Used for data patch'
,NON_LP_ADVERTISING_DISCOUNT_BUSYEAR  COMMENT 'Plan value for Total advertising discount in EUR. Used for data patch'
,TOTAL_ADVERTISING_DISCOUNT_BUSYEAR_OLD COMMENT 'Plan value for Non Lidl Plus advertising discount in EUR. Used for data patch. No data sent since 2025'
,TOTAL_ADVERTISING_DISCOUNT_BUSYEAR COMMENT 'Plan value for Non Lidl Plus advertising discount in EUR. Used for data patch. New field added in 2025'
,LOYALTY_ADVERTISING_DISCOUNT_BUSYEAR  COMMENT 'Plan value for Loyalty advertising discount in EUR. Used for data patch'
,PROMO_ADVERTISING_DISCOUNT_BUSYEAR  COMMENT 'Plan value for Promo advertising discount in EUR. Used for data patch'
,LP_ADVERTISING_DISCOUNT_FA COMMENT 'Plan value for Lidl Plus advertising discount food aktion in EUR. Used for data patch'
,NON_LP_ADVERTISING_DISCOUNT_FA COMMENT 'Plan value for Total advertising discount food aktion in EUR. Used for data patch'
,TOTAL_ADVERTISING_DISCOUNT_FA_OLD COMMENT 'Plan value for Non Lidl Plus advertising food aktion discount in EUR. Used for data. No data sent since 2025'
,TOTAL_ADVERTISING_DISCOUNT_FA COMMENT 'Plan value for Non Lidl Plus advertising food aktion discount in EUR. Used for data patch. New field added in 2025'
,LOYALTY_ADVERTISING_DISCOUNT_FA  COMMENT 'Plan value for Loyalty advertising food aktion discount in EUR. Used for data patch'
,PROMO_ADVERTISING_DISCOUNT_FA  COMMENT 'Plan value for Promo advertising food aktion discount in EUR. Used for data patch'
,TOTAL_UNSOLD_ITEM_PROCEDURE COMMENT 'Plan value for Total unsold item procedure in EUR. Used for data patch'
,TOTAL_PERMANENT_DISCOUNT_PRICE_AREA_DIFF  COMMENT 'Plan value for Total permanent discount price area difference in EUR. Used for data patch'
,TOTAL_NET_VAL_EUR_PLAN_BUSYEAR COMMENT 'Plan value for total revenue net value. Used for data patch'
,TOTAL_NET_VAL_EUR_PLAN_FA COMMENT 'Plan value for total revenue Food Aktion net value. Used for data patch'
,DWH_LOAD_ID COMMENT 'Load identifier'
,DWH_CREATED COMMENT 'Row created time'
,DWH_UPDATED COMMENT 'Row update time'
)
AS
SELECT
 CLIENT_ID 
,BYR
,ITEMGROUP_INT_ID
,CURRENCY_ISO_CD
,CURR_TOT_ID
,LP_ADVERTISING_DISCOUNT_BUSYEAR
,NON_LP_ADVERTISING_DISCOUNT_BUSYEAR
,TOTAL_ADVERTISING_DISCOUNT_BUSYEAR_OLD
,TOTAL_ADVERTISING_DISCOUNT_BUSYEAR
,LOYALTY_ADVERTISING_DISCOUNT_BUSYEAR
,PROMO_ADVERTISING_DISCOUNT_BUSYEAR
,LP_ADVERTISING_DISCOUNT_FA
,NON_LP_ADVERTISING_DISCOUNT_FA
,TOTAL_ADVERTISING_DISCOUNT_FA_OLD
,TOTAL_ADVERTISING_DISCOUNT_FA
,LOYALTY_ADVERTISING_DISCOUNT_FA
,PROMO_ADVERTISING_DISCOUNT_FA
,TOTAL_UNSOLD_ITEM_PROCEDURE
,TOTAL_PERMANENT_DISCOUNT_PRICE_AREA_DIFF
,TOTAL_NET_VAL_EUR_PLAN_BUSYEAR
,TOTAL_NET_VAL_EUR_PLAN_FA
,DWH_LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_REF_LDPL_PLAN_KPI_ITEM_GRP_BYR
;
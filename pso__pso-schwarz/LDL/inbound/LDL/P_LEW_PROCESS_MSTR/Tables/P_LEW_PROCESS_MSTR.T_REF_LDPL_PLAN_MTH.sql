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
#  1.1 2022-02-07 Pawel Wieczorek          Change PRICE_CHANGE_PLAN_VAL into two columns PRICE_CHANGE_LP_REV_PLAN_VAL and PRICE_CHANGE_TOT_REV_PLAN_VAL
#  1.1 2022-02-08 Pawel Wieczorek          #261360 Change comments
#  1.2 2022-12-01 Marcin Kikola            Extension of the logic in the table within AP0149031
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_PROCESS_MSTR.T_REF_LDPL_PLAN_MTH (
    CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier for client',
    CY_MONTH NUMBER(38,0) NOT NULL COMMENT 'Month number',
    CURRENCY_ISO_CD VARCHAR(3) NOT NULL COMMENT 'ISO code for the currency of the client.',
    PRICE_CHANGE_LP_REV_PLAN_VAL NUMBER(18,5)  COMMENT 'Plan for LidlPlus Price Change divided by LidlPlus net turnover. 5% is stored as 5.0.',
    PRICE_CHANGE_TOT_REV_PLAN_VAL NUMBER(18,5)  COMMENT 'Plan for LidlPlus Price Change divided by total net turnover. 5% is stored as 5.0. Used for data patch',
    TOTAL_NET_PLAN_VAL NUMBER(18,5) COMMENT 'Plan for total revenue net value. 5% is stored as 5.0. Used for data patch', 
    TOTAL_NEW_REG_CNT_PLAN NUMBER(18,5) COMMENT 'Plan value for LidlPlus registered users. Used for data patch',
    LP_CUSTOMER_SID_CNT_PLAN NUMBER(18,5) COMMENT 'Plan value for LidlPlus identified customers. Used for data patch',
    DWH_LOAD_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Load identifier',
    DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Row created time',
    DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Row update time',
    CONSTRAINT PK_LDPL_PLAN_MTH PRIMARY KEY (CLIENT_ID, CY_MONTH)
    NOT ENFORCED  
);
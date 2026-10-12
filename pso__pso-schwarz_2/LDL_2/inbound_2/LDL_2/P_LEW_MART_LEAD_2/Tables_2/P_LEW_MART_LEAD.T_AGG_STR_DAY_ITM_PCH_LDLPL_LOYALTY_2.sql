/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for T_AGG_STR_DAY_ITM_PCH_LDLPL_LOYALTY.
#----------------------------------------------------------------------------
# History:
#  1.0  11.03.2026    Bialek, Aleksander           Initial version AD Work Item_2 nr:789392
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_MART_LEAD.T_AGG_STR_DAY_ITM_PCH_LDLPL_LOYALTY_2 (
	CLIENT_ID INTEGER,
	DWH_CAL_DT DATE,
	LOC_SID NUMBER(38,0),
	ITEM_SID NUMBER(38,0),
	PCWO_REASON_ID INTEGER,
	DISCOUNT_VAL_NET NUMBER(18,5),
	DWH_UPDATED TIMESTAMP(6) NOT NULL
);
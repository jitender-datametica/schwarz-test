/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for T_AGG_WH_DAY_PCH_LDLPL_LOYALTY.
#----------------------------------------------------------------------------
# History:
#  1.0  12.03.2026    Bialek, Aleksander           Initial version AD Work Item nr:789392
#----------------------------------------------------------------------------
*/



CREATE TABLE P_LEW_MART_LEAD.T_AGG_WH_DAY_PCH_LDLPL_LOYALTY (
	CLIENT_ID INTEGER,
	LOC_SID_WH NUMBER(38,0),
	WH_ID NUMBER(38,0),
	ASPECT_ID NUMBER(38,0),
	PCWO_REASON_ID INTEGER,
	CURRENCY_ISO_CD VARCHAR(3) COLLATE 'en-ci',
	DWH_CAL_DT DATE,
	DISCOUNT_VAL_NET NUMBER(38,11)
);
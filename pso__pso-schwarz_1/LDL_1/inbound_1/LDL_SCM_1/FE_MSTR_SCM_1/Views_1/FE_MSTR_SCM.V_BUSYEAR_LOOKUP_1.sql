CREATE OR REPLACE VIEW FE_MSTR_SCM.V_BUSYEAR_LOOKUP_1(
	CLIENT_ID COMMENT 'Identification of country_1',
	BA_NR COMMENT 'order number',
	IAN COMMENT 'international article number',
	BUSYEAR COMMENT 'business year',
	STARTMONTH COMMENT 'definition of business year - starting month',
	ENDMONTH COMMENT 'definition of business year - ending month',
	CAL_MONTH COMMENT 'current month'
) COMMENT = 'mapping of month attribute to solve the doubled sales_1 quantity issue'
AS
SELECT
	CLIENT.CLIENT_ID,
	BA_NR,
	IAN,
	BYR.BUSYEAR,
	START_MONTH,
   	END_MONTH,
    MTH.CY_MONTH AS CAL_MONTH
FROM CORE_REL.T_BUSYEAR_LOOKUP_1 AS BYR
INNER JOIN core_rel.v_cal_month_1 AS MTH 
ON MTH.CY_MONTH BETWEEN BYR.START_MONTH AND BYR.END_MONTH
INNER JOIN CORE.V_CLIENT_1 AS CLIENT 
ON BYR.LAND_1=CLIENT.COUNTRY_CD
;
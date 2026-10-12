CREATE OR REPLACE FUNCTION LDL_PRODUCTION.P_LEW_MART_PIT.F_GETPITADVPERIODENDDATE(""PWAWIADVSTARTDATE"" DATE, ""PADPADVSTARTDATE"" DATE, ""PADPADVENDDATE"" DATE, ""PDAYS"" NUMBER(38,0))
RETURNS DATE
LANGUAGE SQL
AS '
		IFF(pWawiAdvStartDate = pAdpAdvStartDate AND pAdpAdvEndDate<=dateadd(''day'', pDays , pWawiAdvStartDate) AND pAdpAdvEndDate>=pAdpAdvStartDate, pAdpAdvEndDate,  dateadd(''day'', pDays , pWawiAdvStartDate))
			
	';
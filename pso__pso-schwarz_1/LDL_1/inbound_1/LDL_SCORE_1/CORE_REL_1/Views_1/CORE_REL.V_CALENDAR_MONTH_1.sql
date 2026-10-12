CREATE OR REPLACE VIEW CORE_REL.V_CALENDAR_MONTH_1
AS
SELECT
	year.YEAR * 100 + month.MONTH AS CY_MONTH
	,month.MONTH AS MONTH_OF_YEAR
	,year.YEAR AS CY
	,CASE 
		WHEN month.MONTH BETWEEN 1 AND 2 THEN year.YEAR - 1
		ELSE year.YEAR
	END BUS_YEAR
	,month.MONTH_OF_YEAR_NAME || ' ' || year.YEAR AS CY_MONTH_DESCR
	,month.MONTH_OF_YEAR_SHORT || ' ' || year.YEAR AS CY_MONTH_SHORT_DESCR
	,DATEDIFF(MONTH,CURRENT_DATE,TO_DATE(CY_MONTH::VARCHAR,'YYYYMM')) CY_MONTH_SEQ
FROM 
	(
	SELECT 
		ROW_NUMBER() OVER(ORDER BY 1) AS MONTH
		,DECODE(MONTH,
		    1, 'Januar',
		    2, 'Februar',
		    3, 'März',
		    4, 'April',
		    5, 'Mai',
		    6, 'Juni',
		    7, 'Juli',
		    8, 'August',
		    9, 'September',
		    10, 'Oktober',
		    11, 'November',
		    12, 'Dezember'
		    ) AS MONTH_OF_YEAR_NAME
		    ,DECODE(MONTH,
		    1, 'Jan',
		    2, 'Feb',
		    3, 'Mär',
		    4, 'Apr',
		    5, 'Mai',
		    6, 'Jun',
		    7, 'Jul',
		    8, 'Aug',
		    9, 'Sep',
		    10, 'Okt',
		    11, 'Nov',
		    12, 'Dez'
		    ) AS MONTH_OF_YEAR_SHORT
	FROM TABLE(generator(rowcount => 12))
	) month
	CROSS JOIN
	(
	SELECT 
		YEAR(CURRENT_DATE) - 10
		+ ROW_NUMBER() OVER(ORDER BY 1) AS YEAR
	FROM TABLE(generator(rowcount => 12))
	) year;
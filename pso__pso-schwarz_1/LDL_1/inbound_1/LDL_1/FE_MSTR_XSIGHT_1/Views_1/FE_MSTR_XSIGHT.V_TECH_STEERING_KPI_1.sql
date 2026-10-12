CREATE
	OR REPLACE VIEW FE_MSTR_XSIGHT.V_TECH_STEERING_KPI_1 (
	DASHBOARD
	,GROUP_ID
	,GROUP_NAME
	,GROUP_NAME_EN
	,SUBGROUP_ID
	,SUBGROUP_NAME
	,KPI_ID
	,KPI_NAME_UNIQUE
	,KPI_NAME
	,KPI_NAME_EN
	) AS

SELECT DISTINCT DASHBOARD
	,COALESCE(GROUP_ID, (CASE 
				WHEN KPI_NAME LIKE '%Lidl%'
					THEN 2
				WHEN KPI_NAME LIKE '%Benchmark%'
					THEN 3
				ELSE 1
				END
			)) AS GROUP_ID
	,COALESCE(GROUP_NAME, (CASE 
				WHEN KPI_NAME LIKE '%Lidl%'
					THEN 'Lidl'
				WHEN KPI_NAME LIKE '%Benchmark%'
					THEN 'Benchmark'
				ELSE 'Gesamtmarkt'
				END
			)) AS GROUP_NAME
	,COALESCE(GROUP_NAME_EN, (CASE 
				WHEN KPI_NAME LIKE '%Lidl%'
					THEN 'Lidl'
				WHEN KPI_NAME LIKE '%Benchmark%'
					THEN 'Benchmark'
				ELSE 'Total Market'
				END
			)) AS GROUP_NAME_EN
	,COALESCE(SUBGROUP_ID, (CASE 
				WHEN KPI_NAME LIKE '%Umsatz%'
					THEN 3
				WHEN KPI_NAME LIKE '%konv%'
					THEN 2
                WHEN KPI_NAME LIKE '%Pack%'
					THEN 1
                WHEN KPI_NAME LIKE '%verkaufend%'
					THEN 4
				ELSE NULL
				END
			)) AS SUBGROUP_ID
	,COALESCE(SUBGROUP_NAME, (CASE
				WHEN KPI_NAME LIKE '%Umsatz%'
					THEN 'Umsatz'
				WHEN KPI_NAME LIKE '%konv%'
					THEN 'Absatz konv.'
				WHEN KPI_NAME LIKE '%Pack%'
					THEN 'Absatz in Pack'
                WHEN KPI_NAME LIKE '%verkaufend%'
					THEN 'Anteil Ø Anz. Artikel_1'
                ELSE NULL
				END
			)) AS SUBGROUP_NAME
    ,KPI_ID
    ,CONCAT	(
		KPI_NAME
		, ' '
		, GROUP_NAME
	) AS KPI_NAME_UNIQUE
	,REPLACE(KPI_NAME, '?', 'Δ') AS KPI_NAME
    ,REPLACE(KPI_NAME_EN, '?', 'Δ') AS KPI_NAME_EN
FROM FE_MSTR_XSIGHT.T_TECH_STEERING_KPI_1
WHERE DASHBOARD IN (
		'Item_1 Ranking - Tabelle'
		,'Feature Analysis - Tabelle'
		,'New Brand_1 Ranking - Tabelle'
		);
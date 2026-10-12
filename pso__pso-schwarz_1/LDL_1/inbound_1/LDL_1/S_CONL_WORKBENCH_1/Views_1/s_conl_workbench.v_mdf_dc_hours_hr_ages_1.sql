CREATE OR REPLACE VIEW S_CONL_WORKBENCH.V_MDF_DC_HOURS_HR_AGES_1
AS
(SELECT
x.business_year
,x.booking_month
,x.warehouse_nr
,x.cost_center
,x.Headcount_21min_lj
,x.Headcount_21plus_lj
,x.Headcount_21min_vj
,x.Headcount_21plus_vj
FROM
(SELECT
COALESCE(lj.business_year,vj.business_year+1) AS business_year
,COALESCE(lj.cy_month,vj.cy_month+100) AS booking_month
,CASE
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '10%' THEN 1
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '20%' THEN 2
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '30%' THEN 3
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '31%' THEN 3
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '40%' THEN 4
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '41%' THEN 4
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '50%' THEN 5
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '60%' THEN 6
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '90%' THEN 9
ELSE 99 END AS warehouse_nr
,COALESCE(lj.cost_center,vj.cost_center) AS cost_center
,SUM(Headcount_21min_lj) AS Headcount_21min_lj
,SUM(Headcount_21plus_lj) AS Headcount_21plus_lj
,SUM(Headcount_21min_vj) AS Headcount_21min_vj
,SUM(Headcount_21plus_vj) AS Headcount_21plus_vj
FROM
(SELECT
 LJ0.cost_center
,LJ0.business_year
,LJ0.cy_month
,LJ0.status_employment
,SUM(LJ0.headcount) AS headcount
,SUM(LJ0.age) AS age
,SUM(LJ0.headcount)/SUM(age) AS avg_age
,SUM(CASE WHEN LJ0.avg_age <21 THEN LJ0.headcount ELSE NULL END) AS Headcount_21min_lj
,SUM(CASE WHEN LJ0.avg_age >= 21 THEN LJ0.headcount ELSE NULL END) AS Headcount_21plus_lj 
FROM
(SELECT
cost_center
,CASE
WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 
THEN CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1 AS INT)
ELSE CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4)) AS INT) END AS business_year 
,cy_month
,date_birth
,status_employment
,SUM(CASE WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1 ELSE 0 END) AS headcount
,SUM(CASE WHEN status_employment=3 THEN 
CASE WHEN EXTRACT(MONTH FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD'))>= EXTRACT(MONTH FROM hr_lead.date_birth)
THEN (EXTRACT (YEAR FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD')) - EXTRACT (YEAR FROM hr_lead.date_birth))
ELSE ((EXTRACT (YEAR FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD')) - EXTRACT (YEAR FROM hr_lead.date_birth))-1) END
ELSE NULL END) AS age
,CASE WHEN SUM(CASE WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1 ELSE 0 END)= 0 THEN 0 ELSE
SUM(CASE WHEN status_employment=3 THEN 
CASE WHEN EXTRACT(MONTH FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD'))>= EXTRACT(MONTH FROM hr_lead.date_birth)
THEN (EXTRACT (YEAR FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD')) - EXTRACT (YEAR FROM hr_lead.date_birth))
ELSE ((EXTRACT (YEAR FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD')) - EXTRACT (YEAR FROM hr_lead.date_birth))-1) END
ELSE NULL END)/ SUM(CASE WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1 ELSE 0 END) END AS avg_age
FROM s_conl_workbench.v_hr_po_lead_base_1 AS hr_lead
WHERE 1=1
AND RIGHT(TRIM(cost_center),4) IN ('9648','9668') -- was ('9628','9648','9668','9698')
AND CASE WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 
		THEN CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1 AS INT)
		ELSE CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4)) AS INT) END = (SELECT Y.max_year FROM
																			(SELECT MAX(CASE WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 
																			THEN CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1 AS INT)
																			ELSE CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4)) AS INT) END) AS max_year
																			FROM s_conl_workbench.v_hr_po_lead_base_1
																			WHERE 1=1
																			AND RIGHT(TRIM(cost_center),4) IN ('9648','9668')) AS Y)
GROUP BY
cost_center
,cy_month
,date_birth
,status_employment
) AS LJ0
GROUP BY
 LJ0.cost_center
,LJ0.business_year
,LJ0.cy_month
,LJ0.status_employment
) AS LJ
FULL OUTER JOIN
(SELECT
 VJ0.cost_center
,VJ0.business_year
,VJ0.cy_month
,vJ0.status_employment
,SUM(VJ0.headcount) AS headcount
,SUM(VJ0.age) AS age
,SUM(VJ0.headcount)/SUM(age) AS avg_age
,SUM(CASE WHEN VJ0.avg_age <21 THEN VJ0.headcount ELSE NULL END) AS Headcount_21min_vj
,SUM(CASE WHEN VJ0.avg_age >= 21 THEN VJ0.headcount ELSE NULL END) AS Headcount_21plus_vj 
FROM
(SELECT
cost_center
,CASE
WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1 AS INT)
ELSE CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4)) AS INT) END AS business_year 
,cy_month
,date_birth
,status_employment
,SUM(CASE WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1 ELSE 0 END) AS headcount
,SUM(CASE WHEN status_employment=3 THEN 
CASE WHEN EXTRACT(MONTH FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD'))>= EXTRACT(MONTH FROM hr_lead.date_birth)
THEN (EXTRACT (YEAR FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD')) - EXTRACT (YEAR FROM hr_lead.date_birth))
ELSE ((EXTRACT (YEAR FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD')) - EXTRACT (YEAR FROM hr_lead.date_birth))-1) END
ELSE NULL END) AS age
,CASE WHEN SUM(CASE WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1 ELSE 0 END)= 0 THEN 0 ELSE
SUM(CASE WHEN status_employment=3 THEN 
CASE WHEN EXTRACT(MONTH FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD'))>= EXTRACT(MONTH FROM hr_lead.date_birth)
THEN (EXTRACT (YEAR FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD')) - EXTRACT (YEAR FROM hr_lead.date_birth))
ELSE ((EXTRACT (YEAR FROM TO_DATE(concat(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM_1-DD')) - EXTRACT (YEAR FROM hr_lead.date_birth))-1) END 
ELSE NULL END)/ SUM(CASE WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1 ELSE 0 END) END AS avg_age
FROM s_conl_workbench.v_hr_po_lead_base_1 AS hr_lead
WHERE 1=1
AND RIGHT(TRIM(cost_center),4) IN ('9648','9668') -- was ('9628','9648','9668','9698')
AND CASE WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 
	THEN CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1 AS INT)
	ELSE CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4)) AS INT) END = (SELECT Y.max_year-1 FROM
																		(SELECT MAX(CASE WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 
																		THEN CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1 AS INT)
																		ELSE CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4)) AS INT) END) AS max_year
																		FROM s_conl_workbench.v_hr_po_lead_base_1
																		WHERE 1=1
																		AND RIGHT(TRIM(cost_center),4) IN ('9648','9668')) AS Y)
GROUP BY 
 cost_center
,cy_month
,date_birth
,status_employment
) AS VJ0
GROUP BY
 VJ0.cost_center
,VJ0.business_year
,VJ0.cy_month
,VJ0.status_employment
) AS VJ
ON lj.business_year=vj.business_year+1
AND lj.cy_month=vj.cy_month+100
AND lj.cost_center=vj.cost_center
AND lj.status_employment = vj.status_employment
WHERE 1=1
AND lj.status_employment = 3
GROUP BY
COALESCE(lj.business_year,vj.business_year+1)
,COALESCE(lj.cy_month,vj.cy_month+100)
,CASE
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '10%' THEN 1
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '20%' THEN 2
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '30%' THEN 3
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '31%' THEN 3
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '40%' THEN 4
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '41%' THEN 4
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '50%' THEN 5
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '60%' THEN 6
WHEN COALESCE(LJ.cost_center,VJ.cost_center) LIKE '90%' THEN 9
ELSE 99 END
,COALESCE(lj.cost_center,vj.cost_center)
) AS X
JOIN
(SELECT
MAX(CASE WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 
THEN CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1 AS INT)
ELSE CAST(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4)) AS INT) END) AS business_year 
,MAX(cy_month) AS max_month
FROM s_conl_workbench.v_hr_po_lead_base_1 AS hr_lead
WHERE 1=1
AND RIGHT(TRIM(cost_center),4) IN ('9648','9668')
) AS RPM -- Report month
ON  x.business_year  = rpm.business_year
AND x.booking_month <= rpm.max_month
);
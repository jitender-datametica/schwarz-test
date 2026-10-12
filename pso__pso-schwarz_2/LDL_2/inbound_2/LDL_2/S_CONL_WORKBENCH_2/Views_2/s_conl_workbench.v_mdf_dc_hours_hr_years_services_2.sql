CREATE OR REPLACE VIEW S_CONL_WORKBENCH.V_MDF_DC_HOURS_HR_YEARS_SERVICES_2
AS
(SELECT
x.business_year
,x.booking_month
,x.warehouse_nr
,x.cost_center
,x.headcount_lj
,x.headcount_vj
,x.years_service_lj
,x.years_service_vj
,x.Fte_parttime_factor_lj
,x.Fte_parttime_factor_vj
FROM
(SELECT
COALESCE(lj.business_year,vj.business_year+1) AS business_year
,COALESCE(lj.cy_month,vj.cy_month+100) AS booking_month
,CASE
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '10' THEN 1
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '20' THEN 2
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '30' THEN 3
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '31' THEN 3
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '40' THEN 4
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '41' THEN 4
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '50' THEN 5
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '60' THEN 6
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '90' THEN 9
ELSE 99 END AS warehouse_nr
,COALESCE(lj.cost_center,vj.cost_center) AS cost_center
,SUM(lj.headcount) AS headcount_lj
,SUM(vj.headcount) AS headcount_vj
,SUM(lj.years_joining) AS years_service_lj
,SUM(vj.years_joining) AS years_service_vj
,CAST(SUM(lj.parttime_factor) AS Number(38,5)) AS Fte_parttime_factor_lj
,CAST(SUM(vj.parttime_factor) AS Number(38,5)) AS Fte_parttime_factor_vj
FROM
(SELECT
cost_center
,CASE
WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END AS business_year
,cy_month
,date_joining
,status_employment
,CAST(SUM(parttime_factor) AS Number(38,5)) AS parttime_factor
,SUM(CASE
WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1
ELSE 0 END) AS headcount
,SUM(CASE
WHEN status_employment=3 THEN CASE
WHEN EXTRACT(MONTH FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD'))>= EXTRACT(MONTH FROM hr_lead.date_joining) THEN (EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD')) - EXTRACT (YEAR FROM hr_lead.date_joining))
ELSE ((EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD')) - EXTRACT (YEAR FROM hr_lead.date_joining))-1) END
ELSE NULL END) AS years_joining
,SUM(CASE
WHEN status_employment=3 THEN EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM hr_lead.date_joining)
ELSE NULL END) AS years_service
,CASE
WHEN SUM(CASE
WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1
ELSE 0 END)= 0 THEN NULL
ELSE
SUM(CASE
WHEN status_employment=3 THEN CASE
WHEN EXTRACT(MONTH FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD'))>= EXTRACT(MONTH FROM hr_lead.date_joining) THEN (EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD')) - EXTRACT (YEAR FROM hr_lead.date_joining))
ELSE ((EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD')) - EXTRACT (YEAR FROM hr_lead.date_joining))-1) END
ELSE NULL END)/ SUM(CASE
WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1
ELSE 0 END) END AS avg_years_joining
FROM s_conl_workbench.v_hr_po_lead_base_2 AS hr_lead
WHERE 1=1
AND RIGHT(TRIM(cost_center),4) IN ('9648','9668') --was ('9628','9648','9668','9698')
AND CASE
WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END =(SELECT
Y.max_year
FROM
(SELECT
MAX(CASE
WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END) AS max_year
FROM s_conl_workbench.v_hr_po_lead_base_2
WHERE 1=1
AND RIGHT(TRIM(cost_center),4) IN ('9648','9668')) AS Y)
GROUP BY
cost_center
,cy_month
,date_joining
,status_employment
)AS LJ
FULL OUTER JOIN
(SELECT
cost_center
,CASE
WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END AS business_year
,cy_month
,date_joining
,status_employment
,CAST(SUM(parttime_factor) AS Number(38,5)) AS parttime_factor
,SUM(CASE
WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1
ELSE 0 END) AS headcount
,SUM(CASE
WHEN status_employment=3 THEN CASE
WHEN EXTRACT(MONTH FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD'))>= EXTRACT(MONTH FROM hr_lead.date_joining) THEN (EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD')) - EXTRACT (YEAR FROM hr_lead.date_joining))
ELSE ((EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD')) - EXTRACT (YEAR FROM hr_lead.date_joining))-1) END
ELSE NULL END) AS years_joining
,CASE
WHEN SUM(CASE
WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1
ELSE 0 END)= 0 THEN NULL
ELSE
SUM(CASE
WHEN status_employment=3 THEN CASE
WHEN EXTRACT(MONTH FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD'))>= EXTRACT(MONTH FROM hr_lead.date_joining) THEN (EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD')) - EXTRACT (YEAR FROM hr_lead.date_joining))
ELSE ((EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(cy_month)),2),'-01'),'YYYY-MM_2-DD')) - EXTRACT (YEAR FROM hr_lead.date_joining))-1) END
ELSE NULL END)/ SUM(CASE
WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1
ELSE 0 END) END AS avg_years_joining
FROM s_conl_workbench.v_hr_po_lead_base_2 AS hr_lead
WHERE 1=1
AND RIGHT(TRIM(cost_center),4) IN ('9648','9668') --was ('9628','9648','9668','9698')
AND CASE
WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END =(SELECT
Y.max_year-1
FROM
(SELECT
MAX(CASE
WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END) AS max_year
FROM s_conl_workbench.v_hr_po_lead_base_2
WHERE 1=1
AND RIGHT(TRIM(cost_center),4) IN ('9648','9668')) AS Y)
GROUP BY
cost_center
,cy_month
,date_joining
,status_employment
)
AS VJ
ON lj.business_year=vj.business_year+1
AND lj.cy_month=vj.cy_month+100
AND lj.cost_center=vj.cost_center
AND lj.date_joining=vj.date_joining
AND lj.status_employment = vj.status_employment
WHERE 1=1
AND lj.status_employment = 3
GROUP BY
COALESCE(lj.business_year,vj.business_year+1)
,COALESCE(lj.cy_month,vj.cy_month+100)
, CASE
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '10' THEN 1
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '20' THEN 2
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '30' THEN 3
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '31' THEN 3
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '40' THEN 4
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '41' THEN 4
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '50' THEN 5
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '60' THEN 6
WHEN SUBSTR( COALESCE(LJ.cost_center,VJ.cost_center), 1, 2) = '90' THEN 9
ELSE 99 END
,COALESCE(lj.cost_center,vj.cost_center)
) AS X
JOIN
(SELECT
MAX(CASE
WHEN TO_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(TO_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END) AS business_year
,MAX(cy_month) AS max_month
FROM s_conl_workbench.v_hr_po_lead_base_2
WHERE 1=1
AND RIGHT(TRIM(cost_center),4) IN ('9648','9668')
) AS RPM -- Report month
ON  x.business_year  = rpm.business_year
AND x.booking_month <= rpm.max_month
);



CREATE OR REPLACE VIEW S_CONL_WORKBENCH.V_MDF_DC_HOURS_HR_INTERN
AS
(SELECT
x.business_year
,x.booking_month
,x.warehouse_nr
,x.cost_center
,x.employee_subgroup
,x.head_count_lj
,x.head_count_vj
,x.head_count_hk_lj
,x.head_count_hk_vj
,x.temporary_helper_12_hours_lj
,x.temporary_helper_12_hours_vj
,x.contract_non_permanent_ft_lj
,x.contract_non_permanent_ft_vj
,x.contract_non_permanent_pt_lj
,x.contract_non_permanent_pt_vj
,x.contract_non_permanent_hk_lj
,x.contract_non_permanent_hk_vj
,x.contract_permanent_ft_lj
,x.contract_permanent_ft_vj
,x.contract_permanent_pt_lj
,x.contract_permanent_pt_vj
,x.contract_permanent_0_hours_lj
,x.contract_permanent_0_hours_vj
,x.contract_permanent_hk_lj
,x.contract_permanent_hk_vj
,x.years_service_lj
,x.years_service_vj
,x.amount_women_diversity_lj
,x.amount_women_diversity_vj
,x.amount_total_diversity_lj
,x.amount_total_diversity_vj
,x.fte_hours_month_lj
,x.fte_hours_month_vj
,x.FTE_lj
,x.FTE_vj
,x.employee_inflow_lj
,x.employee_inflow_vj
,x.employee_outflow_lj
,x.employee_outflow_vj
,x.CLA_hourly_wage_lj
,x.CLA_hourly_wage_vj
,x.hours_nett_lj
,x.hours_nett_vj
,x.hours_gross_lj
,x.hours_gross_vj
,x.hours_gross_excl_hk_lj
,x.hours_gross_excl_hk_vj
,x.hours_overtime_lj
,x.hours_overtime_vj
,x.hours_worked_hk_lj
,x.hours_worked_hk_vj
,x.hours_gross_hk_lj
,x.hours_gross_hk_vj
,x.hours_vacation_lj
,x.hours_vacation_vj
,x.hours_holiday_lj
,x.hours_holiday_vj
,x.hours_sick_lj
,x.hours_sick_vj
,x.hours_sick_absent_9GLC_lj
,x.hours_sick_absent_9GLC_vj
,x.hours_other_lj
,x.hours_other_vj
,x.hours_contract_lj
,x.hours_contract_vj
,x.hours_contract_hk_lj
,x.hours_contract_hk_vj
,x.hours_contract_excl_hk_lj
,x.hours_contract_excl_hk_vj
,x.surcharge_overtime_lj
,x.surcharge_overtime_vj
,x.surcharge_late_night_hours_lj
,x.surcharge_late_night_hours_vj
FROM
(SELECT
COALESCE(lj.business_year,vj.business_year+1) AS business_year
,COALESCE(lj.booking_month,vj.booking_month+100) AS booking_month
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
,COALESCE(lj.employee_subgroup,vj.employee_subgroup) AS employee_subgroup
,SUM(lj.head_count) AS head_count_lj
,SUM(vj.head_count) AS head_count_vj
,SUM(lj.head_count_hk) AS head_count_hk_lj
,SUM(vj.head_count_hk) AS head_count_hk_vj
,SUM(lj.temporary_helper_12_hours) AS temporary_helper_12_hours_lj
,SUM(vj.temporary_helper_12_hours) AS temporary_helper_12_hours_vj
,SUM(lj.contract_non_permanent_ft) AS contract_non_permanent_ft_lj
,SUM(vj.contract_non_permanent_ft) AS contract_non_permanent_ft_vj
,SUM(lj.contract_non_permanent_pt) AS contract_non_permanent_pt_lj
,SUM(vj.contract_non_permanent_pt) AS contract_non_permanent_pt_vj
,SUM(lj.contract_non_permanent_hk) AS contract_non_permanent_hk_lj
,SUM(vj.contract_non_permanent_hk) AS contract_non_permanent_hk_vj
,SUM(lj.contract_permanent_ft) AS contract_permanent_ft_lj
,SUM(vj.contract_permanent_ft) AS contract_permanent_ft_vj
,SUM(lj.contract_permanent_pt) AS contract_permanent_pt_lj
,SUM(vj.contract_permanent_pt) AS contract_permanent_pt_vj
,SUM(lj.contract_permanent_0_hours) AS contract_permanent_0_hours_lj
,SUM(vj.contract_permanent_0_hours) AS contract_permanent_0_hours_vj
,SUM(lj.contract_permanent_hk ) AS contract_permanent_hk_lj
,SUM(vj.contract_permanent_hk ) AS contract_permanent_hk_vj
,SUM(lj.years_service) AS years_service_lj
,SUM(vj.years_service) AS years_service_vj
,SUM(lj.amount_women_diversity) AS amount_women_diversity_lj
,SUM(vj.amount_women_diversity) AS amount_women_diversity_vj
,SUM(lj.amount_total_diversity) AS amount_total_diversity_lj
,SUM(vj.amount_total_diversity) AS amount_total_diversity_vj
,CAST(AVG(lj.fte_hours_month) AS NUMBER(38,5)) AS fte_hours_month_lj
,CAST(AVG(vj.fte_hours_month) AS NUMBER(38,5)) AS fte_hours_month_vj
,CAST(SUM(lj.hours_contract)/ AVG(lj.fte_hours_month) AS NUMBER(38,5)) AS FTE_lj /* Alignement to Teradata: replaced lj.hours_gross with lj.hours_contract */
,CAST(SUM(vj.hours_contract)/ AVG(vj.fte_hours_month) AS NUMBER(38,5)) AS FTE_vj /* Alignement to Teradata: replaced vj.hours_gross with vj.hours_contract */
,SUM(lj.employee_inflow) AS employee_inflow_lj
,SUM(vj.employee_inflow) AS employee_inflow_vj
,SUM(lj.employee_outflow) AS employee_outflow_lj
,SUM(vj.employee_outflow) AS employee_outflow_vj
,CASE
WHEN AVG(lj.CLA_hourly_wage) >0 THEN CAST(AVG(lj.CLA_hourly_wage) AS NUMBER(38,5))
ELSE NULL END AS  CLA_hourly_wage_lj
,CASE
WHEN AVG(vj.CLA_hourly_wage) >0 THEN CAST(AVG(vj.CLA_hourly_wage) AS NUMBER(38,5))
ELSE NULL END AS  CLA_hourly_wage_vj
,CAST(SUM(lj.hours_nett) AS NUMBER(38,5)) AS hours_nett_lj
,CAST(SUM(vj.hours_nett) AS NUMBER(38,5)) AS hours_nett_vj
,CAST(SUM(lj.hours_gross) AS NUMBER(38,5)) AS hours_gross_lj
,CAST(SUM(vj.hours_gross) AS NUMBER(38,5)) AS hours_gross_vj
,CAST(SUM(lj.hours_gross_excl_hk) AS NUMBER(38,5)) AS hours_gross_excl_hk_lj
,CAST(SUM(vj.hours_gross_excl_hk) AS NUMBER(38,5)) AS hours_gross_excl_hk_vj
,CAST(SUM(lj.hours_overtime) AS NUMBER(38,5)) AS hours_overtime_lj
,CAST(SUM(vj.hours_overtime) AS NUMBER(38,5)) AS hours_overtime_vj
,CAST(SUM(lj.hours_worked_hk) AS NUMBER(38,5)) AS hours_worked_hk_lj
,CAST(SUM(vj.hours_worked_hk) AS NUMBER(38,5)) AS hours_worked_hk_vj
,CAST(SUM(lj.hours_gross_hk) AS NUMBER(38,5)) AS hours_gross_hk_lj
,CAST(SUM(vj.hours_gross_hk) AS NUMBER(38,5)) AS hours_gross_hk_vj
,CAST(SUM(lj.hours_vacation) AS NUMBER(38,5)) AS hours_vacation_lj
,CAST(SUM(vj.hours_vacation) AS NUMBER(38,5)) AS hours_vacation_vj
,CAST(SUM(lj.hours_holiday) AS NUMBER(38,5)) AS hours_holiday_lj
,CAST(SUM(vj.hours_holiday) AS NUMBER(38,5)) AS hours_holiday_vj
,CAST(SUM(lj.hours_sick) AS NUMBER(38,5)) AS hours_sick_lj
,CAST(SUM(vj.hours_sick) AS NUMBER(38,5)) AS hours_sick_vj
,CAST(SUM(lj.hours_sick_absent_9GLC) AS NUMBER(38,5)) AS hours_sick_absent_9GLC_lj
,CAST(SUM(vj.hours_sick_absent_9GLC) AS NUMBER(38,5)) AS hours_sick_absent_9GLC_vj
,CAST(SUM(lj.hours_other) AS NUMBER(38,5)) AS hours_other_lj
,CAST(SUM(vj.hours_other) AS NUMBER(38,5)) AS hours_other_vj
,CAST(SUM(lj.hours_contract) AS NUMBER(38,5)) AS hours_contract_lj
,CAST(SUM(vj.hours_contract) AS NUMBER(38,5)) AS hours_contract_vj
,CAST(SUM(lj.hours_contract_hk) AS NUMBER(38,5)) AS hours_contract_hk_lj
,CAST(SUM(vj.hours_contract_hk) AS NUMBER(38,5)) AS hours_contract_hk_vj
,CAST(SUM(lj.hours_contract_excl_hk) AS NUMBER(38,5)) AS hours_contract_excl_hk_lj
,CAST(SUM(vj.hours_contract_excl_hk) AS NUMBER(38,5)) AS hours_contract_excl_hk_vj
,CAST(SUM(lj.surcharge_overtime) AS NUMBER(38,5)) AS surcharge_overtime_lj
,CAST(SUM(vj.surcharge_overtime) AS NUMBER(38,5)) AS surcharge_overtime_vj
,CAST(SUM(lj.surcharge_late_night_hours) AS NUMBER(38,5)) AS surcharge_late_night_hours_lj
,CAST(SUM(vj.surcharge_late_night_hours) AS NUMBER(38,5)) AS surcharge_late_night_hours_vj
FROM
(SELECT
CASE
WHEN to_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END AS business_year
,cy_month AS  booking_month
,orig_store_nr AS cost_center
,employee_subgroup
,SUM(headcount) AS head_count
,CAST(SUM(CASE
WHEN ( employee_subgroup  LIKE  '%6G%' OR  employee_subgroup  LIKE '%6H%') -- Hulpkrachten --
THEN headcount
ELSE NULL END) AS NUMBER(38,5)) AS head_count_hk
,SUM(temporary_helper_12_hours) AS temporary_helper_12_hours
,SUM(contract_non_permanent_ft) AS contract_non_permanent_ft
,SUM(contract_non_permanent_pt) AS contract_non_permanent_pt
,SUM(contract_non_permanent_hk) AS contract_non_permanent_hk
,SUM(contract_permanent_ft) AS contract_permanent_ft
,SUM(contract_permanent_pt) AS contract_permanent_pt
,SUM(contract_permanent_0_hours) AS contract_permanent_0_hours
,SUM(contract_permanent_hk ) AS contract_permanent_hk
,SUM(years_service) AS years_service
,SUM(amount_women_diversity) AS amount_women_diversity
,SUM(amount_total_diversity) AS amount_total_diversity
,AVG(fte_hours_month) AS fte_hours_month
,SUM(employee_inflow) AS employee_inflow
,SUM(employee_outflow) AS employee_outflow
,CASE
WHEN AVG(CLA_hourly_wage) >0 THEN CAST(AVG(CLA_hourly_wage) AS NUMBER(38,5))
ELSE NULL END AS  CLA_hourly_wage
/* Alignment to Teradata */
,CAST(SUM(hours_contract+hours_overtime +
    (CASE WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
  THEN hours_gross - hours_other - hours_sick - hours_holiday - hours_vacation - hours_overtime 
	ELSE 0 END)) AS NUMBER(38,5)) AS hours_nett
     ,CAST(SUM(hours_gross) AS NUMBER(38,5)) AS hours_gross
,CAST(SUM(CASE
WHEN NOT ( employee_subgroup LIKE ALL ('%6G%','%6H%')) -- Hulpkrachten --
THEN hours_gross
ELSE NULL END) AS NUMBER(38,5)) AS hours_gross_excl_hk
,CAST(SUM(hours_overtime) AS NUMBER(38,5)) AS hours_overtime
,CAST(SUM(CASE
--WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
WHEN employee_subgroup LIKE  ('%6G%' ) OR 
     employee_subgroup LIKE  ('%6H%') -- Hulpkrachten --
THEN hours_gross - hours_other - hours_sick - hours_holiday - hours_vacation - hours_overtime
ELSE NULL END) AS NUMBER(38,5)) AS hours_worked_hk
,CAST(SUM(CASE
--WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
WHEN employee_subgroup LIKE ('%6G%')
         OR employee_subgroup LIKE ('%6H%') -- Hulpkrachten --         
THEN hours_gross
ELSE NULL END) AS NUMBER(38,5)) AS hours_gross_hk
,CAST(SUM(hours_vacation) AS NUMBER(38,5)) AS hours_vacation
,CAST(SUM(hours_holiday) AS NUMBER(38,5)) AS hours_holiday
,CAST(SUM(hours_sick) AS NUMBER(38,5)) AS hours_sick
,CAST(SUM(sick_perc_hours) AS NUMBER(38,5)) AS hours_sick_absent_9GLC
,CAST(SUM(hours_other) AS NUMBER(38,5)) AS hours_other
,CAST(SUM(sick_perc_contract_hours) AS NUMBER(38,5)) AS hours_contract -- Dit schijnen de echte contracturen te zijn
,CAST(SUM(CASE
--WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
WHEN employee_subgroup LIKE ('%6G%')
         OR employee_subgroup LIKE ('%6H%') -- Hulpkrachten --               
THEN sick_perc_contract_hours -- Dit schijnen de echte contracturen te zijn
ELSE NULL END) AS NUMBER(38,5)) AS hours_contract_hk
/* Alignment to Teradata */
,CAST(SUM(CASE WHEN (employee_subgroup NOT LIKE ('%6G%') AND employee_subgroup NOT LIKE ('%6H%')) -- Hulpkrachten --
	     THEN sick_perc_contract_hours -- Dit schijnen de echte contracturen te zijn
	     ELSE NULL END) AS FLOAT) AS hours_contract_excl_hk
,CAST(SUM(surcharge_overtime) AS NUMBER(38,5)) surcharge_overtime
,CAST(SUM(surcharge_late_night_hours) AS NUMBER(38,5))   surcharge_late_night_hours
FROM s_conl_workbench.v_hr_po_lead_emp_flow
WHERE 1=1
AND RIGHT(TRIM(orig_store_nr),4) IN ('9648','9668') -- was ('9628','9648','9668','9698')  
AND CASE
WHEN to_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END =(SELECT
Y.max_year
FROM
(SELECT
MAX(CASE
WHEN to_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END) AS max_year
FROM s_conl_workbench.v_hr_po_lead_emp_flow
WHERE 1=1
AND RIGHT(TRIM(orig_store_nr),4) IN ('9648','9668')) AS Y)
GROUP BY CASE
WHEN to_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END
,cy_month
,orig_store_nr
,employee_subgroup
) AS LJ
FULL OUTER JOIN
(SELECT
CASE
WHEN to_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END AS business_year
,cy_month AS  booking_month
,orig_store_nr AS cost_center
,employee_subgroup
,SUM(headcount) AS head_count
,CAST(SUM(CASE
--WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
WHEN employee_subgroup LIKE  ('%6G%' ) OR 
     employee_subgroup LIKE  ('%6H%') -- Hulpkrachten --          
THEN headcount
ELSE NULL END) AS NUMBER(38,5)) AS head_count_hk
,SUM(temporary_helper_12_hours) AS temporary_helper_12_hours
,SUM(contract_non_permanent_ft) AS contract_non_permanent_ft
,SUM(contract_non_permanent_pt) AS contract_non_permanent_pt
,SUM(contract_non_permanent_hk) AS contract_non_permanent_hk
,SUM(contract_permanent_ft) AS contract_permanent_ft
,SUM(contract_permanent_pt) AS contract_permanent_pt
,SUM(contract_permanent_0_hours) AS contract_permanent_0_hours
,SUM(contract_permanent_hk ) AS contract_permanent_hk
,SUM(years_service) AS years_service
,SUM(amount_women_diversity) AS amount_women_diversity
,SUM(amount_total_diversity) AS amount_total_diversity
,AVG(fte_hours_month) AS fte_hours_month
,SUM(employee_inflow) AS employee_inflow
,SUM(employee_outflow) AS employee_outflow
,CASE
WHEN AVG(CLA_hourly_wage) >0 THEN CAST(AVG(CLA_hourly_wage) AS NUMBER(38,5))
ELSE NULL END AS  CLA_hourly_wage
/* Alignment to Teradata */ 
,CAST(SUM(hours_contract+hours_overtime +
    (CASE WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
  THEN hours_gross - hours_other - hours_sick - hours_holiday - hours_vacation - hours_overtime 
	ELSE 0 END)) AS NUMBER(38,5)) AS hours_nett
     ,CAST(SUM(hours_gross) AS NUMBER(38,5)) AS hours_gross
,CAST(SUM(CASE
WHEN NOT ( employee_subgroup  LIKE ALL ('%6G%','%6H%')) -- Hulpkrachten --
THEN hours_gross
ELSE NULL END) AS NUMBER(38,5)) AS hours_gross_excl_hk
,CAST(SUM(hours_overtime) AS NUMBER(38,5)) AS hours_overtime
,CAST(SUM(CASE
--WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
WHEN employee_subgroup LIKE  ('%6G%' ) OR 
     employee_subgroup LIKE  ('%6H%') -- Hulpkrachten --       
THEN hours_gross - hours_other - hours_sick - hours_holiday - hours_vacation - hours_overtime
ELSE NULL END) AS NUMBER(38,5)) AS hours_worked_hk
,CAST(SUM(CASE
--WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
         WHEN employee_subgroup LIKE  ('%6G%' ) OR 
     employee_subgroup LIKE  ('%6H%') -- Hulpkrachten --        
THEN hours_gross
ELSE NULL END) AS NUMBER(38,5)) AS hours_gross_hk
,CAST(SUM(hours_vacation) AS NUMBER(38,5)) AS hours_vacation
,CAST(SUM(hours_holiday) AS NUMBER(38,5)) AS hours_holiday
,CAST(SUM(hours_sick) AS NUMBER(38,5)) AS hours_sick
,CAST(SUM(sick_perc_hours) AS NUMBER(38,5)) AS hours_sick_absent_9GLC
,CAST(SUM(hours_other) AS NUMBER(38,5)) AS hours_other
,CAST(SUM(sick_perc_contract_hours) AS NUMBER(38,5)) AS hours_contract -- Dit schijnen de echte contracturen te zijn
,CAST(SUM(CASE
--WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
WHEN employee_subgroup LIKE  ('%6G%' ) OR 
     employee_subgroup LIKE  ('%6H%') -- Hulpkrachten --     
THEN sick_perc_contract_hours -- Dit schijnen de echte contracturen te zijn
ELSE NULL END) AS NUMBER(38,5)) AS hours_contract_hk
/* Alignment to Teradata */
,CAST(SUM(CASE WHEN (employee_subgroup NOT LIKE ('%6G%') AND employee_subgroup NOT LIKE ('%6H%')) -- Hulpkrachten --
	     THEN sick_perc_contract_hours -- Dit schijnen de echte contracturen te zijn
	     ELSE NULL END) AS FLOAT) AS hours_contract_excl_hk
,CAST(SUM(surcharge_overtime) AS NUMBER(38,5)) surcharge_overtime
,CAST(SUM(surcharge_late_night_hours) AS NUMBER(38,5))   surcharge_late_night_hours
FROM s_conl_workbench.v_hr_po_lead_emp_flow
WHERE 1=1
AND RIGHT(TRIM(orig_store_nr),4) IN ('9648','9668') -- was ('9628','9648','9668','9698')   
AND CASE
WHEN to_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END = (SELECT
Y.max_year-1
FROM
(SELECT
MAX(CASE
WHEN to_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END) AS max_year
FROM s_conl_workbench.v_hr_po_lead_emp_flow
WHERE 1=1
AND RIGHT(TRIM(orig_store_nr),4) IN ('9648','9668')) AS Y)
GROUP BY CASE
WHEN to_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END
,cy_month
,orig_store_nr
,employee_subgroup
) AS VJ
ON lj.business_year=vj.business_year+1
 AND lj.booking_month=vj.booking_month+100
 AND lj.cost_center=vj.cost_center
 AND lj.employee_subgroup=vj.employee_subgroup
WHERE 1=1
GROUP BY
 COALESCE(lj.business_year,vj.business_year+1)
,COALESCE(lj.booking_month,vj.booking_month+100)
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
,COALESCE(lj.employee_subgroup,vj.employee_subgroup)
) AS X
JOIN
(SELECT
MAX(CASE
WHEN to_NUMBER(RIGHT(TRIM(TO_CHAR(cy_month)),2)) <=2 THEN CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))-1) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
ELSE CAST(TRUNC(to_NUMBER(LEFT(TRIM(TO_CHAR(cy_month)),4))) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END) AS business_year
,MAX(cy_month) AS max_month
FROM s_conl_workbench.v_hr_po_lead_emp_flow
WHERE 1=1
AND RIGHT(TRIM(orig_store_nr),4) IN ('9648','9668')
) AS RPM -- Report month
ON  x.business_year  = rpm.business_year
AND x.booking_month <= rpm.max_month
);
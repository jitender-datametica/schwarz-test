CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mdf_dc_hours_hr_intern_2 AS
/* Alignement to Teradata: replaced lj.hours_gross with lj.hours_contract */
/* Alignement to Teradata: replaced vj.hours_gross with vj.hours_contract */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
-- Hulpkrachten --
 /* Alignment to Teradata */ -- Hulpkrachten --
 -- Hulpkrachten --

-- WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
 -- Hulpkrachten --

-- WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
 -- Hulpkrachten --

-- Dit schijnen de echte contracturen te zijn
 -- WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --

-- Hulpkrachten --
 -- Dit schijnen de echte contracturen te zijn
 /* Alignment to Teradata */ -- Hulpkrachten --

-- Dit schijnen de echte contracturen te zijn
 -- was ('9628','9648','9668','9698')

/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
-- WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
 -- Hulpkrachten --
 /* Alignment to Teradata */
-- Hulpkrachten --
 -- Hulpkrachten --
 -- WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --

-- Hulpkrachten --
 -- WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --
 -- Hulpkrachten --

-- Dit schijnen de echte contracturen te zijn
 -- WHEN employee_subgroup LIKE Any ('%6G%','%6H%') -- Hulpkrachten --

-- Hulpkrachten --
 -- Dit schijnen de echte contracturen te zijn
 /* Alignment to Teradata */ -- Hulpkrachten --

-- Dit schijnen de echte contracturen te zijn
 -- was ('9628','9648','9668','9698')

/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
-- Report month
 SELECT X.business_year,
 X.booking_month,
 X.warehouse_nr,
 X.cost_center,
 X.employee_subgroup,
 X.head_count_lj,
 X.head_count_vj,
 X.head_count_hk_lj,
 X.head_count_hk_vj,
 X.temporary_helper_12_hours_lj,
 X.temporary_helper_12_hours_vj,
 X.contract_non_permanent_ft_lj,
 X.contract_non_permanent_ft_vj,
 X.contract_non_permanent_pt_lj,
 X.contract_non_permanent_pt_vj,
 X.contract_non_permanent_hk_lj,
 X.contract_non_permanent_hk_vj,
 X.contract_permanent_ft_lj,
 X.contract_permanent_ft_vj,
 X.contract_permanent_pt_lj,
 X.contract_permanent_pt_vj,
 X.contract_permanent_0_hours_lj,
 X.contract_permanent_0_hours_vj,
 X.contract_permanent_hk_lj,
 X.contract_permanent_hk_vj,
 X.years_service_lj,
 X.years_service_vj,
 X.amount_women_diversity_lj,
 X.amount_women_diversity_vj,
 X.amount_total_diversity_lj,
 X.amount_total_diversity_vj,
 X.fte_hours_month_lj,
 X.fte_hours_month_vj,
 X.fte_lj,
 X.fte_vj,
 X.employee_inflow_lj,
 X.employee_inflow_vj,
 X.employee_outflow_lj,
 X.employee_outflow_vj,
 X.cla_hourly_wage_lj,
 X.cla_hourly_wage_vj,
 X.hours_nett_lj,
 X.hours_nett_vj,
 X.hours_gross_lj,
 X.hours_gross_vj,
 X.hours_gross_excl_hk_lj,
 X.hours_gross_excl_hk_vj,
 X.hours_overtime_lj,
 X.hours_overtime_vj,
 X.hours_worked_hk_lj,
 X.hours_worked_hk_vj,
 X.hours_gross_hk_lj,
 X.hours_gross_hk_vj,
 X.hours_vacation_lj,
 X.hours_vacation_vj,
 X.hours_holiday_lj,
 X.hours_holiday_vj,
 X.hours_sick_lj,
 X.hours_sick_vj,
 X.hours_sick_absent_9glc_lj,
 X.hours_sick_absent_9glc_vj,
 X.hours_other_lj,
 X.hours_other_vj,
 X.hours_contract_lj,
 X.hours_contract_vj,
 X.hours_contract_hk_lj,
 X.hours_contract_hk_vj,
 X.hours_contract_excl_hk_lj,
 X.hours_contract_excl_hk_vj,
 X.surcharge_overtime_lj,
 X.surcharge_overtime_vj,
 X.surcharge_late_night_hours_lj,
 X.surcharge_late_night_hours_vj
FROM (SELECT COALESCE(LJ.business_year, VJ.business_year + 1) AS business_year,
   COALESCE(LJ.booking_month, VJ.booking_month + 100) AS booking_month,
    CASE
    WHEN SUBSTR(COALESCE(LJ.cost_center, VJ.cost_center), 1, 2) = '10'
    THEN 1
    WHEN SUBSTR(COALESCE(LJ.cost_center, VJ.cost_center), 1, 2) = '20'
    THEN 2
    WHEN SUBSTR(COALESCE(LJ.cost_center, VJ.cost_center), 1, 2) = '30'
    THEN 3
    WHEN SUBSTR(COALESCE(LJ.cost_center, VJ.cost_center), 1, 2) = '31'
    THEN 3
    WHEN SUBSTR(COALESCE(LJ.cost_center, VJ.cost_center), 1, 2) = '40'
    THEN 4
    WHEN SUBSTR(COALESCE(LJ.cost_center, VJ.cost_center), 1, 2) = '41'
    THEN 4
    WHEN SUBSTR(COALESCE(LJ.cost_center, VJ.cost_center), 1, 2) = '50'
    THEN 5
    WHEN SUBSTR(COALESCE(LJ.cost_center, VJ.cost_center), 1, 2) = '60'
    THEN 6
    WHEN SUBSTR(COALESCE(LJ.cost_center, VJ.cost_center), 1, 2) = '90'
    THEN 9
    ELSE 99
    END AS warehouse_nr,
   COALESCE(LJ.cost_center, VJ.cost_center) AS cost_center,
   COALESCE(LJ.employee_subgroup, VJ.employee_subgroup) AS employee_subgroup,
   SUM(LJ.head_count) AS head_count_lj,
   SUM(VJ.head_count) AS head_count_vj,
   SUM(LJ.head_count_hk) AS head_count_hk_lj,
   SUM(VJ.head_count_hk) AS head_count_hk_vj,
   SUM(LJ.temporary_helper_12_hours) AS temporary_helper_12_hours_lj,
   SUM(VJ.temporary_helper_12_hours) AS temporary_helper_12_hours_vj,
   SUM(LJ.contract_non_permanent_ft) AS contract_non_permanent_ft_lj,
   SUM(VJ.contract_non_permanent_ft) AS contract_non_permanent_ft_vj,
   SUM(LJ.contract_non_permanent_pt) AS contract_non_permanent_pt_lj,
   SUM(VJ.contract_non_permanent_pt) AS contract_non_permanent_pt_vj,
   SUM(LJ.contract_non_permanent_hk) AS contract_non_permanent_hk_lj,
   SUM(VJ.contract_non_permanent_hk) AS contract_non_permanent_hk_vj,
   SUM(LJ.contract_permanent_ft) AS contract_permanent_ft_lj,
   SUM(VJ.contract_permanent_ft) AS contract_permanent_ft_vj,
   SUM(LJ.contract_permanent_pt) AS contract_permanent_pt_lj,
   SUM(VJ.contract_permanent_pt) AS contract_permanent_pt_vj,
   SUM(LJ.contract_permanent_0_hours) AS contract_permanent_0_hours_lj,
   SUM(VJ.contract_permanent_0_hours) AS contract_permanent_0_hours_vj,
   SUM(LJ.contract_permanent_hk) AS contract_permanent_hk_lj,
   SUM(VJ.contract_permanent_hk) AS contract_permanent_hk_vj,
   SUM(LJ.years_service) AS years_service_lj,
   SUM(VJ.years_service) AS years_service_vj,
   SUM(LJ.amount_women_diversity) AS amount_women_diversity_lj,
   SUM(VJ.amount_women_diversity) AS amount_women_diversity_vj,
   SUM(LJ.amount_total_diversity) AS amount_total_diversity_lj,
   SUM(VJ.amount_total_diversity) AS amount_total_diversity_vj,
   ROUND(CAST(AVG(LJ.fte_hours_month) AS BIGNUMERIC), 5) AS fte_hours_month_lj,
   ROUND(CAST(AVG(VJ.fte_hours_month) AS BIGNUMERIC), 5) AS fte_hours_month_vj,
   ROUND(CAST(SUM(LJ.hours_contract) / AVG(LJ.fte_hours_month) AS BIGNUMERIC), 5) AS fte_lj,
   ROUND(CAST(SUM(VJ.hours_contract) / AVG(VJ.fte_hours_month) AS BIGNUMERIC), 5) AS fte_vj,
   SUM(LJ.employee_inflow) AS employee_inflow_lj,
   SUM(VJ.employee_inflow) AS employee_inflow_vj,
   SUM(LJ.employee_outflow) AS employee_outflow_lj,
   SUM(VJ.employee_outflow) AS employee_outflow_vj,
    CASE
    WHEN AVG(LJ.cla_hourly_wage) > 0
    THEN ROUND(CAST(AVG(LJ.cla_hourly_wage) AS BIGNUMERIC), 5)
    ELSE NULL
    END AS cla_hourly_wage_lj,
    CASE
    WHEN AVG(VJ.cla_hourly_wage) > 0
    THEN ROUND(CAST(AVG(VJ.cla_hourly_wage) AS BIGNUMERIC), 5)
    ELSE NULL
    END AS cla_hourly_wage_vj,
   CAST(SUM(LJ.hours_nett) AS BIGNUMERIC) AS hours_nett_lj,
   CAST(SUM(VJ.hours_nett) AS BIGNUMERIC) AS hours_nett_vj,
   CAST(SUM(LJ.hours_gross) AS BIGNUMERIC) AS hours_gross_lj,
   CAST(SUM(VJ.hours_gross) AS BIGNUMERIC) AS hours_gross_vj,
   CAST(SUM(LJ.hours_gross_excl_hk) AS BIGNUMERIC) AS hours_gross_excl_hk_lj,
   CAST(SUM(VJ.hours_gross_excl_hk) AS BIGNUMERIC) AS hours_gross_excl_hk_vj,
   CAST(SUM(LJ.hours_overtime) AS BIGNUMERIC) AS hours_overtime_lj,
   CAST(SUM(VJ.hours_overtime) AS BIGNUMERIC) AS hours_overtime_vj,
   CAST(SUM(LJ.hours_worked_hk) AS BIGNUMERIC) AS hours_worked_hk_lj,
   CAST(SUM(VJ.hours_worked_hk) AS BIGNUMERIC) AS hours_worked_hk_vj,
   CAST(SUM(LJ.hours_gross_hk) AS BIGNUMERIC) AS hours_gross_hk_lj,
   CAST(SUM(VJ.hours_gross_hk) AS BIGNUMERIC) AS hours_gross_hk_vj,
   CAST(SUM(LJ.hours_vacation) AS BIGNUMERIC) AS hours_vacation_lj,
   CAST(SUM(VJ.hours_vacation) AS BIGNUMERIC) AS hours_vacation_vj,
   CAST(SUM(LJ.hours_holiday) AS BIGNUMERIC) AS hours_holiday_lj,
   CAST(SUM(VJ.hours_holiday) AS BIGNUMERIC) AS hours_holiday_vj,
   CAST(SUM(LJ.hours_sick) AS BIGNUMERIC) AS hours_sick_lj,
   CAST(SUM(VJ.hours_sick) AS BIGNUMERIC) AS hours_sick_vj,
   CAST(SUM(LJ.hours_sick_absent_9glc) AS BIGNUMERIC) AS hours_sick_absent_9glc_lj,
   CAST(SUM(VJ.hours_sick_absent_9glc) AS BIGNUMERIC) AS hours_sick_absent_9glc_vj,
   CAST(SUM(LJ.hours_other) AS BIGNUMERIC) AS hours_other_lj,
   CAST(SUM(VJ.hours_other) AS BIGNUMERIC) AS hours_other_vj,
   CAST(SUM(LJ.hours_contract) AS BIGNUMERIC) AS hours_contract_lj,
   CAST(SUM(VJ.hours_contract) AS BIGNUMERIC) AS hours_contract_vj,
   CAST(SUM(LJ.hours_contract_hk) AS BIGNUMERIC) AS hours_contract_hk_lj,
   CAST(SUM(VJ.hours_contract_hk) AS BIGNUMERIC) AS hours_contract_hk_vj,
   ROUND(CAST(SUM(LJ.hours_contract_excl_hk) AS BIGNUMERIC), 5) AS hours_contract_excl_hk_lj,
   ROUND(CAST(SUM(VJ.hours_contract_excl_hk) AS BIGNUMERIC), 5) AS hours_contract_excl_hk_vj,
   CAST(SUM(LJ.surcharge_overtime) AS BIGNUMERIC) AS surcharge_overtime_lj,
   CAST(SUM(VJ.surcharge_overtime) AS BIGNUMERIC) AS surcharge_overtime_vj,
   CAST(SUM(LJ.surcharge_late_night_hours) AS BIGNUMERIC) AS surcharge_late_night_hours_lj,
   CAST(SUM(VJ.surcharge_late_night_hours) AS BIGNUMERIC) AS surcharge_late_night_hours_vj
  FROM (SELECT CASE
      WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
      THEN ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1 AS BIGNUMERIC
          )) AS BIGNUMERIC), 0)
      ELSE ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) AS BIGNUMERIC))
        AS BIGNUMERIC), 0)
      END AS business_year,
     cy_month AS booking_month,
     orig_store_nr AS cost_center,
     employee_subgroup,
     SUM(headcount) AS head_count,
     CAST(SUM(CASE
        WHEN employee_subgroup LIKE '%6G%' OR employee_subgroup LIKE '%6H%'
        THEN headcount
        ELSE NULL
        END) AS BIGNUMERIC) AS head_count_hk,
     SUM(temporary_helper_12_hours) AS temporary_helper_12_hours,
     SUM(contract_non_permanent_ft) AS contract_non_permanent_ft,
     SUM(contract_non_permanent_pt) AS contract_non_permanent_pt,
     SUM(contract_non_permanent_hk) AS contract_non_permanent_hk,
     SUM(contract_permanent_ft) AS contract_permanent_ft,
     SUM(contract_permanent_pt) AS contract_permanent_pt,
     SUM(contract_permanent_0_hours) AS contract_permanent_0_hours,
     SUM(contract_permanent_hk) AS contract_permanent_hk,
     SUM(years_service) AS years_service,
     SUM(amount_women_diversity) AS amount_women_diversity,
     SUM(amount_total_diversity) AS amount_total_diversity,
     AVG(fte_hours_month) AS fte_hours_month,
     SUM(employee_inflow) AS employee_inflow,
     SUM(employee_outflow) AS employee_outflow,
      CASE
      WHEN AVG(cla_hourly_wage) > 0
      THEN ROUND(CAST(AVG(cla_hourly_wage) AS BIGNUMERIC), 5)
      ELSE NULL
      END AS cla_hourly_wage,
     CAST(SUM(hours_contract + hours_overtime + CASE
         WHEN employee_subgroup LIKE '%6G%' OR employee_subgroup LIKE '%6H%'
         THEN hours_gross - hours_other - hours_sick - hours_holiday - hours_vacation - hours_overtime
         ELSE 0
         END) AS BIGNUMERIC) AS hours_nett,
     CAST(SUM(hours_gross) AS BIGNUMERIC) AS hours_gross,
     CAST(SUM(CASE
        WHEN employee_subgroup NOT LIKE '%6G%' OR employee_subgroup NOT LIKE '%6H%'
        THEN hours_gross
        ELSE NULL
        END) AS BIGNUMERIC) AS hours_gross_excl_hk,
     CAST(SUM(hours_overtime) AS BIGNUMERIC) AS hours_overtime,
     CAST(SUM(CASE
        WHEN employee_subgroup LIKE '%6G%' OR employee_subgroup LIKE '%6H%'
        THEN hours_gross - hours_other - hours_sick - hours_holiday - hours_vacation - hours_overtime
        ELSE NULL
        END) AS BIGNUMERIC) AS hours_worked_hk,
     CAST(SUM(CASE
        WHEN employee_subgroup LIKE '%6G%' OR employee_subgroup LIKE '%6H%'
        THEN hours_gross
        ELSE NULL
        END) AS BIGNUMERIC) AS hours_gross_hk,
     CAST(SUM(hours_vacation) AS BIGNUMERIC) AS hours_vacation,
     CAST(SUM(hours_holiday) AS BIGNUMERIC) AS hours_holiday,
     CAST(SUM(hours_sick) AS BIGNUMERIC) AS hours_sick,
     CAST(SUM(sick_perc_hours) AS BIGNUMERIC) AS hours_sick_absent_9glc,
     CAST(SUM(hours_other) AS BIGNUMERIC) AS hours_other,
     CAST(SUM(sick_perc_contract_hours) AS BIGNUMERIC) AS hours_contract,
     CAST(SUM(CASE
        WHEN employee_subgroup LIKE '%6G%' OR employee_subgroup LIKE '%6H%'
        THEN sick_perc_contract_hours
        ELSE NULL
        END) AS BIGNUMERIC) AS hours_contract_hk,
     CAST(SUM(CASE
        WHEN employee_subgroup NOT LIKE '%6G%' AND employee_subgroup NOT LIKE '%6H%'
        THEN sick_perc_contract_hours
        ELSE NULL
        END) AS FLOAT64) AS hours_contract_excl_hk,
     CAST(SUM(surcharge_overtime) AS BIGNUMERIC) AS surcharge_overtime,
     CAST(SUM(surcharge_late_night_hours) AS BIGNUMERIC) AS surcharge_late_night_hours
    FROM ldl_s_conl_workbench.v_hr_po_lead_emp_flow_2
    WHERE RIGHT(TRIM(orig_store_nr), 4) IN ('9648', '9668')
     AND CASE
       WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
       THEN ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1 AS
           BIGNUMERIC)) AS BIGNUMERIC), 0)
       ELSE ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) AS BIGNUMERIC))
         AS BIGNUMERIC), 0)
       END = (SELECT MAX(CASE
          WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
          THEN ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1 AS
              BIGNUMERIC)) AS BIGNUMERIC), 0)
          ELSE ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) AS BIGNUMERIC
              )) AS BIGNUMERIC), 0)
          END) AS max_year
       FROM ldl_s_conl_workbench.v_hr_po_lead_emp_flow_2
       WHERE RIGHT(TRIM(orig_store_nr), 4) IN ('9648', '9668'))
    GROUP BY
     /* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
     business_year,
     booking_month,
     cost_center,
     employee_subgroup) AS LJ
   FULL JOIN (SELECT CASE
      WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
      THEN ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1 AS BIGNUMERIC
          )) AS BIGNUMERIC), 0)
      ELSE ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) AS BIGNUMERIC))
        AS BIGNUMERIC), 0)
      END AS business_year,
     cy_month AS booking_month,
     orig_store_nr AS cost_center,
     employee_subgroup,
     SUM(headcount) AS head_count,
     CAST(SUM(CASE
        WHEN employee_subgroup LIKE '%6G%' OR employee_subgroup LIKE '%6H%'
        THEN headcount
        ELSE NULL
        END) AS BIGNUMERIC) AS head_count_hk,
     SUM(temporary_helper_12_hours) AS temporary_helper_12_hours,
     SUM(contract_non_permanent_ft) AS contract_non_permanent_ft,
     SUM(contract_non_permanent_pt) AS contract_non_permanent_pt,
     SUM(contract_non_permanent_hk) AS contract_non_permanent_hk,
     SUM(contract_permanent_ft) AS contract_permanent_ft,
     SUM(contract_permanent_pt) AS contract_permanent_pt,
     SUM(contract_permanent_0_hours) AS contract_permanent_0_hours,
     SUM(contract_permanent_hk) AS contract_permanent_hk,
     SUM(years_service) AS years_service,
     SUM(amount_women_diversity) AS amount_women_diversity,
     SUM(amount_total_diversity) AS amount_total_diversity,
     AVG(fte_hours_month) AS fte_hours_month,
     SUM(employee_inflow) AS employee_inflow,
     SUM(employee_outflow) AS employee_outflow,
      CASE
      WHEN AVG(cla_hourly_wage) > 0
      THEN ROUND(CAST(AVG(cla_hourly_wage) AS BIGNUMERIC), 5)
      ELSE NULL
      END AS cla_hourly_wage,
     CAST(SUM(hours_contract + hours_overtime + CASE
         WHEN employee_subgroup LIKE '%6G%' OR employee_subgroup LIKE '%6H%'
         THEN hours_gross - hours_other - hours_sick - hours_holiday - hours_vacation - hours_overtime
         ELSE 0
         END) AS BIGNUMERIC) AS hours_nett,
     CAST(SUM(hours_gross) AS BIGNUMERIC) AS hours_gross,
     CAST(SUM(CASE
        WHEN employee_subgroup NOT LIKE '%6G%' OR employee_subgroup NOT LIKE '%6H%'
        THEN hours_gross
        ELSE NULL
        END) AS BIGNUMERIC) AS hours_gross_excl_hk,
     CAST(SUM(hours_overtime) AS BIGNUMERIC) AS hours_overtime,
     CAST(SUM(CASE
        WHEN employee_subgroup LIKE '%6G%' OR employee_subgroup LIKE '%6H%'
        THEN hours_gross - hours_other - hours_sick - hours_holiday - hours_vacation - hours_overtime
        ELSE NULL
        END) AS BIGNUMERIC) AS hours_worked_hk,
     CAST(SUM(CASE
        WHEN employee_subgroup LIKE '%6G%' OR employee_subgroup LIKE '%6H%'
        THEN hours_gross
        ELSE NULL
        END) AS BIGNUMERIC) AS hours_gross_hk,
     CAST(SUM(hours_vacation) AS BIGNUMERIC) AS hours_vacation,
     CAST(SUM(hours_holiday) AS BIGNUMERIC) AS hours_holiday,
     CAST(SUM(hours_sick) AS BIGNUMERIC) AS hours_sick,
     CAST(SUM(sick_perc_hours) AS BIGNUMERIC) AS hours_sick_absent_9glc,
     CAST(SUM(hours_other) AS BIGNUMERIC) AS hours_other,
     CAST(SUM(sick_perc_contract_hours) AS BIGNUMERIC) AS hours_contract,
     CAST(SUM(CASE
        WHEN employee_subgroup LIKE '%6G%' OR employee_subgroup LIKE '%6H%'
        THEN sick_perc_contract_hours
        ELSE NULL
        END) AS BIGNUMERIC) AS hours_contract_hk,
     CAST(SUM(CASE
        WHEN employee_subgroup NOT LIKE '%6G%' AND employee_subgroup NOT LIKE '%6H%'
        THEN sick_perc_contract_hours
        ELSE NULL
        END) AS FLOAT64) AS hours_contract_excl_hk,
     CAST(SUM(surcharge_overtime) AS BIGNUMERIC) AS surcharge_overtime,
     CAST(SUM(surcharge_late_night_hours) AS BIGNUMERIC) AS surcharge_late_night_hours
    FROM ldl_s_conl_workbench.v_hr_po_lead_emp_flow_2
    WHERE RIGHT(TRIM(orig_store_nr), 4) IN ('9648', '9668')
     AND CASE
       WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
       THEN ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1 AS
           BIGNUMERIC)) AS BIGNUMERIC), 0)
       ELSE ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) AS BIGNUMERIC))
         AS BIGNUMERIC), 0)
       END = (SELECT MAX(CASE
           WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
           THEN ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1 AS
               BIGNUMERIC)) AS BIGNUMERIC), 0)
           ELSE ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) AS
               BIGNUMERIC)) AS BIGNUMERIC), 0)
           END) - 1
       FROM ldl_s_conl_workbench.v_hr_po_lead_emp_flow_2
       WHERE RIGHT(TRIM(orig_store_nr), 4) IN ('9648', '9668'))
    GROUP BY
     /* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
     business_year,
     booking_month,
     cost_center,
     employee_subgroup) AS VJ ON LJ.business_year = VJ.business_year + 1 AND LJ.booking_month = VJ.booking_month + 100
     AND LJ.cost_center = VJ.cost_center AND LJ.employee_subgroup = VJ.employee_subgroup
  GROUP BY business_year,
   booking_month,
   warehouse_nr,
   cost_center,
   employee_subgroup) AS X
 INNER JOIN (SELECT MAX(CASE
     WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
     THEN ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1 AS BIGNUMERIC
         )) AS BIGNUMERIC), 0)
     ELSE ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) AS BIGNUMERIC)) AS
       BIGNUMERIC), 0)
     END) AS business_year,
   MAX(cy_month) AS max_month
  FROM ldl_s_conl_workbench.v_hr_po_lead_emp_flow_2
  WHERE RIGHT(TRIM(orig_store_nr), 4) IN ('9648', '9668')) AS RPM ON X.business_year = RPM.business_year AND X.booking_month
    <= RPM.max_month;
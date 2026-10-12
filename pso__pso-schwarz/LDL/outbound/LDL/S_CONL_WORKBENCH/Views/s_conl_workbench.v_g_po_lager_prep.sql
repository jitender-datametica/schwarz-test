CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_g_po_lager_prep AS /* contractsoort onbepaalde tijd */
/* contractsoort bepaalde tijd */ /* aantal dienstjaren */ /* gemiddelde leeftijd onbepaalde tijd */
/* gemiddelde leeftijd bepaalde tijd */ /* FTE */ /* headcount */ /* leeftijd >= 23 jaar */ /* leeftijd < 23 jaar */
/* gemiddeld CAO uurloon */ SELECT -- metadata
 LEAD.cost_center,
 LEAD.cy_month,
 LEAD.employee_subgroup,
 LEAD.contract_type,
  CASE
  WHEN CAST(LEAD.contract_type AS INTEGER) IN (90, 92, 94, 96) AND LEAD.employee_subgroup = '5C' AND LEAD.status_employment
     = 3
  THEN 1
  ELSE NULL
  END AS permanent_contract_teammanager,
  CASE
  WHEN CAST(LEAD.contract_type AS INTEGER) IN (90, 92, 94, 96) AND LEAD.employee_subgroup = '6B' AND LEAD.status_employment
     = 3
  THEN 1
  ELSE NULL
  END AS permanent_contract_medewerker,
  CASE
  WHEN CAST(LEAD.contract_type AS INTEGER) IN (90, 92, 94, 96) AND LEAD.employee_subgroup = '6H' AND LEAD.status_employment
     = 3
  THEN 1
  ELSE NULL
  END AS permanent_contract_hulpkracht,
  CASE
  WHEN CAST(LEAD.contract_type AS INTEGER) IN (91, 93, 97) AND LEAD.employee_subgroup = '5C' AND LEAD.status_employment
    = 3
  THEN 1
  ELSE NULL
  END AS non_permanent_contract_teammanager,
  CASE
  WHEN CAST(LEAD.contract_type AS INTEGER) IN (91, 93, 97) AND LEAD.employee_subgroup = '6B' AND LEAD.status_employment
    = 3
  THEN 1
  ELSE NULL
  END AS non_permanent_contract_medewerker,
  CASE
  WHEN CAST(LEAD.contract_type AS INTEGER) IN (91, 93, 97) AND LEAD.employee_subgroup = '6H' AND LEAD.status_employment
    = 3
  THEN 1
  ELSE NULL
  END AS non_permanent_contract_hulpkracht,
  CASE
  WHEN LEAD.date_resignation IS NULL
  THEN CASE
   WHEN LEAD.employee_subgroup = '5C' AND LEAD.status_employment = 3
   THEN CASE
    WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_joining)
    THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_joining)
    ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_joining) - 1
    END
   ELSE NULL
   END
  ELSE CASE
   WHEN LEAD.employee_subgroup = '5C' AND LEAD.status_employment = 3
   THEN CASE
    WHEN EXTRACT(MONTH FROM LEAD.date_resignation) >= EXTRACT(MONTH FROM LEAD.date_joining)
    THEN EXTRACT(YEAR FROM LEAD.date_resignation) - EXTRACT(YEAR FROM LEAD.date_joining)
    ELSE EXTRACT(YEAR FROM LEAD.date_resignation) - EXTRACT(YEAR FROM LEAD.date_joining) - 1
    END
   ELSE NULL
   END
  END AS years_service_teammanager,
  CASE
  WHEN LEAD.date_resignation IS NULL
  THEN CASE
   WHEN LEAD.employee_subgroup = '6B' AND LEAD.status_employment = 3
   THEN CASE
    WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_joining)
    THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_joining)
    ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_joining) - 1
    END
   ELSE NULL
   END
  ELSE CASE
   WHEN LEAD.employee_subgroup = '6B' AND LEAD.status_employment = 3
   THEN CASE
    WHEN EXTRACT(MONTH FROM LEAD.date_resignation) >= EXTRACT(MONTH FROM LEAD.date_joining)
    THEN EXTRACT(YEAR FROM LEAD.date_resignation) - EXTRACT(YEAR FROM LEAD.date_joining)
    ELSE EXTRACT(YEAR FROM LEAD.date_resignation) - EXTRACT(YEAR FROM LEAD.date_joining) - 1
    END
   ELSE NULL
   END
  END AS years_service_medewerker,
  CASE
  WHEN LEAD.date_resignation IS NULL
  THEN CASE
   WHEN LEAD.employee_subgroup = '6H' AND LEAD.status_employment = 3
   THEN CASE
    WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_joining)
    THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_joining)
    ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_joining) - 1
    END
   ELSE NULL
   END
  ELSE CASE
   WHEN LEAD.employee_subgroup = '6H' AND LEAD.status_employment = 3
   THEN CASE
    WHEN EXTRACT(MONTH FROM LEAD.date_resignation) >= EXTRACT(MONTH FROM LEAD.date_joining)
    THEN EXTRACT(YEAR FROM LEAD.date_resignation) - EXTRACT(YEAR FROM LEAD.date_joining)
    ELSE EXTRACT(YEAR FROM LEAD.date_resignation) - EXTRACT(YEAR FROM LEAD.date_joining) - 1
    END
   ELSE NULL
   END
  END AS years_service_hulpkracht,
  CASE
  WHEN LEAD.employee_subgroup = '5C' AND CAST(LEAD.contract_type AS INTEGER) IN (90, 92, 94, 96) AND LEAD.status_employment
     = 3
  THEN CASE
   WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
   THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
   ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
   END
  ELSE NULL
  END AS age_permanent_contract_teammanager,
  CASE
  WHEN LEAD.employee_subgroup = '6B' AND CAST(LEAD.contract_type AS INTEGER) IN (90, 92, 94, 96) AND LEAD.status_employment
     = 3
  THEN CASE
   WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
   THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
   ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
   END
  ELSE NULL
  END AS age_permanent_contract_medewerker,
  CASE
  WHEN LEAD.employee_subgroup = '6H' AND CAST(LEAD.contract_type AS INTEGER) IN (90, 92, 94, 96) AND LEAD.status_employment
     = 3
  THEN CASE
   WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
   THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
   ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
   END
  ELSE NULL
  END AS age_permanent_contract_hulpkracht,
  CASE
  WHEN LEAD.employee_subgroup = '5C' AND CAST(LEAD.contract_type AS INTEGER) IN (91, 93, 97) AND LEAD.status_employment
    = 3
  THEN CASE
   WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
   THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
   ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
   END
  ELSE NULL
  END AS age_non_permanent_contract_teammanager,
  CASE
  WHEN LEAD.employee_subgroup = '6B' AND CAST(LEAD.contract_type AS INTEGER) IN (91, 93, 97) AND LEAD.status_employment
    = 3
  THEN CASE
   WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
   THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
   ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
   END
  ELSE NULL
  END AS age_non_permanent_contract_medewerker,
  CASE
  WHEN LEAD.employee_subgroup = '6H' AND CAST(LEAD.contract_type AS INTEGER) IN (91, 93, 97) AND LEAD.status_employment
    = 3
  THEN CASE
   WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
   THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
   ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
   END
  ELSE NULL
  END AS age_non_permanent_contract_hulpkracht,
 CAST(CASE
   WHEN LEAD.employee_subgroup = '5C' AND LEAD.status_employment = 3
   THEN LEAD.hours_gross / cal_fte.fte_hours_month
   ELSE NULL
   END AS BIGNUMERIC) AS fte_teammanager,
 CAST(CASE
   WHEN LEAD.employee_subgroup = '6B' AND LEAD.status_employment = 3
   THEN LEAD.hours_gross / cal_fte.fte_hours_month
   ELSE NULL
   END AS BIGNUMERIC) AS fte_medewerker,
 CAST(CASE
   WHEN LEAD.employee_subgroup = '6H' AND LEAD.status_employment = 3
   THEN LEAD.hours_gross / cal_fte.fte_hours_month
   ELSE NULL
   END AS BIGNUMERIC) AS fte_hulpkracht,
  CASE
  WHEN LEAD.employee_subgroup = '5C' AND LEAD.status_employment = 3
  THEN 1
  ELSE NULL
  END AS headcount_teammanager,
  CASE
  WHEN LEAD.employee_subgroup = '6B' AND LEAD.status_employment = 3
  THEN 1
  ELSE NULL
  END AS headcount_medewerker,
  CASE
  WHEN LEAD.employee_subgroup = '6H' AND LEAD.status_employment = 3
  THEN 1
  ELSE NULL
  END AS headcount_hulpkracht,
  CASE
  WHEN LEAD.employee_subgroup = '5C' AND LEAD.status_employment = 3 AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
     ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
     END >= 23
  THEN 1
  ELSE NULL
  END AS age_23_and_older_teammanager,
  CASE
  WHEN LEAD.employee_subgroup = '6B' AND LEAD.status_employment = 3 AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
     ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
     END >= 23
  THEN 1
  ELSE NULL
  END AS age_23_and_older_medewerker,
  CASE
  WHEN LEAD.employee_subgroup = '6H' AND LEAD.status_employment = 3 AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
     ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
     END >= 23
  THEN 1
  ELSE NULL
  END AS age_23_and_older_hulpkracht,
  CASE
  WHEN LEAD.employee_subgroup = '5C' AND LEAD.status_employment = 3 AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
     ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
     END < 23
  THEN 1
  ELSE NULL
  END AS age_under_23_teammanager,
  CASE
  WHEN LEAD.employee_subgroup = '6B' AND LEAD.status_employment = 3 AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
     ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
     END < 23
  THEN 1
  ELSE NULL
  END AS age_under_23_medewerker,
  CASE
  WHEN LEAD.employee_subgroup = '6H' AND LEAD.status_employment = 3 AND CASE
     WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= EXTRACT(MONTH FROM LEAD.date_birth)
     THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth)
     ELSE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM LEAD.date_birth) - 1
     END < 23
  THEN 1
  ELSE NULL
  END AS age_under_23_hulpkracht,
  CASE
  WHEN LEAD.employee_subgroup = '5C'
  THEN WAGE.cla_hourly_wage
  ELSE NULL
  END AS cla_hourly_wage_teammanager,
  CASE
  WHEN LEAD.employee_subgroup = '6B'
  THEN WAGE.cla_hourly_wage
  ELSE NULL
  END AS cla_hourly_wage_medewerker,
  CASE
  WHEN LEAD.employee_subgroup = '6H'
  THEN WAGE.cla_hourly_wage
  ELSE NULL
  END AS cla_hourly_wage_hulpkracht
FROM ldl_s_conl_workbench.t_i_hr_po_lead AS LEAD
 LEFT JOIN ldl_s_conl_workbench.v_cla_hourly_wage AS WAGE ON LEAD.cy_month = CAST(WAGE.cy_month AS FLOAT64) AND LEAD.cost_center
    = WAGE.orig_store_nr -- voor FTE berekening

 INNER JOIN (SELECT cy_month,
    SUM(CASE
      WHEN day_of_week IN (1, 2, 3, 4, 5)
      THEN 1
      ELSE 0
      END) * 8 AS fte_hours_month
  FROM ldl_s_conl.v_cal_calendarday AS CAL
  GROUP BY cy_month) AS cal_fte ON LEAD.cy_month = cal_fte.cy_month
WHERE LEAD.status_employment = 3
 AND CAST(RIGHT(LEAD.cost_center, 2) AS INTEGER) IN (48, 68)
 AND LEAD.employee_subgroup IN ('5C', '6B', '6H');
/* functie */ -- Uren --
 -- functie
 CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_hr_po_lead_1 AS
/* SUM(CASE WHEN status_employment=3 THEN hr_lead.hours_gross END) AS hours_gross, -- bruto uren */ /* Meeruren */
/* Verlof - ADV */ /* Betaalde feestdaguren */ /* Ziekte-uren */ /* Overige-uren */ -- HR cijfers --

/* Contracturen SUM(hr_lead.hours_work_month) */ /* Ziektepercentage */ -- Bruto uren Hulpkrachten

/* Ziektepercentage */ /* Restsaldo wettelijk verlof */ /* Restsaldo bovenwet. verlof */ /* Restsaldo ADV */
/* Overschr. rustperiodes */ /* Overschr. pauzes */ /* Plus 12 u/d arbeid */ /* Plus 60 u/w arbeid */
/* Overschr. werkperiode */ /* Slapende dienstverbanden */ /* Hulpkrachten > 12 uur */ /* Duur verzuim (in dagen) */
/* Duur verzuim (in dagen) aantal met verzuim */ /* Langdurig zieken */ /* Toeslag t.b.v. meeruren (in uren) */
/* Toeslag t.b.v. vroeg/laat (in uren) */ /* Meeruren (comp. potje) */ /* Meeruren (comp. potje) count */ /* Minuren */
/* Minuren count */
-- hours_contract/AVG(cal_fte.fte_hours_month) AS fte, 	-- FTE	--SUM(CASE WHEN status_employment=3 THEN hr_lead.hours_work_month ELSE 0 END),

/* Headcount */ -- 
 -- SUM(CASE WHEN status_employment=3 THEN

-- CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM LDL.hr_lead.date_birth)

-- THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM LDL.hr_lead.date_birth))

-- ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM LDL.hr_lead.date_birth))-1)
 -- END

-- ELSE NULL END) AS age,   Oude Berekening
 -- 
 -- Bep Tijd
 /* Bepaalde tijd FT */ /* Bepaalde tijd PT */
-- Onb Tijd
 /* Bepaald hulpkracht */ /* Onbepaalde tijd fT */ /* Onbepaalde tijd PT */ /* Onbepaalde 0-uren */
-- Overige HR-Cijfers
 -- SUM(CASE WHEN status_employment=3

-- THEN EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM LDL.hr_lead.date_joining)

-- ELSE NULL END) AS years_service oud 2, -- Dienstjaren

-- AVG((date-hr_lead.date_joining)YEAR) AS years_service, -- Oud 1
 /* Onbepaalde hulpkracht */ -- Instroom

/* Voor - dit was ('%5A','%5B%','%5F%') */ /* Aantal totaal - dit was ('%5A','%5B%','%5F%') */ -- extra toevoeging

-- extra toevoeging
 -- Langseitabwesend--

-- old:SUM(CASE WHEN long_term_absent_hvi LIKE ANY ('%A000%','%BA00%','%K000%','%K001%','%K002%','%K003%','%K005%','%M000%','%M005%','%SAB1%','%U000%','%U004%','%9100%','%9200%','%9300%','%@I%') THEN 1 ELSE 0 END) AS long_term_absence-- Langseitabwesend

-- Umzugsfilialen

-- Contractsoort 95 is het contract 'Bepaald 0-uren' uitzendkrachten i.v.m. Corona; wordt door HR uitgesloten
 SELECT
 HR_LEAD.cy_month,
 CC_MAPPING.orig_store_nr,
 CC_MAPPING.classification_2,
 HR_LEAD.employee_subgroup,
 SUM(HR_LEAD.hours_gross) AS hours_gross,
 SUM(HR_LEAD.hours_overtime) AS hours_overtime,
 SUM(HR_LEAD.hours_vacation) AS hours_vacation,
 SUM(HR_LEAD.hours_holiday) AS hours_holiday,
 SUM(HR_LEAD.hours_sick) AS hours_sick,
 SUM(HR_LEAD.hours_other) AS hours_other,
      SUM(HR_LEAD.hours_gross) - SUM(HR_LEAD.hours_overtime) - SUM(HR_LEAD.hours_vacation) - SUM(HR_LEAD.hours_holiday)
   - SUM(HR_LEAD.hours_sick) - SUM(HR_LEAD.hours_other) AS hours_contract,
 SUM(HR_LEAD.hours_sick_absent_9glc) AS sick_perc_hours,
 SUM(CASE
   WHEN HR_LEAD.employee_subgroup LIKE '%6G%' AND HR_LEAD.status_employment = 3
   THEN HR_LEAD.hours_gross
   ELSE NULL
   END) AS hours_gross_temporary_helper,
 SUM(CASE
   WHEN HR_LEAD.employee_subgroup LIKE '%6G%'
   THEN HR_LEAD.hours_gross
   ELSE HR_LEAD.hours_work_month
   END) AS sick_perc_contract_hours,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND HR_LEAD.employee_subgroup NOT LIKE '%6G%'
   THEN HR_LEAD.holiday_balance_we
   ELSE NULL
   END) AS holiday_balance_we,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND HR_LEAD.employee_subgroup NOT LIKE '%6G%'
   THEN HR_LEAD.holiday_balance_bw
   ELSE NULL
   END) AS holiday_balance_bw,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.holiday_balance_adv
   ELSE NULL
   END) AS holiday_balance_adv,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.violation_rest_time
   ELSE NULL
   END) AS violation_rest_time,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.violation_break_time
   ELSE NULL
   END) AS violation_break_time,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.violation_9_12_hour_day
   ELSE NULL
   END) AS violation_9_12_hour_day,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.violation_45_60_hour_week
   ELSE NULL
   END) AS violation_45_60_hour_week,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.violation_work_period
   ELSE NULL
   END) AS violation_work_period,
 SUM(CASE
   WHEN HR_LEAD.employee_subgroup LIKE '%6G%' AND HR_LEAD.status_employment = 3 AND HR_LEAD.hours_gross = 0
   THEN 1
   ELSE 0
   END) AS sleeping_employment,
 SUM(CASE
   WHEN HR_LEAD.employee_subgroup LIKE '%6G%' AND HR_LEAD.status_employment = 3 AND HR_LEAD.hours_gross > 51.6
   THEN 1
   ELSE 0
   END) AS temporary_helper_12_hours,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND HR_LEAD.sick_days <> 0
   THEN HR_LEAD.sick_days
   ELSE NULL
   END) AS sick_days,
 COUNT(CASE
   WHEN HR_LEAD.status_employment = 3 AND HR_LEAD.sick_days <> 0
   THEN HR_LEAD.sick_days
   ELSE NULL
   END) AS sick_days_count,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND (HR_LEAD.long_term_absent_hvi LIKE '%K000%' OR HR_LEAD.long_term_absent_hvi
           LIKE '%K001%' OR HR_LEAD.long_term_absent_hvi LIKE '%K002%' OR HR_LEAD.long_term_absent_hvi LIKE '%K003%' OR
        HR_LEAD.long_term_absent_hvi LIKE '%K005%' OR HR_LEAD.long_term_absent_hvi LIKE '%9200%')
   THEN 1
   ELSE 0
   END) AS long_term_sick,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.surcharge_overtime
   ELSE NULL
   END) AS surcharge_overtime,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.surcharge_late_night_hours
   ELSE NULL
   END) AS surcharge_late_night_hours,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.hours_plus_9g01_9g03
   ELSE NULL
   END) AS extra_plus_hours,
 COUNT(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.hours_plus_9g01_9g03
   ELSE NULL
   END) AS extra_plus_hours_count,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.hours_minus_9g01_9g03
   ELSE NULL
   END) AS extra_minus_hours,
 COUNT(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN HR_LEAD.hours_minus_9g01_9g03
   ELSE NULL
   END) AS extra_minus_hours_count,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND HR_LEAD.contract_type IS NOT NULL
   THEN 1
   ELSE 0
   END) AS headcount,
 AVG(cal_fte.fte_hours_month) AS fte_hours_month,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN CASE
    WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(HR_LEAD.cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(HR_LEAD.cy_month AS STRING)
          ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) >= EXTRACT(MONTH FROM HR_LEAD.date_birth)
    THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(HR_LEAD.cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(HR_LEAD.cy_month AS STRING)
          ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM HR_LEAD.date_birth)
    ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(HR_LEAD.cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(HR_LEAD.cy_month AS STRING)
           ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM HR_LEAD.date_birth) - 1
    END
   ELSE NULL
   END) AS age,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND (HR_LEAD.contract_type LIKE '%91%' OR HR_LEAD.contract_type LIKE '%02%' OR
       HR_LEAD.contract_type LIKE '%N1%')
   THEN 1
   ELSE 0
   END) AS contract_non_permanent_ft,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND STRPOS(HR_LEAD.contract_type, '93') <> 0
   THEN 1
   ELSE 0
   END) AS contract_non_permanent_pt,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND STRPOS(HR_LEAD.contract_type, '97') <> 0
   THEN 1
   ELSE 0
   END) AS contract_non_permanent_hk,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND (HR_LEAD.contract_type LIKE '%91%' OR HR_LEAD.contract_type LIKE '%02%' OR
       HR_LEAD.contract_type LIKE '%N1%')
   THEN 1
   ELSE 0
   END) AS contract_permanent_ft,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND STRPOS(HR_LEAD.contract_type, '92') <> 0
   THEN 1
   ELSE 0
   END) AS contract_permanent_pt,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND STRPOS(HR_LEAD.contract_type, '94') <> 0
   THEN 1
   ELSE 0
   END) AS contract_permanent_0_hours,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3 AND STRPOS(HR_LEAD.contract_type, '96') <> 0
   THEN 1
   ELSE 0
   END) AS contract_permanent_hk,
 SUM(CASE
   WHEN HR_LEAD.status_employment = 3
   THEN CASE
    WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(HR_LEAD.cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(HR_LEAD.cy_month AS STRING)
          ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) >= EXTRACT(MONTH FROM HR_LEAD.date_joining)
    THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(HR_LEAD.cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(HR_LEAD.cy_month AS STRING)
          ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM HR_LEAD.date_joining)
    ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(HR_LEAD.cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(HR_LEAD.cy_month AS STRING)
           ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM HR_LEAD.date_joining) - 1
    END
   ELSE NULL
   END) AS years_service,
 SUM(CASE
   WHEN HR_LEAD.sex = 2 AND HR_LEAD.employee_subgroup LIKE '%5A' AND HR_LEAD.status_employment = 3
   THEN 1.000
   ELSE 0.000
   END) AS amount_women_diversity,
 SUM(CASE
   WHEN HR_LEAD.employee_subgroup LIKE '%5A' AND HR_LEAD.status_employment = 3
   THEN 1.000
   ELSE 0.000
   END) AS amount_total_diversity,
 SUM(CASE
   WHEN HR_LEAD.sex = 2 AND (HR_LEAD.employee_subgroup LIKE '%5A' OR HR_LEAD.employee_subgroup LIKE '%5B%' OR HR_LEAD.employee_subgroup
        LIKE '%5F%') AND HR_LEAD.status_employment = 3
   THEN 1.000
   ELSE 0.000
   END) AS amount_women_diversity_5abf,
 SUM(CASE
   WHEN (HR_LEAD.employee_subgroup LIKE '%5A' OR HR_LEAD.employee_subgroup LIKE '%5B%' OR HR_LEAD.employee_subgroup LIKE
       '%5F%') AND HR_LEAD.status_employment = 3
   THEN 1.000
   ELSE 0.000
   END) AS amount_total_diversity_5abf,
 SUM(CASE
   WHEN HR_LEAD.cy_month >= 202008 AND HR_LEAD.long_term_absent_hvi IS NOT NULL OR HR_LEAD.cy_month < 202008 AND (HR_LEAD
                      .long_term_absent_hvi LIKE '%A000%' OR HR_LEAD.long_term_absent_hvi LIKE '%BA00%' OR HR_LEAD.long_term_absent_hvi
                     LIKE '%K000%' OR HR_LEAD.long_term_absent_hvi LIKE '%K001%' OR HR_LEAD.long_term_absent_hvi LIKE
                   '%K002%' OR HR_LEAD.long_term_absent_hvi LIKE '%K003%' OR HR_LEAD.long_term_absent_hvi LIKE '%K005%'
               OR HR_LEAD.long_term_absent_hvi LIKE '%M000%' OR HR_LEAD.long_term_absent_hvi LIKE '%M005%' OR HR_LEAD.long_term_absent_hvi
              LIKE '%SAB1%' OR HR_LEAD.long_term_absent_hvi LIKE '%U000%' OR HR_LEAD.long_term_absent_hvi LIKE '%U004%'
          OR HR_LEAD.long_term_absent_hvi LIKE '%9100%' OR HR_LEAD.long_term_absent_hvi LIKE '%9200%' OR HR_LEAD.long_term_absent_hvi
         LIKE '%9300%' OR HR_LEAD.long_term_absent_hvi LIKE '%@I%')
   THEN 1
   ELSE 0
   END) AS long_term_absence
FROM ldl_s_conl_workbench.v_hr_po_lead_base_1 AS HR_LEAD
 INNER JOIN ldl_s_conl_workbench.v_m_cost_center_all_1 AS CC_MAPPING ON HR_LEAD.cost_center = CC_MAPPING.cost_center
 INNER JOIN (SELECT cy_month,
    SUM(CASE
      WHEN day_of_week IN (1, 2, 3, 4, 5)
      THEN 1
      ELSE 0
      END) * 8 AS fte_hours_month
  FROM ldl_s_conl.v_cal_calendarday_1 AS CAL
  GROUP BY cy_month) AS cal_fte ON HR_LEAD.cy_month = cal_fte.cy_month
  /* Alignment to Teradata: Replaced "WHERE (CONTAINS(hr_lead.contract_type, '95') OR hr_lead.contract_type is null)" */
  
WHERE HR_LEAD.contract_type NOT LIKE '%95%'
 OR HR_LEAD.contract_type IS NULL
GROUP BY HR_LEAD.cy_month,
 CC_MAPPING.orig_store_nr,
 CC_MAPPING.classification_2,
 HR_LEAD.employee_subgroup;
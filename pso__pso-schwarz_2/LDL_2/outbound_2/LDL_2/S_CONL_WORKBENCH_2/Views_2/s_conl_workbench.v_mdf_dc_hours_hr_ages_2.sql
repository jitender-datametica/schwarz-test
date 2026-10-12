CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mdf_dc_hours_hr_ages_2 AS SELECT X.business_year,
 X.booking_month,
 X.warehouse_nr,
 X.cost_center,
 X.headcount_21min_lj,
 X.headcount_21plus_lj,
 X.headcount_21min_vj,
 X.headcount_21plus_vj
FROM (SELECT COALESCE(LJ.business_year, VJ.business_year + 1) AS business_year,
   COALESCE(LJ.cy_month, VJ.cy_month + 100) AS booking_month,
    CASE
    WHEN COALESCE(LJ.cost_center, VJ.cost_center) LIKE '10%'
    THEN 1
    WHEN COALESCE(LJ.cost_center, VJ.cost_center) LIKE '20%'
    THEN 2
    WHEN COALESCE(LJ.cost_center, VJ.cost_center) LIKE '30%' OR COALESCE(LJ.cost_center, VJ.cost_center) LIKE '31%'
    THEN 3
    WHEN COALESCE(LJ.cost_center, VJ.cost_center) LIKE '40%' OR COALESCE(LJ.cost_center, VJ.cost_center) LIKE '41%'
    THEN 4
    WHEN COALESCE(LJ.cost_center, VJ.cost_center) LIKE '50%'
    THEN 5
    WHEN COALESCE(LJ.cost_center, VJ.cost_center) LIKE '60%'
    THEN 6
    WHEN COALESCE(LJ.cost_center, VJ.cost_center) LIKE '90%'
    THEN 9
    ELSE 99
    END AS warehouse_nr,
   COALESCE(LJ.cost_center, VJ.cost_center) AS cost_center,
   SUM(LJ.headcount_21min_lj) AS headcount_21min_lj,
   SUM(LJ.headcount_21plus_lj) AS headcount_21plus_lj,
   SUM(VJ.headcount_21min_vj) AS headcount_21min_vj,
   SUM(VJ.headcount_21plus_vj) AS headcount_21plus_vj
  FROM (SELECT cost_center,
     business_year,
     cy_month,
     status_employment,
     SUM(headcount) AS headcount,
     SUM(age) AS age,
      SUM(headcount) / SUM(age) AS avg_age,
     SUM(`A11868`) AS headcount_21min_lj,
     SUM(`A11869`) AS headcount_21plus_lj
    FROM (SELECT cost_center,
        CASE
        WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
        THEN ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1
        ELSE ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0)
        END AS business_year,
       cy_month,
       status_employment,
       SUM(CASE
         WHEN status_employment = 3 AND contract_type IS NOT NULL
         THEN 1
         ELSE 0
         END) AS headcount,
       SUM(CASE
         WHEN status_employment = 3
         THEN CASE
          WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) >= EXTRACT(MONTH FROM date_birth)
          THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth)
          ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                 ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth) - 1
          END
         ELSE NULL
         END) AS age,
        CASE
        WHEN CASE
          WHEN SUM(CASE
             WHEN status_employment = 3 AND contract_type IS NOT NULL
             THEN 1
             ELSE 0
             END) = 0
          THEN 0
          ELSE SUM(CASE
             WHEN status_employment = 3
             THEN CASE
              WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                    ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) >= EXTRACT(MONTH FROM date_birth)
              THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                    ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth)
              ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                     ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth) - 1
              END
             ELSE NULL
             END) / SUM(CASE
             WHEN status_employment = 3 AND contract_type IS NOT NULL
             THEN 1
             ELSE 0
             END)
          END < 21
        THEN SUM(CASE
          WHEN status_employment = 3 AND contract_type IS NOT NULL
          THEN 1
          ELSE 0
          END)
        ELSE NULL
        END AS `A11868`,
        CASE
        WHEN CASE
          WHEN SUM(CASE
             WHEN status_employment = 3 AND contract_type IS NOT NULL
             THEN 1
             ELSE 0
             END) = 0
          THEN 0
          ELSE SUM(CASE
             WHEN status_employment = 3
             THEN CASE
              WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                    ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) >= EXTRACT(MONTH FROM date_birth)
              THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                    ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth)
              ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                     ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth) - 1
              END
             ELSE NULL
             END) / SUM(CASE
             WHEN status_employment = 3 AND contract_type IS NOT NULL
             THEN 1
             ELSE 0
             END)
          END >= 21
        THEN SUM(CASE
          WHEN status_employment = 3 AND contract_type IS NOT NULL
          THEN 1
          ELSE 0
          END)
        ELSE NULL
        END AS `A11869`
      FROM ldl_s_conl_workbench.v_hr_po_lead_base_2 AS HR_LEAD
      WHERE RIGHT(TRIM(cost_center), 4) IN ('9648', '9668')
       AND CASE
         WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
         THEN ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1
         ELSE ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0)
         END = (SELECT MAX(CASE
            WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
            THEN ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1
            ELSE ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0)
            END) AS max_year
         FROM ldl_s_conl_workbench.v_hr_po_lead_base_2
         WHERE RIGHT(TRIM(cost_center), 4) IN ('9648', '9668'))
      GROUP BY cost_center,
       cy_month,
       date_birth,
       status_employment) AS t5
    GROUP BY cost_center,
     business_year,
     cy_month,
     status_employment) AS LJ
   FULL JOIN (SELECT cost_center,
     business_year,
     cy_month,
     status_employment,
     SUM(headcount) AS headcount,
     SUM(age) AS age,
      SUM(headcount) / SUM(age) AS avg_age,
     SUM(`A11868`) AS headcount_21min_vj,
     SUM(`A11869`) AS headcount_21plus_vj
    FROM (SELECT cost_center,
        CASE
        WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
        THEN ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1
        ELSE ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0)
        END AS business_year,
       cy_month,
       status_employment,
       SUM(CASE
         WHEN status_employment = 3 AND contract_type IS NOT NULL
         THEN 1
         ELSE 0
         END) AS headcount,
       SUM(CASE
         WHEN status_employment = 3
         THEN CASE
          WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) >= EXTRACT(MONTH FROM date_birth)
          THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth)
          ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                 ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth) - 1
          END
         ELSE NULL
         END) AS age,
        CASE
        WHEN CASE
          WHEN SUM(CASE
             WHEN status_employment = 3 AND contract_type IS NOT NULL
             THEN 1
             ELSE 0
             END) = 0
          THEN 0
          ELSE SUM(CASE
             WHEN status_employment = 3
             THEN CASE
              WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                    ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) >= EXTRACT(MONTH FROM date_birth)
              THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                    ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth)
              ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                     ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth) - 1
              END
             ELSE NULL
             END) / SUM(CASE
             WHEN status_employment = 3 AND contract_type IS NOT NULL
             THEN 1
             ELSE 0
             END)
          END < 21
        THEN SUM(CASE
          WHEN status_employment = 3 AND contract_type IS NOT NULL
          THEN 1
          ELSE 0
          END)
        ELSE NULL
        END AS `A11868`,
        CASE
        WHEN CASE
          WHEN SUM(CASE
             WHEN status_employment = 3 AND contract_type IS NOT NULL
             THEN 1
             ELSE 0
             END) = 0
          THEN 0
          ELSE SUM(CASE
             WHEN status_employment = 3
             THEN CASE
              WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                    ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) >= EXTRACT(MONTH FROM date_birth)
              THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                    ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth)
              ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                     ), 2), '-', CAST(EXTRACT(DAY FROM CURRENT_DATE) AS STRING)))) - EXTRACT(YEAR FROM date_birth) - 1
              END
             ELSE NULL
             END) / SUM(CASE
             WHEN status_employment = 3 AND contract_type IS NOT NULL
             THEN 1
             ELSE 0
             END)
          END >= 21
        THEN SUM(CASE
          WHEN status_employment = 3 AND contract_type IS NOT NULL
          THEN 1
          ELSE 0
          END)
        ELSE NULL
        END AS `A11869`
      FROM ldl_s_conl_workbench.v_hr_po_lead_base_2 AS HR_LEAD
      WHERE RIGHT(TRIM(cost_center), 4) IN ('9648', '9668')
       AND CASE
         WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
         THEN ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1
         ELSE ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0)
         END = (SELECT MAX(CASE
             WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
             THEN ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1
             ELSE ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0)
             END) - 1
         FROM ldl_s_conl_workbench.v_hr_po_lead_base_2
         WHERE RIGHT(TRIM(cost_center), 4) IN ('9648', '9668'))
      GROUP BY cost_center,
       cy_month,
       date_birth,
       status_employment) AS t15
    GROUP BY cost_center,
     business_year,
     cy_month,
     status_employment) AS VJ ON LJ.business_year = VJ.business_year + 1 AND LJ.cy_month = VJ.cy_month + 100 AND LJ.cost_center
       = VJ.cost_center AND LJ.status_employment = VJ.status_employment
  WHERE LJ.status_employment = 3
  GROUP BY business_year,
   booking_month,
   warehouse_nr,
   cost_center) AS X
 INNER JOIN (SELECT MAX(CASE
     WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
     THEN ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1
     ELSE ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0)
     END) AS business_year,
   MAX(cy_month) AS max_month
  FROM ldl_s_conl_workbench.v_hr_po_lead_base_2 AS HR_LEAD
  WHERE RIGHT(TRIM(cost_center), 4) IN ('9648', '9668')) AS RPM ON X.business_year = RPM.business_year AND X.booking_month
    <= RPM.max_month;
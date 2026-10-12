CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mdf_dc_hours_hr_years_services_1 AS SELECT X.business_year,
 X.booking_month,
 X.warehouse_nr,
 X.cost_center,
 X.headcount_lj,
 X.headcount_vj,
 X.years_service_lj,
 X.years_service_vj,
 X.fte_parttime_factor_lj,
 X.fte_parttime_factor_vj
FROM (SELECT COALESCE(LJ.business_year, VJ.business_year + 1) AS business_year,
   COALESCE(LJ.cy_month, VJ.cy_month + 100) AS booking_month,
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
   SUM(LJ.headcount) AS headcount_lj,
   SUM(VJ.headcount) AS headcount_vj,
   SUM(LJ.years_joining) AS years_service_lj,
   SUM(VJ.years_joining) AS years_service_vj,
   CAST(SUM(LJ.parttime_factor) AS BIGNUMERIC) AS fte_parttime_factor_lj,
   CAST(SUM(VJ.parttime_factor) AS BIGNUMERIC) AS fte_parttime_factor_vj
  FROM (SELECT cost_center,
      CASE
      WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
      THEN ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1 AS BIGNUMERIC
          )) AS BIGNUMERIC), 0)
      ELSE ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) AS BIGNUMERIC))
        AS BIGNUMERIC), 0)
      END AS business_year,
     cy_month,
     date_joining,
     status_employment,
     CAST(SUM(parttime_factor) AS BIGNUMERIC) AS parttime_factor,
     SUM(CASE
       WHEN status_employment = 3 AND contract_type IS NOT NULL
       THEN 1
       ELSE 0
       END) AS headcount,
     SUM(CASE
       WHEN status_employment = 3
       THEN CASE
        WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
              ), 2), '-01'))) >= EXTRACT(MONTH FROM date_joining)
        THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
              ), 2), '-01'))) - EXTRACT(YEAR FROM date_joining)
        ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
               ), 2), '-01'))) - EXTRACT(YEAR FROM date_joining) - 1
        END
       ELSE NULL
       END) AS years_joining,
     SUM(CASE
       WHEN status_employment = 3
       THEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM date_joining)
       ELSE NULL
       END) AS years_service,
      CASE
      WHEN SUM(CASE
         WHEN status_employment = 3 AND contract_type IS NOT NULL
         THEN 1
         ELSE 0
         END) = 0
      THEN NULL
      ELSE SUM(CASE
         WHEN status_employment = 3
         THEN CASE
          WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                ), 2), '-01'))) >= EXTRACT(MONTH FROM date_joining)
          THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                ), 2), '-01'))) - EXTRACT(YEAR FROM date_joining)
          ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                 ), 2), '-01'))) - EXTRACT(YEAR FROM date_joining) - 1
          END
         ELSE NULL
         END) / SUM(CASE
         WHEN status_employment = 3 AND contract_type IS NOT NULL
         THEN 1
         ELSE 0
         END)
      END AS avg_years_joining
    FROM ldl_s_conl_workbench.v_hr_po_lead_base_1 AS HR_LEAD
    WHERE RIGHT(TRIM(cost_center), 4) IN ('9648', '9668')
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
       FROM ldl_s_conl_workbench.v_hr_po_lead_base_1
       WHERE RIGHT(TRIM(cost_center), 4) IN ('9648', '9668'))
    GROUP BY cost_center,
     cy_month,
     date_joining,
     status_employment) AS LJ
   FULL JOIN (SELECT cost_center,
      CASE
      WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
      THEN ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1 AS BIGNUMERIC
          )) AS BIGNUMERIC), 0)
      ELSE ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) AS BIGNUMERIC))
        AS BIGNUMERIC), 0)
      END AS business_year,
     cy_month,
     date_joining,
     status_employment,
     CAST(SUM(parttime_factor) AS BIGNUMERIC) AS parttime_factor,
     SUM(CASE
       WHEN status_employment = 3 AND contract_type IS NOT NULL
       THEN 1
       ELSE 0
       END) AS headcount,
     SUM(CASE
       WHEN status_employment = 3
       THEN CASE
        WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
              ), 2), '-01'))) >= EXTRACT(MONTH FROM date_joining)
        THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
              ), 2), '-01'))) - EXTRACT(YEAR FROM date_joining)
        ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
               ), 2), '-01'))) - EXTRACT(YEAR FROM date_joining) - 1
        END
       ELSE NULL
       END) AS years_joining,
      CASE
      WHEN SUM(CASE
         WHEN status_employment = 3 AND contract_type IS NOT NULL
         THEN 1
         ELSE 0
         END) = 0
      THEN NULL
      ELSE SUM(CASE
         WHEN status_employment = 3
         THEN CASE
          WHEN EXTRACT(MONTH FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                ), 2), '-01'))) >= EXTRACT(MONTH FROM date_joining)
          THEN EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                ), 2), '-01'))) - EXTRACT(YEAR FROM date_joining)
          ELSE EXTRACT(YEAR FROM DATE(CONCAT(LEFT(TRIM(CAST(cy_month AS STRING)), 4), '-', RIGHT(TRIM(CAST(cy_month AS STRING)
                 ), 2), '-01'))) - EXTRACT(YEAR FROM date_joining) - 1
          END
         ELSE NULL
         END) / SUM(CASE
         WHEN status_employment = 3 AND contract_type IS NOT NULL
         THEN 1
         ELSE 0
         END)
      END AS avg_years_joining
    FROM ldl_s_conl_workbench.v_hr_po_lead_base_1 AS HR_LEAD
    WHERE RIGHT(TRIM(cost_center), 4) IN ('9648', '9668')
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
       FROM ldl_s_conl_workbench.v_hr_po_lead_base_1
       WHERE RIGHT(TRIM(cost_center), 4) IN ('9648', '9668'))
    GROUP BY cost_center,
     cy_month,
     date_joining,
     status_employment) AS VJ ON LJ.business_year = VJ.business_year + 1 AND LJ.cy_month = VJ.cy_month + 100 AND LJ.cost_center
        = VJ.cost_center AND LJ.date_joining = VJ.date_joining AND LJ.status_employment = VJ.status_employment
  WHERE LJ.status_employment = 3
  GROUP BY business_year,
   booking_month,
   warehouse_nr,
   cost_center) AS X
 INNER JOIN (SELECT MAX(CASE
     WHEN ROUND(CAST(RIGHT(TRIM(CAST(cy_month AS STRING)), 2) AS BIGNUMERIC), 0) <= 2
     THEN ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) - 1 AS BIGNUMERIC
         )) AS BIGNUMERIC), 0)
     ELSE ROUND(CAST(TRUNC(CAST(ROUND(CAST(LEFT(TRIM(CAST(cy_month AS STRING)), 4) AS BIGNUMERIC), 0) AS BIGNUMERIC)) AS
       BIGNUMERIC), 0)
     END) AS business_year,
   MAX(cy_month) AS max_month
  FROM ldl_s_conl_workbench.v_hr_po_lead_base_1
  WHERE RIGHT(TRIM(cost_center), 4) IN ('9648', '9668')) AS RPM ON X.business_year = RPM.business_year AND X.booking_month
    <= RPM.max_month;
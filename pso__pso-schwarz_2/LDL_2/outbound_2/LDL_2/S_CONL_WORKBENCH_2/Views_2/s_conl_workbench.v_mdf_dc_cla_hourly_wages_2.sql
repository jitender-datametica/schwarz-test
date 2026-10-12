CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mdf_dc_cla_hourly_wages_2 AS
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
-- and coalesce(lj.business_year,vj.business_year+1)=2020
 SELECT COALESCE(LJ.business_year, VJ.business_year + 1) AS
 business_year,
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
  CASE
  WHEN LJ.cla_hourly_wage > 0
  THEN CAST(LJ.cla_hourly_wage AS BIGNUMERIC)
  ELSE NULL
  END AS cla_hourly_wage_lj,
  CASE
  WHEN VJ.cla_hourly_wage > 0
  THEN CAST(VJ.cla_hourly_wage AS BIGNUMERIC)
  ELSE NULL
  END AS cla_hourly_wage_vj
FROM (SELECT CASE
    WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
    THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
    ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
    END AS business_year,
   ROUND(CAST(cy_month AS BIGNUMERIC), 0) AS booking_month,
   orig_store_nr AS cost_center,
    CASE
    WHEN cla_hourly_wage > 0
    THEN ROUND(CAST(cla_hourly_wage AS BIGNUMERIC), 5)
    ELSE NULL
    END AS cla_hourly_wage
  FROM ldl_s_conl_workbench.v_cla_hourly_wage_2
  WHERE RIGHT(orig_store_nr, 4) IN ('9628', '9648', '9668', '9698')
   AND LEFT(cy_month, 4) = '2020') AS LJ
 FULL JOIN (SELECT CASE
    WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
    THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
    ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
    END AS business_year,
   ROUND(CAST(cy_month AS BIGNUMERIC), 0) AS booking_month,
   orig_store_nr AS cost_center,
    CASE
    WHEN cla_hourly_wage > 0
    THEN ROUND(CAST(cla_hourly_wage AS BIGNUMERIC), 5)
    ELSE NULL
    END AS cla_hourly_wage
  FROM ldl_s_conl_workbench.v_cla_hourly_wage_2
  WHERE RIGHT(orig_store_nr, 4) IN ('9628', '9648', '9668', '9698')
   AND LEFT(cy_month, 4) = '2019') AS VJ ON LJ.business_year = VJ.business_year + 1 AND LJ.booking_month = VJ.booking_month
      + 100 AND LJ.cost_center = VJ.cost_center;
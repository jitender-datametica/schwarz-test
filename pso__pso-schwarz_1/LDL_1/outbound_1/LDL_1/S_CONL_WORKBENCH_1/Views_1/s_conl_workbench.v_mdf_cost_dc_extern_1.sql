CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mdf_cost_dc_extern_1 AS
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
/* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
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
 X.cost_component_desc,
 X.saldo_amount_lj,
 X.saldo_amount_vj
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
   COALESCE(LJ.cost_component_desc, VJ.cost_component_desc) AS cost_component_desc,
   SUM(LJ.saldo_amount) AS saldo_amount_lj,
   SUM(VJ.saldo_amount) AS saldo_amount_vj
  FROM (SELECT CASE
      WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
      THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
      ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
      END AS business_year,
     ROUND(CAST(cy_month AS BIGNUMERIC), 0) AS booking_month,
     cost_center,
     cost_component_desc,
     saldo_amount
    FROM ldl_s_conl_workbench.v_cost_extern_1
    WHERE LEFT(cy_month, 4) = '2021'
     AND RIGHT(cost_center, 4) IN ('9648', '9668') -- het was  ('9628','9648','9668','9698')
) AS LJ
   FULL JOIN (SELECT CASE
      WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
      THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
      ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
      END AS business_year,
     ROUND(CAST(cy_month AS BIGNUMERIC), 0) AS booking_month,
     cost_center,
     cost_component_desc,
     saldo_amount
    FROM ldl_s_conl_workbench.v_cost_extern_1
    WHERE LEFT(cy_month, 4) = '2020'
     AND RIGHT(cost_center, 4) IN ('9648', '9668') -- het was  ('9628','9648','9668','9698')
) AS VJ ON LJ.business_year
       = VJ.business_year + 1 AND LJ.booking_month = VJ.booking_month + 100 AND LJ.cost_center = VJ.cost_center
  GROUP BY business_year,
   booking_month,
   warehouse_nr,
   cost_center,
   cost_component_desc) AS X
 INNER JOIN (SELECT CASE
    WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
    THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
    ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
    END AS business_year,
   MAX(ROUND(CAST(cy_month AS BIGNUMERIC), 0)) AS max_month
  FROM ldl_s_conl_workbench.v_cost_extern_1
  WHERE CASE
     WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
     THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
     ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
     END = 2021
   AND RIGHT(cost_center, 4) IN ('9648', '9668') -- het was  ('9628','9648','9668','9698')

  GROUP BY
   /* MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ** */
   business_year) AS RPM ON X.business_year = RPM.business_year AND X.booking_month <= RPM.max_month;
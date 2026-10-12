CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mdf_cost_dc_loonjournaalpost_1 AS SELECT X.business_year,
 X.booking_month,
 X.warehouse_nr,
 X.warehouse_desc_short,
 X.warehouse_desc,
 X.account_number,
 X.cost_center_desc,
 X.cost_center,
 X.pay_component,
 X.cost_component_desc,
 X.saldo_amount_lj,
 X.saldo_amount_vj
FROM (SELECT t4.business_year,
   t4.booking_month,
    CASE
    WHEN SUBSTR(t4.cost_center, 1, 2) = '10'
    THEN 1
    WHEN SUBSTR(t4.cost_center, 1, 2) = '20'
    THEN 2
    WHEN SUBSTR(t4.cost_center, 1, 2) = '30'
    THEN 3
    WHEN SUBSTR(t4.cost_center, 1, 2) = '31'
    THEN 3
    WHEN SUBSTR(t4.cost_center, 1, 2) = '40'
    THEN 4
    WHEN SUBSTR(t4.cost_center, 1, 2) = '41'
    THEN 4
    WHEN SUBSTR(t4.cost_center, 1, 2) = '50'
    THEN 5
    WHEN SUBSTR(t4.cost_center, 1, 2) = '60'
    THEN 6
    WHEN SUBSTR(t4.cost_center, 1, 2) = '90'
    THEN 9
    ELSE 99
    END AS warehouse_nr,
    CASE
    WHEN LEFT(t4.cost_center, 2) = '10'
    THEN 'HEE'
    WHEN LEFT(t4.cost_center, 2) = '20'
    THEN 'ETT'
    WHEN LEFT(t4.cost_center, 2) = '30'
    THEN 'OOS'
    WHEN LEFT(t4.cost_center, 2) = '31'
    THEN 'OOS'
    WHEN LEFT(t4.cost_center, 2) = '40'
    THEN 'ZWA'
    WHEN LEFT(t4.cost_center, 2) = '41'
    THEN 'ZWA'
    WHEN LEFT(t4.cost_center, 2) = '50'
    THEN 'WEE'
    WHEN LEFT(t4.cost_center, 2) = '60'
    THEN 'WAD'
    WHEN LEFT(t4.cost_center, 2) = '90'
    THEN 'TIE'
    ELSE 'Unknown'
    END AS warehouse_desc_short,
    CASE
    WHEN LEFT(t4.cost_center, 2) = '10'
    THEN 'Heerenveen'
    WHEN LEFT(t4.cost_center, 2) = '20'
    THEN 'Etten-Leur'
    WHEN LEFT(t4.cost_center, 2) = '30'
    THEN 'Oosterhout'
    WHEN LEFT(t4.cost_center, 2) = '31'
    THEN 'Oosterhout'
    WHEN LEFT(t4.cost_center, 2) = '40'
    THEN 'Zwaag'
    WHEN LEFT(t4.cost_center, 2) = '41'
    THEN 'Zwaag'
    WHEN LEFT(t4.cost_center, 2) = '50'
    THEN 'Weert'
    WHEN LEFT(t4.cost_center, 2) = '60'
    THEN 'Waddinxveen'
    WHEN LEFT(t4.cost_center, 2) = '90'
    THEN 'Tiel'
    ELSE 'Unknown'
    END AS warehouse_desc,
   t4.account_number,
   t4.cost_center_desc,
   t4.cost_center,
   t4.pay_component,
   t4.cost_component_desc,
   t4.saldo_amount_lj,
   t4.saldo_amount_vj
  FROM (SELECT COALESCE(LJ.business_year, VJ.business_year + 1) AS business_year,
     COALESCE(LJ.booking_month, VJ.booking_month + 100) AS booking_month,
     COALESCE(LJ.account_number, VJ.account_number) AS account_number,
     COALESCE(LJ.cost_center_desc, VJ.cost_center_desc) AS cost_center_desc,
     COALESCE(LJ.cost_center, VJ.cost_center) AS cost_center,
     COALESCE(LJ.pay_component, VJ.pay_component) AS pay_component,
     COALESCE(LJ.cost_component_desc, VJ.cost_component_desc) AS cost_component_desc,
     SUM(LJ.saldo_amount) AS saldo_amount_lj,
     SUM(VJ.saldo_amount) AS saldo_amount_vj
    FROM (SELECT CASE
        WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
        THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
        ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
        END AS business_year,
       ROUND(CAST(cy_month AS BIGNUMERIC), 0) AS booking_month,
       account_number,
       cost_center_desc,
       cost_center,
       pay_component,
       cost_component_desc,
       saldo_amount
      FROM ldl_s_conl_workbench.v_cost_loonjournal_post_1
      WHERE CASE
         WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
         THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
         ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
         END = 2021
       AND RIGHT(cost_center, 4) IN ('9648', '9668')) AS LJ
     FULL JOIN (SELECT CASE
        WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
        THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
        ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
        END AS business_year,
       ROUND(CAST(cy_month AS BIGNUMERIC), 0) AS booking_month,
       account_number,
       cost_center_desc,
       cost_center,
       pay_component,
       cost_component_desc,
       saldo_amount
      FROM ldl_s_conl_workbench.v_cost_loonjournal_post_1
      WHERE CASE
         WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
         THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
         ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
         END = 2020
       AND RIGHT(cost_center, 4) IN ('9648', '9668')) AS VJ ON LJ.business_year = VJ.business_year + 1 AND LJ.booking_month
             = VJ.booking_month + 100 AND LJ.account_number = VJ.account_number AND LJ.cost_center_desc = VJ.cost_center_desc
           AND LJ.cost_center = VJ.cost_center AND LJ.pay_component = VJ.pay_component AND LJ.cost_component_desc = VJ.cost_component_desc
       
    GROUP BY business_year,
     booking_month,
     account_number,
     cost_center_desc,
     cost_center,
     pay_component,
     cost_component_desc) AS t4) AS X
 INNER JOIN (SELECT CASE
    WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
    THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
    ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
    END AS business_year,
   MAX(ROUND(CAST(cy_month AS BIGNUMERIC), 0)) AS max_month
  FROM ldl_s_conl_workbench.v_cost_loonjournal_post_1
  WHERE CASE
     WHEN ROUND(CAST(RIGHT(cy_month, 2) AS BIGNUMERIC), 0) <= 2
     THEN ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0) - 1
     ELSE ROUND(CAST(TRUNC(CAST(LEFT(cy_month, 4) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
     END = 2021
   AND RIGHT(cost_center, 4) IN ('9648', '9668')
  GROUP BY business_year) AS RPM ON X.business_year = RPM.business_year AND X.booking_month <= RPM.max_month;
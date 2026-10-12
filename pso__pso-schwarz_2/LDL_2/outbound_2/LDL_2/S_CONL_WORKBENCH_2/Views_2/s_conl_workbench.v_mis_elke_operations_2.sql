CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mis_elke_operations_2 AS SELECT LJ.business_year,
  CASE
  WHEN LJ.report_month <= 2
  THEN ROUND(CAST(TRUNC(CAST(CONCAT(TRIM(CAST(LJ.business_year + 1 AS STRING FORMAT '0000')), TRIM(CAST(LJ.report_month AS STRING FORMAT '00'))) AS BIGNUMERIC)) AS BIGNUMERIC)
   , 0)
  ELSE ROUND(CAST(TRUNC(CAST(CONCAT(TRIM(CAST(LJ.business_year AS STRING FORMAT '0000')), TRIM(CAST(LJ.report_month AS STRING FORMAT '00')
        )) AS BIGNUMERIC)) AS BIGNUMERIC), 0)
  END AS booking_month,
 LJ.report_month,
 LJ.warehouse_number AS warehouse_id,
 LJ.net_picking_return_op AS net_picking_return_op_lj,
 VJ.net_picking_return_op AS net_picking_return_op_vj,
  LJ.net_picking_return_op - VJ.net_picking_return_op AS delta_vj_net_picking_return_op
FROM (SELECT business_year,
   report_month,
   warehouse_number,
   net_picking_return_op
  FROM ldl_s_conl_workbench.t_i_elke_operations_2
  WHERE business_year = 2020) AS LJ
 INNER JOIN (SELECT business_year,
   report_month,
   warehouse_number,
   net_picking_return_op
  FROM ldl_s_conl_workbench.t_i_elke_operations_2
  WHERE business_year = 2019) AS VJ ON LJ.report_month = VJ.report_month AND LJ.warehouse_number = VJ.warehouse_number;
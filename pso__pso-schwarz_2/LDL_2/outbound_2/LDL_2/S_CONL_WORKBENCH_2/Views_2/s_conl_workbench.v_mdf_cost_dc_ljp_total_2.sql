-- Loonjournaalposten extern
 -- Loonjournaalposten SAP
 -- Loonjournaalposten intern

CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mdf_cost_dc_ljp_total_2 AS SELECT 'Ljp' AS cost_group,
 business_year,
 booking_month,
 warehouse_nr,
 CAST(cost_center AS STRING) AS cost_center,
 CAST(cost_component_desc AS STRING) AS cost_component_desc,
 CAST(SUM(saldo_amount_lj) * - 1 AS BIGNUMERIC) AS saldo_amount_lj,
 CAST(SUM(saldo_amount_vj) * - 1 AS BIGNUMERIC) AS saldo_amount_vj
FROM ldl_s_conl_workbench.v_mdf_cost_dc_loonjournaalpost_2
GROUP BY business_year,
 booking_month,
 warehouse_nr,
 cost_center,
 cost_component_desc
UNION ALL
SELECT 'Sap' AS cost_group,
 business_year,
 booking_month,
 warehouse_nr,
 CAST(cost_center AS STRING) AS cost_center,
 CAST(cost_component_desc AS STRING) AS cost_component_desc,
 CAST(SUM(saldo_amount_lj) * - 1 AS BIGNUMERIC) AS saldo_amount_lj,
 CAST(SUM(saldo_amount_vj) * - 1 AS BIGNUMERIC) AS saldo_amount_vj
FROM ldl_s_conl_workbench.v_mdf_cost_dc_sap_2
GROUP BY business_year,
 booking_month,
 warehouse_nr,
 cost_center,
 cost_component_desc
UNION ALL
SELECT 'Extern' AS cost_group,
 business_year,
 booking_month,
 warehouse_nr,
 CAST(cost_center AS STRING) AS cost_center,
 CAST(cost_component_desc AS STRING) AS cost_component_desc,
 ROUND(CAST(SUM(saldo_amount_lj) * - 1 AS BIGNUMERIC), 5) AS saldo_amount_lj,
 ROUND(CAST(SUM(saldo_amount_vj) * - 1 AS BIGNUMERIC), 5) AS saldo_amount_vj
FROM ldl_s_conl_workbench.v_mdf_cost_dc_extern_2
GROUP BY business_year,
 booking_month,
 warehouse_nr,
 cost_center,
 cost_component_desc;
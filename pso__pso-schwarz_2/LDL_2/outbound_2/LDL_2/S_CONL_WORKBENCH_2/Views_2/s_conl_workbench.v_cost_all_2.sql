-- Negatieve kosten
 -- Negatieve kosten
 -- Negatieve kosten
 -- Negatieve kosten

CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_cost_all_2 AS SELECT cost_center,
 cy_month,
 cost_component_desc,
  SUM(saldo_amount) * - 1 AS saldo_amount
FROM ldl_s_conl_workbench.v_cost_loonjournal_post_2
GROUP BY cy_month,
 cost_center,
 cost_component_desc
UNION ALL
SELECT cost_center,
 cy_month,
 cost_component_desc,
  SUM(saldo_amount) * - 1 AS saldo_amount
FROM ldl_s_conl_workbench.v_cost_sap_2
GROUP BY cy_month,
 cost_center,
 cost_component_desc
UNION ALL
SELECT LM.cost_center,
 LM.cy_month,
 LM.cost_component_desc,
   CASE
   WHEN SUBSTR(LM.cy_month, LENGTH(LM.cy_month) - 1) = '03'
   THEN LM.saldo_amount
   ELSE COALESCE(LM.saldo_amount, 0) - COALESCE(VM.saldo_amount, 0)
   END * - 1 AS saldo_amount
FROM ldl_s_conl_workbench.v_cost_reservering_hk_meer_toeslag_2 AS LM
 LEFT JOIN ldl_s_conl_workbench.v_cost_reservering_hk_meer_toeslag_2 AS VM ON LM.cost_center = VM.cost_center AND LM.prev_month
    = CAST(VM.cy_month AS FLOAT64)
UNION ALL
SELECT cost_center,
 cy_month,
 cost_component_desc,
  SUM(saldo_amount) * - 1 AS saldo_amount
FROM ldl_s_conl_workbench.v_cost_extern_2
GROUP BY cost_center,
 cy_month,
 cost_component_desc;
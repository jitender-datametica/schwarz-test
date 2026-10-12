UPDATE idq_production_eks_calculation.execution_history_1 SET
 end_time = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHERE id = (SELECT MAX(id)
  FROM idq_production_eks_calculation.execution_history_1);
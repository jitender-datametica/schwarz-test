CREATE OR REPLACE FUNCTION idq_production_eks_calculation.getlastexecutiontime()
  RETURNS DATETIME
  AS (
    (select
    execution_history.end_time
  from
    idq_production_eks_calculation.execution_history_1
order by
  id desc nulls first
limit 1)
  )
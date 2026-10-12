CREATE OR REPLACE VIEW idq_production_dq_reports.v_dq_ldl_eks_calculation_time_rules_1 (ref_country_id, calculation_time)
AS SELECT CH.ref_country_id,
 MAX(EH.end_time) AS calculation_time
FROM idq_production_dwh.check_history_1 AS CH
 INNER JOIN idq_production_eks_calculation.execution_history_1 AS EH ON TRUE
WHERE CH.ref_source_system_type_id = 1
 AND CH.check_history_is_current = 1
GROUP BY CH.ref_country_id;
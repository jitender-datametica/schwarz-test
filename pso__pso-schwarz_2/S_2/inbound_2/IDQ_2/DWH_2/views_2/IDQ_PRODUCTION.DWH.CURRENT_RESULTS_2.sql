create or replace view IDQ_PRODUCTION.DWH.CURRENT_RESULTS_2(
	CALCULATION_TIME,
	CALCULATION_ID,
	RULE_ID,
	RULE_NAME,
	TEST_RESULT_AMOUNT,
	ERROR_AMOUNT,
	SURCE_SYSTEM_NAME,
	BRANCH_NAME,
	COUNTRY_2,
	SOURCE_SYSTEM_TYPE_NAME,
	TEST_OBJECT_TYPE,
	RULE_TECHNICAL_NAME,
	SOURCE_TABLE,
	FIELD_NAME,
	CRITICALITY_NAME,
	DIMENSION_NAME
) as

select
  ch.check_rule_by_country_calculation_time, ch.ref_time_calculation_day_id, r.ref_rule_id, r.rule_technical_name,
  ch.test_result_amount, ch.error_amount, ss.source_system_name,  b.branch_name, c.country_2, sst.source_system_type_name, tot.test_object_type_technical_name, r.rule_technical_name, f.source_table, f.field_name, cr.criticality_name, d.dimension_name
from
  dwh.check_rule_by_country_summary_2 ch,
  dwh.ref_source_system_2 ss,
  dwh.ref_branch_2 b,
  dwh.ref_country_2 c,
  dwh.ref_source_system_type_2 sst,
  dwh.ref_test_object_type_2 tot,
  dwh.ref_rule_2 r,
  dwh.ref_field_2 f,
  dwh.ref_criticality_2 cr,
  dwh.ref_dimension_2 d
where
 -- check_rule_by_country_is_current = 1 and
  ss.ref_source_system_id = ch.ref_source_system_id
  and b.ref_branch_id = ch.ref_branch_id
  and c.ref_country_id = ch.ref_country_id
  and sst.ref_source_system_type_id = ch.ref_source_system_type_id
  and tot.ref_test_object_type_id = ch.ref_test_object_type_id
  and r.ref_rule_id = ch.ref_rule_id
  and f.ref_field_id = ch.ref_field_id
  and cr.ref_criticality_id = ch.ref_criticality_id
  and d.ref_dimension_id = ch.ref_dimension_id;
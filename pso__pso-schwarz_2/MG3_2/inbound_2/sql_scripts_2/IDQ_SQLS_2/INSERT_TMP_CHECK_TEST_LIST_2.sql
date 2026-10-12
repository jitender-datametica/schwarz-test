Insert into dbo.TMP_CHECK_TEST_LIST(
scope_id,
date_of_test_run,
test_object_id,
rule_id,
is_error_detected,
test_run_day_id)
VALUES(
:scope_id,
:date_of_test_run,
:test_object_id,
:rule_id,
:is_error_detected,
:test_run_day_id)
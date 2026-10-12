INSERT INTO dbo.CHECK_TEST_LIST_CURRENT
(
scope_id
,date_of_test_run
,test_object_id
,rule_id
,is_error_detected
,test_run_day_id 
)
values
(
:scope_id
,:date_of_test_run
,:test_object_id
,:rule_id
,:is_error_detected
,:test_run_day_id 
)

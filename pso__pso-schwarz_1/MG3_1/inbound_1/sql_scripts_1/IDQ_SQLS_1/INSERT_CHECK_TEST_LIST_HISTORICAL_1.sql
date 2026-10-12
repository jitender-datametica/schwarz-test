Insert into CHECK_TEST_LIST_HISTORICAL_1
        (date_of_test_run
        ,test_object_id
        ,rule_id
        ,is_error_detected
        ,test_run_day_id)
values
        (:date_of_test_run,
         :test_object_id,
         :rule_id,
         :is_error_detected,
         :test_run_day_id);

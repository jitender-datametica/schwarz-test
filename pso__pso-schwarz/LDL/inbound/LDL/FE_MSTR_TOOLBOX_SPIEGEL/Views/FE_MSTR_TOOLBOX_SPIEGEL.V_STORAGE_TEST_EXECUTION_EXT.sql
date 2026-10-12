create or replace view LDL_PRODUCTION.FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_EXECUTION_EXT(
	CLIENT_ID,
	STORAGE_TEST_EXEC_SID,
	STORAGE_TEST_EXEC_NAME,
	END_WEEK,
	DISPLAY_END_WEEK,
	DUR_WEEK_CNT,
	MIN_TRAINING_DAY_CNT,
	SPREAD_PCT,
	TEST_NAME,
	TEST_WEEK_DURATION,
	TEST_STATUS,
	FILTER_DISPLAY_END_WEEK
) as 
SELECT client_id
,storage_test_exec_sid
,storage_test_exec_name
,end_week
,display_end_week
,dur_week_cnt
,min_training_day_cnt
,spread_pct
,test_name
,test_week_duration
,test_status
,filter_display_end_week
FROM FE_MSTR_TOOLBOX_SPIEGEL.T_STORAGE_TEST_EXECUTION_EXT
;

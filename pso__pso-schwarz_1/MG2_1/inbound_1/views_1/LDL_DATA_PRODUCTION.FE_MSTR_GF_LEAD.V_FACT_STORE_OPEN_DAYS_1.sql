create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_STORE_OPEN_DAYS_1(
	CAL_DT COMMENT 'the business date for which the store status_1 is tracked.',
	STORE_SID COMMENT 'the unique identifier (surrogate key) for a store.',
	REAL_ESTATE_SID COMMENT 'the unique identifier (surrogate key) for the real estate object.',
	COUNTRY_ORG_CD COMMENT 'the code of the business country_1 for which this country_1 organization is responsible. (the business country_1 is not identical to a political country.)',
	CURR_CD COMMENT 'the code identifying the currency according to iso-4217.',
	CURR_GROUP_FG COMMENT 'flag for group currency',
	CURR_LOCAL_FG COMMENT 'flag for local currency',
	STORE_OPEN_FG COMMENT 'an indicator showing if the store was actually open on the given day.',
	STORE_OPEN_DAYS_BYTD_CNT COMMENT 'the number of days this store has already been open in the current business year. (the business-year-to-date count of the store_open_fg)',
	STORE_OPEN_PY_FG COMMENT 'an indicator showing if the store was actually open on the same calendar_1 date one year ago.',
	STORE_OPEN_DAYS_PY_BYTD_CNT COMMENT 'the number of days this store has been open in the previous business year up to the equivalent calendar_1 date one year ago.  (the business-year-to-date count of the store_open_py_fg)',
	STORE_OPEN_PY_SWDAY_FG COMMENT 'an indicator showing if the store was actually open on the same weekday one year ago.',
	STORE_OPEN_DAYS_PY_SWDAY_BYTD_CNT COMMENT 'the number of days this store has been open in the previous business year up to the equivalent weekday one year ago.  (the business-year-to-date count of the store_open_py_swday_fg)',
	RELEVANT_FOR_COMP_FG COMMENT 'an indicator showing if the revenue which this store made on the given business date can be compared with its revenue on the equivalent day in the year before. the first week after the opening of a new store i.e. the days between the opening date and the following sunday needs to be excluded from comparison. (bereinigte steigerung)',
	RELEVANT_FOR_COMP_PY_FG COMMENT 'an indicator showing if the revenue which this store made on the same calendar_1 date one year ago can be compared with its revenue in the year before (i.e. two years ago). the first week after the opening of a new store i.e. the days between the opening date and the following sunday needs to be excluded from comparison. (bereinigte steigerung)',
	RELEVANT_FOR_COMP_PY_SWDAY_FG COMMENT 'an indicator showing if the revenue which this store made on the same weekday date one year ago can be compared with its revenue in the year before (i.e. two years ago). the first week after the opening of a new store i.e. the days between the opening date and the following sunday needs to be excluded from comparison. (bereinigte steigerung)',
	OPEN_TM COMMENT 'the time (in the local time zone) when the store opened.',
	CLOSE_TM COMMENT 'the time (in the local time zone) when the store closed.',
	OPEN_HR_CNT COMMENT 'the number of hours the store was open on the given date.',
	OPEN_HR_BYTD_CNT COMMENT 'the business-year-to-date sum of the number of hours the store has been open up to the given date.',
	OPEN_HR_PY_CNT COMMENT 'the number of hours the store was open on the equivalent calendar_1 date one year ago.',
	OPEN_HR_PY_BYTD_CNT COMMENT 'the business-year-to-date sum of the hours the store has been open up to the equivalent calendar_1 date one year ago.',
	OPEN_HR_PY_SWDAY_CNT COMMENT 'the number of hours the store was open on the equivalent weekday one year ago.',
	OPEN_HR_PY_SWDAY_BYTD_CNT COMMENT 'the business-year-to-date sum of the hours the store has been open up to the equivalent weekday one year ago.',
	EMP_HR_CNT COMMENT 'the number of hours employees have worked in this store on the given day.',
	EMP_HR_BYTD_CNT COMMENT 'the business-year-to-date sum of the number of hours employees have worked in this store up to the given date.',
	EMP_HR_PY_CNT COMMENT 'the number of hours employees have worked in this store on the equivalent calendar_1 date one year ago.',
	EMP_HR_PY_BYTD_CNT COMMENT 'the business-year-to-date sum of the number of hours employees have worked in this store up to the equivalent calendar_1 date one year ago.',
	EMP_HR_PY_SWDAY_CNT COMMENT 'the number of hours employees have worked in this store on the equivalent weekday one year ago.',
	EMP_HR_PY_SWDAY_BYTD_CNT COMMENT 'the business-year-to-date sum of the number of hours employees have worked in this store up to the equivalent weekday one year ago.',
	REAL_ESTATE_STATUS_CD COMMENT 'the code identifying the lifecycle status_1 for real estate objects. (this is the business lifecycle so it might differ from the status_1 code shown in the source system.)'
) COMMENT='This fact table shows for each day, if a store is open, and whether this day an be counted for revenue comparison (bereinigte Steigerung). (In case of new stores, the first week needs to be excluded from the comparison.) In addition, this fact tracks various status_1 attributes, as well as the number hours the store was open on that day and the number of hours, employees have worked in this store.'
 as 
SELECT 
    main.bus_dt AS cal_dt
    ,main.store_sid AS store_sid
    ,main.real_estate_sid AS real_estate_sid
    ,main.country_org_cd AS country_org_cd
    ,fer.src_curr_cd AS curr_cd
    ,DECODE(fer.src_curr_cd, 'EUR', 1, 0) AS curr_group_fg
    ,DECODE(fer.src_curr_cd, fer.tgt_curr_cd, 1, 0) AS curr_local_fg
    ,main.store_open_fg::NUMBER(38, 0) AS  store_open_fg
    ,main.store_open_days_bytd_cnt AS store_open_days_bytd_cnt
    ,main.store_open_py_fg::NUMBER(38, 0) AS store_open_py_fg
    ,main.store_open_days_py_bytd_cnt AS store_open_days_py_bytd_cnt
    ,main.store_open_py_swday_fg::NUMBER(38, 0) AS store_open_py_swday_fg
    ,main.store_open_days_py_swday_bytd_cnt AS store_open_days_py_swday_bytd_cnt
    ,main.relevant_for_comp_fg::NUMBER(38, 0) AS relevant_for_comp_fg
    ,main.relevant_for_comp_py_fg::NUMBER(38, 0) AS relevant_for_comp_py_fg
    ,main.relevant_for_comp_py_swday_fg::NUMBER(38, 0) AS relevant_for_comp_py_swday_fg
    ,main.open_tm AS open_tm
    ,main.close_tm AS close_tm
    ,main.open_hr_cnt AS open_hr_cnt
    ,main.open_hr_bytd_cnt AS open_hr_bytd_cnt
    ,main.open_hr_py_cnt AS open_hr_py_cnt
    ,main.open_hr_py_bytd_cnt AS open_hr_py_bytd_cnt
    ,main.open_hr_py_swday_cnt AS open_hr_py_swday_cnt
    ,main.open_hr_py_swday_bytd_cnt AS open_hr_py_swday_bytd_cnt
    ,main.emp_hr_cnt AS emp_hr_cnt
    ,main.emp_hr_bytd_cnt AS emp_hr_bytd_cnt
    ,main.emp_hr_py_cnt AS emp_hr_py_cnt
    ,main.emp_hr_py_bytd_cnt AS emp_hr_py_bytd_cnt
    ,main.emp_hr_py_swday_cnt AS emp_hr_py_swday_cnt
    ,main.emp_hr_py_swday_bytd_cnt AS emp_hr_py_swday_bytd_cnt
    ,main.real_estate_status_cd AS real_estate_status_cd               
FROM CORE_DIM.T_FACT_STORE_OPEN_DAYS_1 main
    INNER JOIN CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_1 co ON main.store_sid=co.int_org_sid
    INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE_1 fer ON co.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
    AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd) 
    AND fer.active_fg = TRUE 
    AND co.dwh_valid_fg;
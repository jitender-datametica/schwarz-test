create or replace view IDQ_PRODUCTION.DWH.REF_TIME_FIRST_NEG_1(
	REF_TIME_FIRST_NEGATIVE_TEST_DAY_ID,
	REF_DATE,
	WORK_DAY,
	YEAR_ID,
	YEAR_ID_DE,
	YEAR_ID_EN,
	SEMESTER_NO,
	QUARTER_NO,
	MONTH_NO,
	DAY_NO,
	DAYWEEK_NO,
	MONTH_NAME,
	MONTH_NAME_DE,
	MONTH_NAME_EN,
	DAY_NAME,
	DAY_NAME_DE,
	DAY_NAME_EN,
	CW,
	MONTH_ID,
	QUARTER_ID,
	SEMESTER_ID,
	MONTH,
	DAY_SEQ,
	MONTH_SEQ,
	QUARTER_SEQ,
	YEAR_SEQ,
	WEEK_ID,
	WEEK_NAME,
	WEEK_START
) as
select
      DAY_ID as REF_TIME_FIRST_NEGATIVE_TEST_DAY_ID
      ,REF_DATE
      ,WORK_DAY
      ,YEAR_ID
	  ,YEAR_ID as YEAR_ID_DE
	  ,YEAR_ID as YEAR_ID_EN
      ,SEMESTER_NO
      ,QUARTER_NO
      ,MONTH_NO
      ,DAY_NO
      ,DAYWEEK_NO
      ,MONTH_NAME
	  ,MONTH_NAME as MONTH_NAME_DE
      ,MONTH_NAME_EN
      ,DAY_NAME
	  ,DAY_NAME as DAY_NAME_DE
      ,DAY_NAME_EN
      ,CW
      ,MONTH_ID
      ,QUARTER_ID
      ,SEMESTER_ID
      ,MONTH
      ,DAY_SEQ
      ,MONTH_SEQ
      ,QUARTER_SEQ
      ,YEAR_SEQ
      ,case --case
       when length(concat(YEAR_ID,CW)) < 6  -- when length(concat(date_part(year,to_date(DATEADD(dd, -(DAYWEEK_NO-1), ref_date))),weekiso(ref_date))) < 6
       then concat(YEAR_ID,'0',CW)          -- then concat(date_part(year,to_date(DATEADD(dd, -(DAYWEEK_NO-1), ref_date))),'0',weekiso(ref_date))
       else concat(YEAR_ID,CW)-- else concat(date_part(year,to_date(DATEADD(dd, -(DAYWEEK_NO-1), ref_date) )),weekiso(ref_date))
      end as WEEK_ID
      ,concat('W',CW,', ',YEAR_ID) -- concat('W',weekiso(ref_date),', ',date_part(year,to_date(DATEADD(dd, -(DAYWEEK_NO-1), ref_date))))
      as WEEK_NAME
      ,to_date(DATEADD(dd, -(DAYWEEK_NO-1), ref_date)) as WEEK_START

from IDQ_RESULTS.REF_TIME_1;
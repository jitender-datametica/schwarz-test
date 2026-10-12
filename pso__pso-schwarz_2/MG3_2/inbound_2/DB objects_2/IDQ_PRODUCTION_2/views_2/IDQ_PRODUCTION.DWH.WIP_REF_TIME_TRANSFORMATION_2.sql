create or replace view IDQ_PRODUCTION.DWH.WIP_REF_TIME_TRANSFORMATION_2(
	DAY_ID,
	DAY_ID_YESTERDAY,
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
	MONTH1,
	DAY_SEQ,
	MONTH_SEQ,
	QUARTER_SEQ,
	YEAR_SEQ,
	WEEK_ID,
	WEEK_NAME,
	WEEK_START
) as
SELECT a.DAY_ID
	,b.DAY_ID AS DAY_ID_Yesterday
      ,a.REF_DATE
      ,a.WORK_DAY
      ,a.YEAR_ID
	  ,a.YEAR_ID as YEAR_ID_DE
	  ,a.YEAR_ID as YEAR_ID_EN
      ,a.SEMESTER_NO
      ,a.QUARTER_NO
      ,a.MONTH_NO
      ,a.DAY_NO
      ,a.DAYWEEK_NO
      ,a.MONTH_NAME
	  ,a.MONTH_NAME as MONTH_NAME_DE
      ,a.MONTH_NAME_EN
      ,a.DAY_NAME
	  ,a.DAY_NAME as DAY_NAME_DE
      ,a.DAY_NAME_EN
      ,a.CW
      ,a.MONTH_ID
      ,a.QUARTER_ID
      ,a.SEMESTER_ID
      ,a.MONTH
      ,a.DAY_SEQ
      ,a.MONTH_SEQ
      ,a.QUARTER_SEQ
      ,a.YEAR_SEQ
    ,cast(case
when len(concat(year(cast(DATEADD(DAY, -(a.DAYWEEK_NO-1), a.ref_date) as date)),weekiso(a.ref_date))) < 6
then concat(year(cast(DATEADD(dd, -(a.DAYWEEK_NO-1), a.ref_date) as date)),'0',weekiso(a.ref_date))
else concat(year(cast(DATEADD(dd, -(a.DAYWEEK_NO-1), a.ref_date) as date)),weekiso(a.ref_date))
end as int) as WEEK_ID
,concat('W',weekiso(a.ref_date),', ',year(cast(DATEADD(dd, -(a.DAYWEEK_NO-1), a.ref_date) as date))) as WEEK_NAME
,cast(DATEADD(dd, -(a.DAYWEEK_NO-1), a.ref_date) as date) as WEEK_START

FROM IDQ_RESULTS.REF_TIME_2 a
join IDQ_RESULTS.REF_TIME_2 b
on a.DAY_SEQ=b.DAY_SEQ+1
;
CREATE OR REPLACE VIEW FE_MSTR_NFMD.MV_LOOKUP_DATES_1 AS (
	with base_Date AS (
		select
		date_part(yearofweek_iso, d) year_iso,
		date_part(week_iso, d) week_iso,
		min(d) first_day,
		min(d)+3 AS thursday_of_week
		from (
		select dateadd(day, row_number() over (order by 1) - 1, '2018-01-03'::date) AS d
		from table(generator(rowCount=>10000))
		)
		group by 1, 2 order by 1,2
	)
	Select year_iso, 
         week_iso, 
         first_day, 
         thursday_of_week,
         DATEDIFF('week',first_day,CURRENT_DATE())*-1 AS akt_wo, -- is the same as promotion_week_x_weeks_ago
         year_iso ||to_char(week_iso,'fm00') as      KJWO -- YYYYWW 
  from base_date
  where year_iso >= 2021 --> because we only show year 2021 at the Frontend 
)
	;

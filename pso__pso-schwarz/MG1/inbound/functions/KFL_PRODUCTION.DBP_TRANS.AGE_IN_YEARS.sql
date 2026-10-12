CREATE OR REPLACE FUNCTION KFL_PRODUCTION.DBP_TRANS.AGE_IN_YEARS("START_DATE" DATE, "END_DATE" DATE)
RETURNS NUMBER(38,0)
LANGUAGE SQL
AS '

case when dateadd(year, datediff(years, start_date, end_date), start_date) > end_date

   then datediff(years, start_date, end_date) -1

   else datediff(years, start_date, end_date)

end

';
CREATE OR REPLACE FUNCTION snowconvert_public.day_of_week_long(val2 DATETIME) RETURNS STRING
AS (
CASE EXTRACT(DAYOFWEEK FROM val2)
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
    ELSE 'None'
  END
);
CREATE OR REPLACE FUNCTION snowconvert_public.month_name_long(val2 DATETIME) RETURNS STRING
AS (
CASE FORMAT_DATETIME('%b', val2) -- '%b' gets the short month name (Jan, Feb, etc.)
    WHEN 'Jan' THEN 'January'
    WHEN 'Feb' THEN 'February'
    WHEN 'Mar' THEN 'March'
    WHEN 'Apr' THEN 'April'
    WHEN 'May' THEN 'May'
    WHEN 'Jun' THEN 'June'
    WHEN 'Jul' THEN 'July'
    WHEN 'Aug' THEN 'August'
    WHEN 'Sep' THEN 'September'
    WHEN 'Oct' THEN 'October'
    WHEN 'Nov' THEN 'November'
    WHEN 'Dec' THEN 'December'
    ELSE 'None'
  END
);
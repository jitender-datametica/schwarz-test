CREATE OR REPLACE FUNCTION UDF_SCHEMA.MONTHS_BETWEEN(date1 DATE, date2 DATE) AS (
CASE
    -- If days are same or both are last day of month, return integer difference
    WHEN EXTRACT(DAY FROM date1) = EXTRACT(DAY FROM date2) OR
         (date1 = LAST_DAY(date1) AND date2 = LAST_DAY(date2))
      THEN DATE_DIFF(date1, date2, MONTH)
    
    -- Otherwise, calculate fractional difference based on 31-day month (Snowflake standard)
    ELSE
      DATE_DIFF(date1, date2, MONTH) +
      (EXTRACT(DAY FROM date1) - EXTRACT(DAY FROM date2)) / 31.0
  END
);

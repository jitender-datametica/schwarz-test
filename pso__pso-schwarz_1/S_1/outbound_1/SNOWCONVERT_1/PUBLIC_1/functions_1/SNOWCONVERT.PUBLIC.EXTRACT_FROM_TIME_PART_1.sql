CREATE OR REPLACE FUNCTION snowconvert_public.extract_from_time_part(TS_INTERVAL INT64, TS_INTERVAL_PART STRING) RETURNS INT64 AS (
CASE UPPER(TS_INTERVAL_PART)
    -- 1 Year = 12 * 30 * 24 * 60 * 60 = 31,104,000 Seconds
    WHEN 'YEAR' THEN 
      DIV(TS_INTERVAL, 31104000)
    
    -- 1 Month = 30 * 24 * 60 * 60 = 2,592,000 Seconds
    -- Logic: Total Months % 12
    WHEN 'MONTH' THEN 
      MOD(DIV(TS_INTERVAL, 2592000), 12)
    
    -- 1 Day = 24 * 60 * 60 = 86,400 Seconds
    -- Logic: Total Days % 30
    WHEN 'DAY' THEN 
      MOD(DIV(TS_INTERVAL, 86400), 30)
    
    -- 1 Hour = 60 * 60 = 3,600 Seconds
    -- Logic: Total Hours % 24
    WHEN 'HOUR' THEN 
      MOD(DIV(TS_INTERVAL, 3600), 24)
    
    -- 1 Minute = 60 Seconds
    -- Logic: Total Minutes % 60
    WHEN 'MINUTE' THEN 
      MOD(DIV(TS_INTERVAL, 60), 60)
    
    -- Logic: Total Seconds % 60
    WHEN 'SECOND' THEN 
      MOD(TS_INTERVAL, 60)
      
    ELSE NULL
  END
);

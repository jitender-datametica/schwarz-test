CREATE OR REPLACE FUNCTION snowconvert_public.months_between_udf(input_1 TIMESTAMP, input_2 TIMESTAMP) RETURNS NUMERIC AS (
CAST((
  -- Block 1: Calculate Base Months using DATETIME_DIFF
  CASE 
     WHEN EXTRACT(DAY FROM input_2) <= EXTRACT(DAY FROM input_1) 
     THEN DATETIME_DIFF(DATETIME(input_1), DATETIME(input_2), MONTH)
     ELSE DATETIME_DIFF(DATETIME(input_1), DATETIME(input_2), MONTH) - 1 
   END) 
   + 
  -- Block 2: Day Fraction (Normalized to 31 days)
  (CASE 
     WHEN EXTRACT(DAY FROM input_2) = EXTRACT(DAY FROM input_1) THEN 0
     WHEN EXTRACT(DAY FROM input_2) < EXTRACT(DAY FROM input_1) AND TIME(input_2) > TIME(input_1) 
       THEN EXTRACT(DAY FROM input_1) - EXTRACT(DAY FROM input_2) - 1
     WHEN EXTRACT(DAY FROM input_2) <= EXTRACT(DAY FROM input_1) 
       THEN EXTRACT(DAY FROM input_1) - EXTRACT(DAY FROM input_2) 
     ELSE 31 - EXTRACT(DAY FROM input_2) + EXTRACT(DAY FROM input_1) 
   END / 31) 
   +
  -- Block 3: Hour Fraction
  (CASE 
     WHEN EXTRACT(DAY FROM input_2) = EXTRACT(DAY FROM input_1) THEN 0
     WHEN EXTRACT(HOUR FROM input_2) <= EXTRACT(HOUR FROM input_1) 
       THEN EXTRACT(HOUR FROM input_1) - EXTRACT(HOUR FROM input_2) 
     ELSE 24 - EXTRACT(HOUR FROM input_2) + EXTRACT(HOUR FROM input_1) 
   END / (24*31)) 
   +   
  -- Block 4: Minute Fraction
  (CASE 
      WHEN EXTRACT(DAY FROM input_2) = EXTRACT(DAY FROM input_1) THEN 0
      WHEN EXTRACT(MINUTE FROM input_2) <= EXTRACT(MINUTE FROM input_1) 
        THEN EXTRACT(MINUTE FROM input_1) - EXTRACT(MINUTE FROM input_2)
      ELSE 24 - EXTRACT(HOUR FROM input_2) + EXTRACT(MINUTE FROM input_1) 
   END / (24*60*31)) 
   +
  -- Block 5: Second Fraction
  (CASE 
      WHEN EXTRACT(DAY FROM input_2) = EXTRACT(DAY FROM input_1) THEN 0
      WHEN EXTRACT(MINUTE FROM input_2) <= EXTRACT(MINUTE FROM input_1) 
        THEN EXTRACT(MINUTE FROM input_1) - EXTRACT(MINUTE FROM input_2)
      ELSE 24 - EXTRACT(HOUR FROM input_2) + EXTRACT(MINUTE FROM input_1) 
   END / (24*60*60*31))
   as NUMERIC)
);

CREATE OR REPLACE FUNCTION snowconvert_public.time_part_to_variant(TS_INTERVAL INT64) AS (
JSON_OBJECT(
    'YEAR', snowconvert_public.extract_from_time_part(TS_INTERVAL, 'YEAR'),
    'MONTH', snowconvert_public.extract_from_time_part(TS_INTERVAL, 'MONTH'),
    'DAY', snowconvert_public.extract_from_time_part(TS_INTERVAL, 'DAY'),
    'HOUR', snowconvert_public.extract_from_time_part(TS_INTERVAL, 'HOUR'),
    'MINUTE', snowconvert_public.extract_from_time_part(TS_INTERVAL, 'MINUTE'),
    'SECOND', snowconvert_public.extract_from_time_part(TS_INTERVAL, 'SECOND')
  )
);

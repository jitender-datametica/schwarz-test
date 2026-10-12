CREATE OR REPLACE FUNCTION `idq_production_dq_reports.getcountryid_ltlv_workaround`(
  i STRING,
  j INT64
)
RETURNS INT64
AS (
  CASE
    WHEN i = 'BE' THEN 2
    WHEN i = 'BG' THEN 3
    WHEN i = 'CY' THEN 4
    WHEN i = 'DE' THEN 5
    WHEN i = 'DK' THEN 6
    WHEN i = 'FI' THEN 7
    WHEN i = 'FR' THEN 8
    WHEN i = 'GR' THEN 9
    WHEN i = 'GB' THEN 10
    WHEN i = 'NL' THEN 11
    WHEN i = 'IE' THEN 12
    WHEN i = 'IT' THEN 13
    WHEN i = 'CS' THEN 14
    WHEN i = 'HR' THEN 15
    WHEN i = 'LT' THEN 16
    WHEN i = 'MT' THEN 17
    WHEN i = 'NIE' THEN 18
    WHEN i = 'AT' THEN 19
    WHEN i = 'PL' THEN 20
    WHEN i = 'PT' THEN 21
    WHEN i = 'RO' THEN 22
    WHEN i = 'SE' THEN 23
    WHEN i = 'CH' THEN 24
    WHEN i = 'RS_2' THEN 25
    WHEN i = 'SK' THEN 26
    WHEN i = 'SI' THEN 27
    WHEN i = 'ES' THEN 28
    WHEN i = 'CZ' THEN 29
    WHEN i = 'HU' THEN 30
    WHEN i = 'US' THEN 31

    WHEN i = 'LV' AND SUBSTR(CAST(j AS STRING), 1, 2) = '79' THEN 33
    WHEN i = 'LV' AND SUBSTR(CAST(j AS STRING), 1, 2) = '78' THEN 34

    WHEN i = 'EE' THEN 33
    WHEN i = 'LV' THEN 34

    ELSE 1
  END
);

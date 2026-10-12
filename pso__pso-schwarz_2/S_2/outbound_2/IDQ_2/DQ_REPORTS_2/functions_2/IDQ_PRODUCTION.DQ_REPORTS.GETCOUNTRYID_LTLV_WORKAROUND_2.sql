CREATE OR REPLACE FUNCTION idq_production_dq_reports.getcountryid_ltlv_workaround(
  I STRING,
  J BIGNUMERIC
)
RETURNS BIGNUMERIC
AS (
  CASE
    WHEN I = 'BE' THEN 2
    WHEN I = 'BG' THEN 3
    WHEN I = 'CY' THEN 4
    WHEN I = 'DE' THEN 5
    WHEN I = 'DK' THEN 6
    WHEN I = 'FI' THEN 7
    WHEN I = 'FR' THEN 8
    WHEN I = 'GR' THEN 9
    WHEN I = 'GB' THEN 10
    WHEN I = 'NL' THEN 11
    WHEN I = 'IE' THEN 12
    WHEN I = 'IT' THEN 13
    WHEN I = 'CS' THEN 14
    WHEN I = 'HR' THEN 15
    WHEN I = 'LT' THEN 16
    WHEN I = 'MT' THEN 17
    WHEN I = 'NIE' THEN 18
    WHEN I = 'AT' THEN 19
    WHEN I = 'PL' THEN 20
    WHEN I = 'PT' THEN 21
    WHEN I = 'RO' THEN 22
    WHEN I = 'SE' THEN 23
    WHEN I = 'CH' THEN 24
    WHEN I = 'RS_2' THEN 25
    WHEN I = 'SK' THEN 26
    WHEN I = 'SI' THEN 27
    WHEN I = 'ES' THEN 28
    WHEN I = 'CZ' THEN 29
    WHEN I = 'HU' THEN 30
    WHEN I = 'US' THEN 31

    -- LV workaround logic (order preserved)
    WHEN I = 'LV' AND SUBSTR(CAST(J AS STRING), 1, 2) = '79' THEN 33
    WHEN I = 'LV' AND SUBSTR(CAST(J AS STRING), 1, 2) = '78' THEN 34

    WHEN I = 'EE' THEN 33
    WHEN I = 'LV' THEN 34

    ELSE 1
  END
);

